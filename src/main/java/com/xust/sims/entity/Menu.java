package com.xust.sims.entity;

import lombok.Data;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Menu {
    private Integer id;
    private String url;
    private String path;
    private String component;
    private String name;
    private String iconCls;

    /**
     * 一对一 关联 meta 标签
     */
    private Meta meta;
    /**
     * 一对多，对应的子菜单
     */
    private List<Menu> children;

}
