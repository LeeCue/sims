package com.xust.sims.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Major {
    private Integer id;
    private String name;

    @JSONField(name = "children")
    private List<Class> classes;
}
