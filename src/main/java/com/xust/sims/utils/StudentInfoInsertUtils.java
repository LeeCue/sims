package com.xust.sims.utils;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.metadata.style.WriteCellStyle;
import com.alibaba.excel.write.style.HorizontalCellStyleStrategy;
import com.xust.sims.dto.StudentExcelTemplateData;
import com.xust.sims.dto.StudentExcelData;
import com.xust.sims.entity.Student;
import org.apache.poi.ss.usermodel.IndexedColors;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-05-06
 */
public class StudentInfoInsertUtils {
    private static final List<StudentExcelData> EXCEL_DATA = new ArrayList<>();

    public static void getTemplateFile(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        //防止中文乱码
        String filename = URLEncoder.encode("学生信息模板", "utf-8");
        response.setHeader("Content-disposition", "attachment;filename=" + filename + ".xlsx");
        EasyExcel.write(response.getOutputStream(), StudentExcelTemplateData.class)
                .registerWriteHandler(getHorizontalCellStyleStrategy())
                .sheet().doWrite(EXCEL_DATA);
    }

    public static void getErrorFile(HttpServletResponse response, List<StudentExcelData> excelData, String currFilename) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        //防止中文乱码
        String filename = URLEncoder.encode(currFilename, "utf-8");
        response.setHeader("Content-disposition", "attachment;filename=" + filename + ".xlsx");
        EasyExcel.write(response.getOutputStream(), StudentExcelData.class)
                .registerWriteHandler(getHorizontalCellStyleStrategy())
                .sheet().doWrite(excelData);
    }

    private static HorizontalCellStyleStrategy getHorizontalCellStyleStrategy() {
        WriteCellStyle headStyle = new WriteCellStyle();
        headStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
        return new HorizontalCellStyleStrategy(headStyle, new WriteCellStyle());
    }

    public static void getStudentInfoFile(HttpServletResponse response, List<Student> students, String currFilename) throws IOException {
        List<StudentExcelData> excelData = convertStudentInfo(students);
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        //防止中文乱码
        String filename = URLEncoder.encode(currFilename, "utf-8");
        response.setHeader("Content-disposition", "attachment;filename=" + filename + ".xlsx");
        EasyExcel.write(response.getOutputStream(), StudentExcelData.class)
                .registerWriteHandler(getHorizontalCellStyleStrategy())
                .sheet().doWrite(excelData);
    }

    private static List<StudentExcelData> convertStudentInfo(List<Student> students) {
        List<StudentExcelData> excelData = new ArrayList<>();
        for (Student student : students) {
            excelData.add(new StudentExcelData(student.getId(), student.getName(), student.getNation(), student.getSex(),
                    student.getAge().toString(), student.getPoliticsStatus(), student.getIdCard(), student.getPhoneNum(),
                    student.getEmail(), student.getAcademy().getName(), student.getMajor().getName(), student.getClasses().getName(),
                    student.getCreateTime()));
        }
        return excelData;
    }
}
