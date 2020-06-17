package com.xust.sims.service;

import com.xust.sims.dao.TeacherMapper;
import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public List<Teacher> getTeacherInfoByAcademyId(Integer academyId) {
        return teacherMapper.getTeacherInfoByAcademyId(academyId);
    }

    @Override
    public List<Academy> getAcademyWithTeacherInfo() {
        return teacherMapper.getAcademyWithTeacherInfo();
    }
}
