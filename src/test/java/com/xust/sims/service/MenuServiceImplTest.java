package com.xust.sims.service;

import com.xust.sims.entity.Menu;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-20
 */
@SpringBootTest
@Slf4j
class MenuServiceImplTest {
    @Autowired
    MenuService menuService;
    @Test
    void initMenus() {
        List<Menu> menus = menuService.initMenus(1);
        log.info("查询到的menus为:{}", menus);
    }
}