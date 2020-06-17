package com.xust.sims.service;

import com.alibaba.fastjson.JSON;
import com.xust.sims.dto.ScheduleConfig;
import com.xust.sims.dto.SelectCourse;
import com.xust.sims.entity.Course;

import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
public interface CourseService {
    /**
     * 增设课程
     * @param course
     */
    void addCourse(Course course);

    /**
     * 根据查询课程条件，来 search 课程
     * @param selectCourse
     * @return
     */
    List<Course> findCourse(SelectCourse selectCourse);

    /**
     * 获取缓存中的课程信息（分页查询）
     * @return
     */
    JSON findCommonCourseInCache(int pageSize, int currPage);

    /**
     * 获取抢课地址签名值（前提，选课已经开启）
     * @return
     */
    JSON getSelectCourseUrlSign();

    /**
     * 对比签名值，如果一致则调用抢课逻辑，否则返回签名值比对失败
     * @param studentId
     * @param cid
     * @param sign
     * @return
     */
    CompletableFuture<JSON> studentSelectCourseByCid(String studentId, int cid, String sign);

    /**
     * 通过学生id，获取已经选择的课程（选课系统开放时）
     * @param studentId
     * @return
     */
    List<Course> getSelectedCourse(String studentId);

    /**
     * 根据学生 id、课程 cid 退选课程
     * @param studentId
     * @param cid
     */
    void cancelSelectedCourse(String studentId, int cid);

    /**
     * 教学计划配置
     * @param config
     */
    void courseConfig(ScheduleConfig config);

    /**
     * 通过课程id删除课程信息
     * @param id
     */
    void deleteCourseById(Integer id);

    /**
     * 开设选课系统，根据学院开启，并预热课程信息
     * @param startTime
     * @param endTime
     * @param academyIds
     * @return 是否开启成功
     */
    boolean openCourseSystem(Date startTime, Date endTime, int[] academyIds);

    /**
     * 关闭选课系统
     * @param courseList
     */
    void closeCourseSystem(List<Course> courseList);
}
