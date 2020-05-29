package com.xust.sims.service;

import com.xust.sims.entity.Academy;
import com.xust.sims.entity.Class;
import com.xust.sims.entity.Major;

import java.util.List;
import java.util.Map;

/**
 * @author LeeCue
 * @date 2020-05-04
 */
public interface SchoolInfoService {
    /**
     * 获取所有学院信息
     * @return 所有学院信息
     */
    List<Academy> getAllAcademies();

    /**
     * 根据专业ID来获取所属学院信息
     * @param majorId 专业ID
     * @return 学院信息
     */
    Academy getAcademyByMajorId(Integer majorId);

    /**
     * 根据班级id获取班级信息s
     * @param classId
     * @return
     */
    Class getClassInfoByClassId(Integer classId);

    /**
     * 获取所有专业信息
     * @return 所有专业信息
     */
    List<Major> getAllMajors();

    /**
     * 根据学院的ID来获取学院下所属的专业信息
     * @param academyId 已选择的学院ID
     * @return 该学院下的所有专业信息
     */
    List<Major> getMajorsByAcademyId(Integer academyId);

    /**
     * 根据专业信息来获取该专业下所有班级
     * @param majorId 专业ID
     * @return 在该专业下，所有班级信息
     */
    List<Class> getClassByMajorId(Integer majorId);

    /**
     * 获取班级人数
     * @param classId
     * @return
     */
    Integer getClassSize(Integer classId);

    /**
     * 根据学院名称来获取学院ID
     * @param academyName
     * @return
     */
    Integer getAcademyIdByName(String academyName);

    /**
     * 根据专业名称来获取专业ID
     * @param majorName
     * @return
     */
    Integer getMajorIdByName(String majorName);

    /**
     * 根据专业+班级名称来获取班级ID
     * @param majorName
     * @param className
     * @return
     */
    Integer getClassIdByName(String majorName, String className);

    /**
     * 根据班级人数map来更新人数
     * @param classSizeMap
     */
    void updateClassSize(Map<Integer, Integer> classSizeMap);

    void updateClassSizePlusOne(Integer classId);
}
