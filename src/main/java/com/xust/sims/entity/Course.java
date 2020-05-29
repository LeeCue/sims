package com.xust.sims.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Course {
    private Integer id;
    private String name;
    /**
     * 课程性质，true表示必修，false表示选修
     */
    private Boolean status = Boolean.FALSE;
    private Double credit;
    private Integer period;
    private Date createTime;
    private Date updateTime;

    private List<CourseTime> courseTime;

    private Teacher teacher;
}
