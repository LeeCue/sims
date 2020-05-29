package com.xust.sims.entity;

import lombok.Data;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class Meta {
    private Integer id;
    private Boolean keepAlive = Boolean.FALSE;
    private Boolean requireAuth = Boolean.FALSE;
}
