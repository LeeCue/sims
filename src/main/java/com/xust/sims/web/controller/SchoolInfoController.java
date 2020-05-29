package com.xust.sims.web.controller;

import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Class;
import com.xust.sims.entity.Major;
import com.xust.sims.service.SchoolInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-05-04
 */
@RequestMapping("/web")
@RestController
@Slf4j
public class SchoolInfoController {
    @Autowired
    private SchoolInfoService schoolInfoService;

    @GetMapping("/academy/initAll")
    public List<Academy> initAllAcademies() {
        return schoolInfoService.getAllAcademies();
    }

    @GetMapping("/academy/getByMajorId")
    public Academy initAcademyByMajorId(Integer majorId) {
        return schoolInfoService.getAcademyByMajorId(majorId);
    }

    @GetMapping("/major/getByAcademyId")
    public List<Major> initMajorsByAcademyId(Integer academyId) {
        return schoolInfoService.getMajorsByAcademyId(academyId);
    }

    @GetMapping("/major/initAll")
    public List<Major> initAllMajors() {
        return schoolInfoService.getAllMajors();
    }

    @GetMapping("/class/getByMajorId")
    public List<Class> initClassByMajorId(Integer majorId) {
        return schoolInfoService.getClassByMajorId(majorId);
    }
}
