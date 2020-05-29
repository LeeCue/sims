package com.xust.sims.dao;

import com.xust.sims.dto.StudentInfoQuery;
import com.xust.sims.dto.StudentInsert;
import com.xust.sims.entity.Student;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-19
 */
@SpringBootTest
@Slf4j
class StudentMapperTest {
    @Autowired
    private StudentMapper studentMapper;
    private StudentInsert studentInsert;

    @BeforeEach
    void initData() {
        studentInsert = new StudentInsert();
        studentInsert.setId("112");
        studentInsert.setName("王五");
        studentInsert.setSex("男");
        studentInsert.setAge(21);
        studentInsert.setEmail("1238761723");
        studentInsert.setIdCard("12374123676173");
        //studentInsert.setAcademy("10");
        //studentInsert.setMajor("11");
        //studentInsert.setClassId("11");
        //studentInsert.setCreateTime(getDate());
        log.info("数据初始化完毕，{}", studentInsert);
        log.info("===========================================================");
    }

    Date getDate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = dateFormat.parse("2020-4-30");
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    @Test
    void findStudentByCondition() {
        StudentInfoQuery query = new StudentInfoQuery();
        Date date1 = null;
        Date date2 = null;
        /*SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            date1 = dateFormat.parse("2020-4-18");
            date2 = dateFormat.parse("2020-4-20");
        } catch (ParseException e) {
            e.printStackTrace();
        }*/
        query.setStartTime(date1);
        query.setStartTime(date2);
        query.setId("110");
        query.setName("张三");
        List<Student> students = studentMapper.findStudentByCondition(query);
        log.info("查询到的学生信息为:{}", students);
    }

    @Test
    void insertOneStudentInfo() {
        int rows = studentMapper.insertOneStudentInfo(studentInsert);
        log.info("插入之后，影响的行数为：{}", rows);
    }
}