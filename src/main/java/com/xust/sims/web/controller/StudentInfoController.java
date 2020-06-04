package com.xust.sims.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xust.sims.dto.*;
import com.xust.sims.entity.Student;
import com.xust.sims.service.StudentInfoService;
import com.xust.sims.service.StudentInfoServiceImpl;
import com.xust.sims.utils.StudentInfoInsertUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-04-16
 */
@RequestMapping("/web")
@RestController
@Slf4j
public class StudentInfoController {
    @Autowired
    private StudentInfoService studentInfoService;

    @PostMapping("/student/info")
    @Secured({"ROLE_admin"})
    public PageInfo<Student> queryStudentInfo(@RequestBody StudentInfoQuery query) {
        PageHelper.startPage(query.getPageNum(), query.getPageSize());
        List<Student> students = studentInfoService.getStudentByQueryInfo(query);
        return new PageInfo<>(students);
    }

    @PostMapping("/student/templateFile/download")
    @Secured({"ROLE_admin", "ROLE_teacher"})
    public void downloadTemplateFile(HttpServletResponse response) throws IOException {
        StudentInfoInsertUtils.getTemplateFile(response);
    }

    @PostMapping("/studentInfo/exportData")
    @Secured({"ROLE_admin"})
    public void exportStudentInfoData(HttpServletResponse response, @RequestBody StudentInfoQuery query) throws IOException {
        List<Student> students = studentInfoService.getStudentByQueryInfo(query);
        StudentInfoInsertUtils.getStudentInfoFile(response, students, "学生信息导出文件");
    }

    @PostMapping("/studentInfo/exportData/accordingId")
    @Secured({"ROLE_admin"})
    public void exportStudentInfoDataByIds(@RequestParam("ids") int[] ids, HttpServletResponse response) throws IOException {
        log.info("获取的 ids 为：{}", Arrays.toString(ids));
        List<Student> studentList = studentInfoService.getStudentByIds(ids);
        log.info("studentList的size为：{}", studentList.size());
        StudentInfoInsertUtils.getStudentInfoFile(response, studentList, "部分学生数据信息文件");
    }

    @PostMapping("/studentInfo/upload")
    @Secured({"ROLE_admin"})
    public RespBean uploadStudentInfo(@Valid @RequestBody StudentInsert studentInsert, BindingResult result) {
        log.info("接收到的学生信息为：{}", studentInsert);
        if (result.hasErrors()) {
            for (ObjectError error : result.getAllErrors()) {
                log.error("错误为；{}", error);
            }
            return new RespBean(ResponseCode.ERROR);
        }
        studentInfoService.addOneStudentInsertInfo(studentInsert);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/studentInfo/fileUpload")
    @Secured({"ROLE_admin"})
    public RespBean uploadStudentInfoFile(@RequestParam("files") MultipartFile[] files, HttpServletRequest request) throws Exception {
        List<StudentExcelData> errorList = studentInfoService.saveStudentExcelData(files);
        if (errorList.size() > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("errorList", new ArrayList<>(errorList));
            ((StudentInfoServiceImpl) studentInfoService).getErrorList().clear();
            return new RespBean(ResponseCode.ERROR, errorList.size());
        }
        return new RespBean(ResponseCode.SUCCESS, errorList.size());
    }

    @PostMapping("/studentInfo/errorFile")
    @Secured({"ROLE_admin"})
    public void downloadErrorFile(HttpServletRequest request, HttpServletResponse response) {
        @SuppressWarnings("unchecked")
        List<StudentExcelData> errorList = (List<StudentExcelData>) request.getSession().getAttribute("errorList");
        log.error("错误集合为：{}", errorList);
        try {
            StudentInfoInsertUtils.getErrorFile(response, errorList, "错误录入信息文件");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            request.getSession().removeAttribute("errorList");
        }
    }

    @PostMapping("/studentInfo/update")
    @Secured({"ROLE_admin"})
    public RespBean updateStudentInfo(@RequestBody @Valid Student student, BindingResult bindingResult) {
        log.info("接收到的Student信息为：{}", student);
        if (bindingResult.hasErrors() || !StringUtils.isEmpty(studentInfoIsEmpty(student))) {
            StringBuilder sb = new StringBuilder();
            sb.append(studentInfoIsEmpty(student));
            for (ObjectError error : bindingResult.getAllErrors()) {
                sb.append(error.getDefaultMessage()).append(";");
            }
            return new RespBean(ResponseCode.ERROR, sb.toString());
        }
        studentInfoService.updateStudentInfo(student);
        return new RespBean(ResponseCode.SUCCESS);
    }

    private String studentInfoIsEmpty(Student student) {
        if (student.getAcademy().getId() == null || student.getMajor().getId() == null || student.getClasses().getId() == null) {
            return "学院、专业、班级信息不能为空";
        }
        return "";
    }
}
