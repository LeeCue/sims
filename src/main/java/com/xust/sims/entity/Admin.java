package com.xust.sims.entity;

import lombok.Builder;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Admin {
    private String id;
    private String name;
    private String avatar;
    private String sex;
    private String phoneNum;
    private String comment;
    private Date createTime;
    private Date updateTime;

    private List<NoticeBoard> boards;
}
