package com.xust.sims.dto;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.format.DateTimeFormat;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import javax.validation.constraints.*;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-05-04
 */
@Data
@NoArgsConstructor
public class StudentExcelData {
    @ExcelProperty(value = "学工号")
    private String id;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "姓名")
    private String name;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "民族")
    private String nation;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "性别")
    private String sex;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "年龄")
    private String age;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "政治面貌")
    @ColumnWidth(15)
    private String politicsStatus;

    @NotEmpty(message = "不能为空")
    @ExcelProperty(value = "身份证号")
    @ColumnWidth(15)
    private String idCard;

    @NotEmpty(message = "不能为空")
    @Pattern(regexp = "^1[3456789]\\d{9}$", message = "格式错误")
    @ExcelProperty(value = "联系电话")
    @ColumnWidth(15)
    private String phoneNum;

    @ExcelProperty(value = "邮箱")
    @NotEmpty(message = "不能为空")
    @Email(message = "格式有误")
    private String email;

    @ExcelProperty(value = "学院")
    @NotEmpty(message = "信息不能为空")
    private String academyName;
    @ExcelIgnore
    private Integer academyId;

    @ExcelProperty(value = "专业")
    @NotEmpty(message = "信息不能为空")
    private String majorName;
    @ExcelIgnore
    private Integer majorId;

    @ExcelProperty(value = "班级")
    @NotEmpty(message = "信息不能为空")
    private String className;
    @ExcelIgnore
    private Integer classId;

    @ExcelProperty(value = "入学时间")
    @ColumnWidth(15)
    @DateTimeFormat("yyyy-MM-dd")
    @NotNull(message = "不能为空")
    private Date createTime;

    @ExcelProperty(value = "描述")
    @ColumnWidth(25)
    private String description;

    public StudentExcelData(String id, String name, String nation, String sex, String age, String politicsStatus,
                            String idCard, String phoneNum, String email, String academyName, String majorName,
                            String className, Date createTime) {
        this.id = id;
        this.name = name;
        this.nation = nation;
        this.sex = sex;
        this.age = age;
        this.politicsStatus = politicsStatus;
        this.idCard = idCard;
        this.phoneNum = phoneNum;
        this.email = email;
        this.academyName = academyName;
        this.majorName = majorName;
        this.className = className;
        this.createTime = createTime;
    }
}
