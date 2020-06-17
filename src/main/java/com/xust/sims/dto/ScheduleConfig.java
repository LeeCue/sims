package com.xust.sims.dto;

import lombok.Data;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@Data
public class ScheduleConfig {
    private Integer courseId;
    private String teacherId;
    private List<Integer> selectItems;
}
