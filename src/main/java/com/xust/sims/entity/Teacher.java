package com.xust.sims.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Teacher {
    private String id;
    private String name;
    private String avatar;
    private String sex;
    private String idCard;
    private String politicsStatus;
    private String phoneNum;
    private String email;
    private String comment;
    private Date createTime;
    private Date updateTime;

    private Academy academy;
    private Major major;

    private List<Course> courses;
}
