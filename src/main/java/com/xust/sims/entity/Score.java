package com.xust.sims.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Score {
    private Long id;
    private Integer grade;
    private Boolean argueFlag = Boolean.FALSE;
    private Boolean reexam = Boolean.FALSE;
    private Boolean retake = Boolean.FALSE;
    private Date createTime;
    private Date updateTime;

    private Course course;
}
