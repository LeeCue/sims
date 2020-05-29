package com.xust.sims.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-15
 */
@Data
public class User implements Serializable {
    private static final long serialVersionUID = 7986943074663390460L;
    private String id;
    private String name;
    private String avatar;
    private String sex;
    private String phoneNum;
    private Boolean enabled = Boolean.TRUE;
    private String description;
    private Date createTime;
    private Integer status;

    private List<Role> roles;
}
