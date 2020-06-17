package com.xust.sims.threadconfig;

import com.xust.sims.entity.Course;
import com.xust.sims.service.CourseService;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-16
 */
public class CloseCourseThread implements Runnable{
    private final List<Course> courseList;
    private final CourseService courseService;

    public CloseCourseThread(List<Course> courseList, CourseService courseService) {
        this.courseList = courseList;
        this.courseService = courseService;
    }

    @Override
    public void run() {
        courseService.closeCourseSystem(courseList);
    }
}
