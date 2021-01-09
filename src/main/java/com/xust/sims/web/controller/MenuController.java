package com.xust.sims.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xust.sims.entity.User;
import com.xust.sims.service.MenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@RestController
@Slf4j
@RequestMapping("/web")
public class MenuController extends BaseController {
    @Autowired
    private MenuService menuService;

    @GetMapping("/system/config/menu")
    public JSON initMenu(Principal principal) {
        User user = getUserInfo(principal);
        log.info("当前登录用户信息为 : " + principal);
        JSONObject json = new JSONObject();
        json.put("menus", menuService.initMenus(user.getStatus()));
        return json;
    }

}
