package com.xust.sims.service;

import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Teacher;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
public interface TeacherService {
    /**
     * 根据学院ID获取教师信息
     * @param academyId
     * @return
     */
    List<Teacher> getTeacherInfoByAcademyId(Integer academyId);

    /**
     * 获取学院-教师对应信息
     * @return
     */
    List<Academy> getAcademyWithTeacherInfo();
}
