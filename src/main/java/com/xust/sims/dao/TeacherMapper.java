package com.xust.sims.dao;

import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Teacher;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@Repository
public interface TeacherMapper {
    /**
     * 根据学院信息获取教师信息
     * @param academyId
     * @return
     */
    List<Teacher> getTeacherInfoByAcademyId(Integer academyId);

    /**
     * 通过教师id获取教师信息
     * @param teacherId
     * @return
     */
    Teacher getTeacherInfoById(String teacherId);

    /**
     * 获取学院、教师关系
     * @return
     */
    List<Academy> getAcademyWithTeacherInfo();
}
