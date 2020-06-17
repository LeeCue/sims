package com.xust.sims.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xust.sims.dao.CourseMapper;
import com.xust.sims.dto.ScheduleConfig;
import com.xust.sims.dto.SelectCourse;
import com.xust.sims.entity.Course;
import com.xust.sims.threadconfig.CloseCourseThread;
import com.xust.sims.utils.UrlEncodeUtils;
import com.xust.sims.web.aspect.ScriptAspect;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.Jedis;

import java.time.Duration;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@Service
@Slf4j
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private ScheduledExecutorService scheduledExecutorService;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private RedisConnectionFactory redisConnectionFactory;

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void addCourse(Course course) {
        course.setCreateTime(new Date());
        course.setUpdateTime(new Date());
        courseMapper.addCourse(course);
    }

    @Override
    public List<Course> findCourse(SelectCourse selectCourse) {
        return courseMapper.findCourse(selectCourse);
    }

    @Override
    public JSON findCommonCourseInCache(int pageSize, int currPage) {
        JSONObject json = new JSONObject();
        List<Course> res = new ArrayList<>();
        Long total = redisTemplate.opsForList().size("select_course_ids");
        long start = pageSize * (currPage - 1);
        long offset = (pageSize * (currPage - 1)) + pageSize;
        List<Object> courseIds = redisTemplate.opsForList().range("select_course_ids", start, offset - 1);
        for (Object courseId : courseIds) {
            Course course = (Course) redisTemplate.opsForValue().get("course_" + courseId);
            Integer num = (Integer) redisTemplate.opsForValue().get("course_left_num_" + courseId);
            course.setLeftNum(num);
            res.add(course);
        }
        json.put("courseList", res);
        json.put("total", total);
        return json;
    }

    @Override
    public JSON getSelectCourseUrlSign() {
        JSONObject json = new JSONObject();
        if (redisTemplate.opsForValue().get("disabled_select") != null) {
            json.put("status", 408);
            json.put("msg", "当前不能选择课程，选课时间还没到");
            return json;
        }
        String sign = null;
        if (redisTemplate.hasKey("sign")) {
            log.info("第一次之后请求sign，从缓存中获取!");
            sign = ((String) redisTemplate.opsForValue().get("sign"));
        } else {
            log.info("第一次请求sign，生成并添加到cache中");
            sign = UrlEncodeUtils.getUrlSign("/select/course");
            redisTemplate.opsForValue().set("sign", sign, Duration.ofMinutes(3L));
        }
        json.put("status", 210);
        json.put("sign", sign);
        return json;
    }

    @Override
    @Async
    public CompletableFuture<JSON> studentSelectCourseByCid(String studentId, int cid, String sign) {
        JSONObject json = new JSONObject();
        String cacheSign = (String) redisTemplate.opsForValue().get("sign");
        if (!sign.equals(cacheSign)) {
            json.put("status", 409);
            json.put("msg", "签名值认证失败");
            return CompletableFuture.completedFuture(json);
        }
        Jedis jedis = null;
        try {
            jedis = (Jedis) redisConnectionFactory.getConnection().getNativeConnection();
            String sha = ScriptAspect.shaCourseValue;
            log.info("要获取的sha值为：{}", sha);
            List<String> keyList = new ArrayList<>(2);
            keyList.add(Integer.toString(cid));
            List<String> valueList = new ArrayList<>(2);
            valueList.add(studentId);
            Long res = ((Long) jedis.evalsha(sha, keyList, valueList));
            if (res == -2) {
                json.put("status", 411);
                json.put("msg", "你已经选择过该门课程，不能重复选取！");
            } else if (res == -1) {
                json.put("status", 410);
                json.put("msg", "该门课程目前已满，请稍后重试！");
            } else if (res == 1) {
                json.put("status", 211);
                json.put("msg", "抢课成功！！！");
            }
            log.info("抢课结果为：{} {}", res, res.getClass().getName());
        } finally {
            assert jedis != null;
            jedis.close();
        }
        return CompletableFuture.completedFuture(json);
    }

    @Override
    public List<Course> getSelectedCourse(String studentId) {
        List<Object> idList = redisTemplate.opsForList().range("student_selected_course_" + studentId, 0, -1);
        List<Course> courseList = new ArrayList<>();
        for (Object id : idList) {
            courseList.add(((Course) redisTemplate.opsForValue().get("course_" + id)));
        }
        return courseList;
    }

    @Override
    public void cancelSelectedCourse(String studentId, int cid) {
        try (Jedis jedis = (Jedis) redisConnectionFactory.getConnection().getNativeConnection()) {
            List<String> keyList = new ArrayList<>(2);
            keyList.add(Integer.toString(cid));
            List<String> valueList = new ArrayList<>(2);
            valueList.add(studentId);
            jedis.evalsha(ScriptAspect.shaCancelCourseValue, keyList, valueList);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void courseConfig(ScheduleConfig config) {
        courseMapper.addCourseConfig(config);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void deleteCourseById(Integer id) {
        courseMapper.deleteCourseInfoById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public boolean openCourseSystem(Date startTime, Date endTime, int[] academyIds) {
        /**
         * 1. 打开学院的选课权限
         * 2. 设置选择的开始时间 Redis 键 （TTL为 startTime - currTime）
         * 3. 课程信息预热：
         *      1. 添加所有课程性质为 公选的 id 到 list
         *      2. 存储课程信息 string - object
         *      3. 课程剩余数量 string - int
         * 4. 设定系统的关闭时间 时间为 endTime - currTime
         *      1. 删除课程 id List
         *      2. 更新学院的选择状态
         */
        List<Course> commonCourse = courseMapper.getCommonCourse();
        log.info("是否含有 select_course_ids：{}", redisTemplate.hasKey("select_course_ids"));
        if (redisTemplate.hasKey("select_course_ids")) {
            return false;
        }
        if (commonCourse.isEmpty()) {
            return false;
        }
        try {
            changeSelectFlagByAcademyIds(academyIds);
            Date currTime = new Date();
            redisTemplate.opsForValue().set("disabled_select", "", startTime.getTime() - currTime.getTime(), TimeUnit.MILLISECONDS);
            List<Integer> courseIds = commonCourseIds(commonCourse);
            for (Integer courseId : courseIds) {
                redisTemplate.opsForList().rightPush("select_course_ids", courseId);
            }
            //TODO 可以将这些Redis插入操作，放到一个pipeline中，减少网络请求数
            for (Course course : commonCourse) {
                redisTemplate.opsForValue().set("course_" + course.getId(), course, endTime.getTime() - currTime.getTime(), TimeUnit.MILLISECONDS);
                redisTemplate.opsForValue().set("course_left_num_" + course.getId(), course.getTotal(), endTime.getTime() - currTime.getTime(), TimeUnit.MILLISECONDS);
            }
            CloseCourseThread thread = new CloseCourseThread(commonCourse, this);
            log.info("开启定时任务关闭选课系统");
            scheduledExecutorService.schedule(thread,
                    endTime.getTime() - currTime.getTime(), TimeUnit.MILLISECONDS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void closeCourseSystem(List<Course> courseList) {
        try {
            Set<String> keys = new HashSet<>();
            keys.add("select_course_ids");
            Map<Object, Set<Object>> courseToStudentId = new HashMap<>();
            Set<Integer> courseIds = new HashSet<>();
            List<Object> selectCourseIds = redisTemplate.opsForList().range("select_course_ids", 0, -1);
            log.info("课程列表为：{}", selectCourseIds);
            for (Object courseId : selectCourseIds) {
                log.info("课程ID类型为：{}", courseId.getClass().getName());
                Set<Object> members = redisTemplate.opsForSet().members("course_selected_student_" + courseId);
                log.info("当前课程为：{} 选择的人为：{}", courseId, members);
                for (Object studentId : members) {
                    log.info("学生ID类型为：{}", studentId.getClass().getName());
                    keys.add("student_selected_course_" + studentId);
                }
                courseToStudentId.put(courseId, members);
                courseIds.add(((Integer) courseId));
                keys.add("course_selected_student_" + courseId);
            }

            log.info("课程和学生对应关系为：{}", courseToStudentId);
            for (Map.Entry<Object, Set<Object>> entry : courseToStudentId.entrySet()) {
                if (!entry.getValue().isEmpty()) {
                    courseMapper.addStudentCommonCourse(entry.getKey(), entry.getValue());
                }
            }

            //删除存储在redis的keyList\
            log.info("要删除keyList: {}", keys);
            redisTemplate.delete(keys);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            courseMapper.closeAllCourseSystem();
        }
    }

    private List<Integer> commonCourseIds(List<Course> courses) {
        List<Integer> ids = new ArrayList<>();
        for (Course course : courses) {
            ids.add(course.getId());
        }
        return ids;
    }

    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void changeSelectFlagByAcademyIds(int[] academyIds) {
        if (academyIds == null || academyIds.length == 0) {
            courseMapper.openAllCourseSystem();
        } else {
            courseMapper.openCourseSystemByAcademyIds(academyIds);
        }
    }
}
