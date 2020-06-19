package com.xust.sims.dao;

import com.xust.sims.dto.StudentExcelData;
import com.xust.sims.dto.StudentInfoQuery;
import com.xust.sims.dto.StudentInsert;
import com.xust.sims.entity.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-19
 */
@Repository
public interface StudentMapper {
    /**
     * 根据查询条件来查询学生基础信息（除去课程、考试信息）
     * @param query 查询条件
     * @return 学生信息
     */
    List<Student> findStudentByCondition(StudentInfoQuery query);

    /**
     * 根据id集合来查询学生信息
     * @param ids
     * @return
     */
    List<Student> findStudentByIds(@Param("ids") List<Integer> ids);

    /**
     * 根据学生id获取详细信息
     * @param id
     * @return
     */
    Student findStudentDetailsById(String id);

    /**
     * 根据学生id查找班级id
     * @param id
     * @return
     */
    Integer getClassIdByStudentId(String id);

    /**
     * 根据学生id获取查询状态
     * @param id
     * @return
     */
    boolean getSelectFlagByStudentId(String id);

    /**
     * 单条插入学生信息
     * @param studentInsert 单条插入学生信息
     * @return effect rows
     */
    int insertOneStudentInfo(StudentInsert studentInsert);

    /**
     * 批量插入学生信息
     * @param studentExcelData 学生信息Excel对应的实体类
     * @return effect rows
     */
    int insertBatchStudentInfos(@Param("studentExcelData") List<StudentExcelData> studentExcelData);

    /**
     * 根据id来删除学生信息
     * @param id
     */
    void deleteStudentInfo(String id);

    /**
     * 更新学生信息
     * @param student
     */
    void updateStudentInfo(Student student);
}
