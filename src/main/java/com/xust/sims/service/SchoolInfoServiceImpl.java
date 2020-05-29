package com.xust.sims.service;

import com.xust.sims.dao.AcademyMapper;
import com.xust.sims.dao.ClassMapper;
import com.xust.sims.dao.MajorMapper;
import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Class;
import com.xust.sims.entity.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author LeeCue
 * @date 2020-05-04
 */
@Service
public class SchoolInfoServiceImpl implements SchoolInfoService {
    @Autowired
    private AcademyMapper academyMapper;
    @Autowired
    private MajorMapper majorMapper;
    @Autowired
    private ClassMapper classMapper;

    @Override
    public List<Academy> getAllAcademies() {
        return academyMapper.findAllAcademyInfo();
    }

    @Override
    public Academy getAcademyByMajorId(Integer majorId) {
        Academy academy = null;
        if (majorId == null) {
            academy = new Academy();
        } else {
            academy = academyMapper.findAcademyByMajorId(majorId);
        }
        return academy;
    }

    @Override
    public Class getClassInfoByClassId(Integer classId) {
        return classMapper.findClassBaseInfoById(classId);
    }

    @Override
    public List<Major> getAllMajors() {
        return majorMapper.findAllMajors();
    }

    @Override
    public List<Major> getMajorsByAcademyId(Integer academyId) {
        List<Major> majors = null;
        if (academyId == null) {
            majors = new ArrayList<>();
        } else {
            majors = majorMapper.findMajorsByAcademyId(academyId);
        }
        return majors;
    }

    @Override
    public List<Class> getClassByMajorId(Integer majorId) {
        List<Class> classes = null;
        if (majorId == null) {
            classes = new ArrayList<>();
        } else {
            classes = classMapper.findClassByMajorId(majorId);
        }
        return classes;
    }

    @Override
    public Integer getClassSize(Integer classId) {
        return classMapper.findClassSizeByClassId(classId);
    }

    @Override
    public Integer getAcademyIdByName(String academyName) {
        return academyMapper.findAcademyIdByName(academyName);
    }

    @Override
    public Integer getMajorIdByName(String majorName) {
        return majorMapper.findMajorIdByName(majorName);
    }

    @Override
    public Integer getClassIdByName(String majorName, String className) {
        return classMapper.findClassIdByMajorNameAndClassName(majorName, className);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void updateClassSize(Map<Integer, Integer> classSizeMap) {
        for (Map.Entry<Integer, Integer> entry : classSizeMap.entrySet()) {
            classMapper.updateClassSize(entry.getKey(), entry.getValue());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void updateClassSizePlusOne(Integer classId) {
        classMapper.updateClassSizePlusOne(classId);
    }
}
