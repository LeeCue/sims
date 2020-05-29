package com.xust.sims.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class NoticeBoard {
    private Integer id;
    private String title;
    private String content;
    private Date createTime;
    private Date updateTime;

    private BoardType boardType;
}
