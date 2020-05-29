package com.xust.sims.web.controller;

import com.xust.sims.entity.User;
import com.xust.sims.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.security.Principal;

/**
 * @author LeeCue
 * @date 2020-03-16
 */
public class BaseController {
    @Autowired
    private UserService userService;

    protected User getUserInfo(Principal principal) {
        return userService.getUserInfoByUsername(principal.getName());
    }
}
