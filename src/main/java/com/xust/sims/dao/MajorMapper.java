package com.xust.sims.dao;

import com.xust.sims.entity.Major;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-19
 */
@Repository
public interface MajorMapper {
    /**
     * 根据id来查找专业信息
     * @param id id
     * @return academy's info
     */
    Major findMajorBaseInfoById(Integer id);

    /**
     * 获取所有专业信息
     * @return 获取所有专业信息
     */
    List<Major> findAllMajors();

    /**
     * 根据学院ID来获取专业信息
     * @param academyId 学院ID
     * @return 该学院下的所有专业信息
     */
    List<Major> findMajorsByAcademyId(Integer academyId);

    Integer findMajorIdByName(String majorName);
}
