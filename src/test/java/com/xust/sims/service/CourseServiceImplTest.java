package com.xust.sims.service;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

/**
 * @author LeeCue
 * @date 2020-06-17
 */
@SpringBootTest
@Slf4j
class CourseServiceImplTest {
    @Autowired
    CourseService courseService;
    @Test
    void getSelectCourseUrlSign() {
        courseService.getSelectCourseUrlSign();
    }
}