package com.xust.sims.web.controller;

import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Teacher;
import com.xust.sims.service.TeacherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@RestController
@RequestMapping("/web")
@Slf4j
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    @GetMapping("/teacher/getByAcademyId")
    @Secured({"ROLE_admin"})
    public List<Teacher> getTeacherByAcademyId(@RequestParam("academyId") Integer academyId) {
        return teacherService.getTeacherInfoByAcademyId(academyId);
    }

    @GetMapping("/academy/teacherInfo")
    @Secured({"ROLE_admin"})
    public List<Academy> getAcademyWithTeacherInfo() {
        return teacherService.getAcademyWithTeacherInfo();
    }
}
