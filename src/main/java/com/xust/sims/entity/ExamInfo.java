package com.xust.sims.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class ExamInfo {
    private Integer id;
    private Date time;
    private String place;

    /**
     * 一对一关联课程信息
     */
    private Course course;
}
