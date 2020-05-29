package com.xust.sims.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.*;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-04-16
 */
@Data
public class StudentInsert {
    private String id;
    @NotEmpty(message = "姓名不能为空")
    private String name;
    @NotEmpty(message = "性别不能空")
    private String sex;
    @NotNull(message = "年龄不能为空")
    @Min(value = 0, message = "年龄不能小于0")
    private Integer age;
    @NotEmpty(message = "邮箱不能为空")
    @Email(message = "邮箱格式错误")
    private String email;
    @NotNull(message = "学院信息不能为空")
    private Integer academyId;
    @NotNull(message = "专业信息不能为空")
    private Integer majorId;
    @NotEmpty(message = "身份证号不能为空")
    private String idCard;
    @NotNull(message = "班级信息不能为空")
    private Integer classId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "入学时间不能为空")
    private Date createTime;
}
