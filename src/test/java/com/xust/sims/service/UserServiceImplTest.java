package com.xust.sims.service;

import com.xust.sims.entity.Registry;
import com.xust.sims.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * @author LeeCue
 * @date 2020-03-18
 */
@SpringBootTest
@Slf4j
class UserServiceImplTest {
    @Autowired
    UserServiceImpl userService;

    @Test
    void registryUser() {
        Registry user = new Registry();
        user.setUid("123");
        user.setPassword("123");
        user.setStatus(1);
        log.info("注册是否成功:{}", userService.registryUser(user));
        log.info("用户信息为:{}", user);
    }

    @Test
    void loadUserByUsername() {
        UserDetails user = userService.loadUserByUsername("123");
        log.info("查询到的user信息为:{}", user);
    }

    @Test
    void getUserInfoByUsername() {
        User user = userService.getUserInfoByUsername("123");
        log.info("current user info is : {}", user);
    }
}