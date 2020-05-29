package com.xust.sims.dao;

import com.xust.sims.entity.User;
import com.xust.sims.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * @author LeeCue
 * @date 2020-03-31
 */
@SpringBootTest
@Slf4j
class UserMapperTest {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserService userService;

    @Test
    void findUserIdByName() {
        List<User> users = userService.getUserInfoByKeyword("李四");
        log.info("users: {}", users);
    }
}