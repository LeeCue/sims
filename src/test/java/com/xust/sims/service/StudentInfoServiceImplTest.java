package com.xust.sims.service;

import com.xust.sims.entity.Student;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

/**
 * @author LeeCue
 * @date 2020-05-06
 */
@SpringBootTest
@Slf4j
class StudentInfoServiceImplTest {
    @Autowired
    private StudentInfoService studentInfoService;

    @Test
    void addOneStudentInfo() {
        studentInfoService.addOneStudentInfo(null);
    }

    Student getStudent() {
        Student student = new Student();
        student.setId("123");
        student.setName("张三");
        student.setEmail("787504485@qq.com");
        student.setIdCard("61273119990604022121");
        return student;
    }

    public static void main(String[] args) {
        String idCard = "61273119990604022121";
        System.out.println(idCard.substring(idCard.length() - 6));
    }
}