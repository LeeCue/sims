package com.xust.sims.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xust.sims.dto.RespBean;
import com.xust.sims.dto.ResponseCode;
import com.xust.sims.dto.ScheduleConfig;
import com.xust.sims.dto.SelectCourse;
import com.xust.sims.entity.Course;
import com.xust.sims.service.CourseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@RestController
@RequestMapping("/web")
@Slf4j
public class CourseController {
    @Autowired
    private CourseService courseService;

    @PostMapping("/add/course")
    @Secured({"ROLE_admin"})
    public RespBean addCourse(@Valid @RequestBody Course course, BindingResult result) {
        if (result.hasErrors()) {
            StringBuilder sb = new StringBuilder();
            for (ObjectError error : result.getAllErrors()) {
                sb.append(error.getDefaultMessage()).append(";");
            }
            return new RespBean(ResponseCode.ERROR, sb.toString());
        }
        courseService.addCourse(course);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/init/courseInfo")
    @Secured({"ROLE_user"})
    public PageInfo<Course> initCourseInfo(@RequestBody SelectCourse selectCourse) {
        PageHelper.startPage(selectCourse.getCurrPage(), selectCourse.getPageSize());
        List<Course> temp = courseService.findCourse(selectCourse);
        return new PageInfo<>(temp);
    }

    @GetMapping("/getCacheCourse")
    @Secured({"ROLE_admin", "ROLE_student"})
    public JSON getCacheCourseInfo(@RequestParam("pageSize") int pageSize,
                                   @RequestParam("currPage") int currPage) {
        return courseService.findCommonCourseInCache(pageSize, currPage);
    }

    @GetMapping("/select/course")
    @Secured({"ROLE_admin", "ROLE_student"})
    public JSON selectCourse(@RequestParam("sign") String sign,
                             @RequestParam("cid") int cid,
                             Principal principal) {
        CompletableFuture<JSON> future = courseService.studentSelectCourseByCid(principal.getName(), cid, sign);
        JSON res = null;
        try {
            res = future.get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            res = new JSONObject();
            ((JSONObject) res).put("status", 490);
            ((JSONObject) res).put("msg", "当前人数太多，请稍后再试");
        }
        return res;
    }

    @GetMapping("/get/selectedCourse")
    @Secured({"ROLE_admin", "ROLE_student"})
    public List<Course> getSelectedCourse(Principal principal) {
        return courseService.getSelectedCourse(principal.getName());
    }

    @GetMapping("/cancel/selectedCourse")
    @Secured({"ROLE_admin", "ROLE_student"})
    public RespBean cancelSelectCourse(@RequestParam("cid") int cid, Principal principal) {
        courseService.cancelSelectedCourse(principal.getName(), cid);
        return new RespBean(ResponseCode.SUCCESS);
    }


    @GetMapping("/beforeSelect")
    @Secured({"ROLE_admin", "ROLE_student"})
    public JSON getSelectCourseUrlSign() {
        return courseService.getSelectCourseUrlSign();
    }

    @DeleteMapping("/course/{id}")
    @Secured({"ROLE_admin"})
    public RespBean deleteCourseInfo(@PathVariable("id") Integer courseId) {
        courseService.deleteCourseById(courseId);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/schedule/courseConfig")
    @Secured({"ROLE_admin"})
    public RespBean configCourse(@RequestBody ScheduleConfig scheduleConfig) {
        log.info("获取的配置信息为：{}", scheduleConfig);
        courseService.courseConfig(scheduleConfig);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/openSystem/config")
    @Secured({"ROLE_admin"})
    public RespBean openSelectCourseSystem(@RequestParam("startTime") Date startTime,
                                           @RequestParam("endTime") Date endTime,
                                           @RequestParam("selectAll") boolean selectAll,
                                           @RequestParam("selectAcademies") int[] academyIds) {
        log.info("获取的信息为：{}、{}、{}、{}", startTime, endTime, selectAll, Arrays.toString(academyIds));
        if (courseService.openCourseSystem(startTime, endTime, academyIds)) {
            return new RespBean(ResponseCode.SUCCESS);
        } else {
            return new RespBean(ResponseCode.ERROR);
        }
    }
}
