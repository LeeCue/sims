package com.xust.sims.dao;

import com.xust.sims.entity.Academy;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-19
 */
@Repository
public interface AcademyMapper {
    /**
     * 根据id来查找学院信息
     * @param id id
     * @return academy's info
     */
    Academy findAcademyBaseInfoById(Integer id);

    List<Academy> findAcademyAllInfoDetails();

    List<Academy> findAllAcademyInfo();

    Academy findAcademyByMajorId(Integer majorId);

    Integer findAcademyIdByName(String academyName);
}
