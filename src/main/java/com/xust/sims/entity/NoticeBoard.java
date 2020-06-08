package com.xust.sims.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class NoticeBoard {
    private Integer id;
    @NotNull(message = "标题不能为空")
    private String title;
    @NotNull(message = "发布状态不能为空")
    private Boolean published;
    @NotNull(message = "内容不能为空")
    private String content;
    @NotNull(message = "公告类型名称不能为空")
    private String typeName;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;
}
