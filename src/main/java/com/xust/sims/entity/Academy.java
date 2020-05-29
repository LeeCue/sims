package com.xust.sims.entity;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Academy {
    private Integer id;
    private String name;

    private List<Major> majors;
}
