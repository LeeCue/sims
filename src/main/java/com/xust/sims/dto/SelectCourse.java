package com.xust.sims.dto;

import lombok.Data;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-15
 */
@Data
public class SelectCourse {
    private String name;
    private List<Integer> status;
    private Integer academyId;
    private Integer currPage;
    private Integer pageSize;
}
