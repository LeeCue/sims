package com.xust.sims.dto;

import lombok.Data;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Data
public class LoginUser {
    private String username;
    private String password;
    private Boolean rememberMe;
    private String imageCode;
}
