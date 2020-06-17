package com.xust.sims.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Course {
    private Integer id;
    @NotEmpty(message = "课程名称不能为空")
    private String name;
    /**
     * 课程性质，1 表示必修，2 表示选修，3 表示公选
     */
    @NotNull(message = "课程性质不能为空")
    private Integer status;
    @NotNull(message = "学分不能为空")
    @Min(value = 0, message = "学分不能小于0")
    private Double credit;
    @NotNull(message = "学时不能为空")
    @Min(value = 0, message = "学时不能小于0")
    private Integer period;
    private Integer total;
    private Integer academyId;
    private String teacherId;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;
    private Integer leftNum;

    private Teacher teacher;
    private Academy academy;
}
