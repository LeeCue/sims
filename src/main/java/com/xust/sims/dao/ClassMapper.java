package com.xust.sims.dao;

import com.xust.sims.entity.Class;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.jnlp.IntegrationService;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-19
 */
@Repository
public interface ClassMapper {
    /**
     * 根据id来查找班级信息
     * @param id id
     * @return class's info
     */
    Class findClassBaseInfoById(Integer id);

    /**
     * 根据专业ID来获取班级信息
     * @param majorId 专业ID
     * @return 在该专业下，所有班级信息
     */
    List<Class> findClassByMajorId(Integer majorId);

    Integer findClassIdByMajorNameAndClassName(@Param("majorName") String majorName,
                                               @Param("className") String className);

    Integer findClassSizeByClassId(Integer classId);

    int updateClassSize(@Param("classId") Integer classId,
                        @Param("classSize") Integer classSize);

    int reduceOneClassSizeByClassId(Integer classId);

    int updateClassSizePlusOne(Integer classId);
}
