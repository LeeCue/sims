package com.xust.sims.dto;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.format.DateTimeFormat;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import lombok.Data;

import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-05-24
 */
@Data
public class StudentExcelTemplateData {
    @ExcelProperty(value = "姓名")
    private String name;
    @ExcelProperty(value = "民族")
    private String nation;
    @ExcelProperty(value = "性别")
    private String sex;
    @ExcelProperty(value = "年龄")
    private String age;
    @ExcelProperty(value = "政治面貌")
    @ColumnWidth(15)
    private String politicsStatus;
    @ExcelProperty(value = "身份证号")
    @ColumnWidth(15)
    private String idCard;
    @ExcelProperty(value = "联系电话")
    @ColumnWidth(15)
    private String phoneNum;
    @ExcelProperty(value = "邮箱")
    private String email;
    @ExcelProperty(value = "学院")
    private String academyName;
    @ExcelProperty(value = "专业")
    private String majorName;
    @ExcelProperty(value = "班级")
    private String className;
    @ExcelProperty(value = "入学时间")
    @ColumnWidth(15)
    @DateTimeFormat("yyyy-MM-dd")
    private Date createTime;
}
