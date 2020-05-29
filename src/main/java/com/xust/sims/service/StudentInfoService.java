package com.xust.sims.service;

import com.xust.sims.dto.StudentExcelData;
import com.xust.sims.dto.StudentInfoQuery;
import com.xust.sims.dto.StudentInsert;
import com.xust.sims.entity.Student;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-20
 */
public interface StudentInfoService {
    /**
     * 根据查询条件来获取学生信息
     * @param query query condition
     * @return student's info
     */
    List<Student> getStudentByQueryInfo(StudentInfoQuery query);

    /**
     * 根据id集合来查询学生信息
     * @param ids
     * @return
     */
    List<Student> getStudentByIds(int[] ids);

    /**
     * 添加学生信息(单条)，发送一封欢迎邮件
     * @param student
     */
    void addOneStudentInfo(Student student);

    /**
     * 添加学生信息（批量）发送一封欢迎邮件
     * @param students
     */
    void addBatchStudentInfo(List<Student> students);

    /**
     * 根据单条的插入数据信息，进行录入
     * @param studentInsert
     */
    void addOneStudentInsertInfo(StudentInsert studentInsert);

    /**
     * 加工处理学生ExcelData数据（学工号、学院信息等）
     * @param dataList
     */
    void processStudentExcelData(List<StudentExcelData> dataList);

    void saveExcelData(List<StudentExcelData> list) throws Exception;

    List<StudentExcelData> saveStudentExcelData(MultipartFile[] files) throws Exception;

    /**
     * 更新学生信息
     * @param student
     */
    void updateStudentInfo(Student student);
}
