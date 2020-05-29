package com.xust.sims.web.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xust.sims.dto.RespBean;
import com.xust.sims.dto.ResponseCode;
import com.xust.sims.entity.Role;
import com.xust.sims.entity.User;
import com.xust.sims.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-22
 */
@RequestMapping("/web")
@RestController
@Slf4j
public class UserController extends BaseController {
    @Autowired
    private UserService userService;

    @PostMapping("/file/uploadAvatar")
    public RespBean avatarUpload(@RequestParam("avatar") MultipartFile avatar) {
        String res = userService.uploadAvatar(avatar, "sims");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("imageUrl", res);
        return new RespBean(ResponseCode.SUCCESS, jsonObject);
    }

    @Secured("ROLE_user")
    @PostMapping("/user/updateBaseInfo")
    public RespBean updateUserBaseInfo(@RequestBody User user, Principal principal) {
        User currUser = getUserInfo(principal);
        currUser.setDescription(user.getDescription());
        currUser.setAvatar(user.getAvatar());
        RespBean respBean = new RespBean();
        if (userService.updateUserBaseInfo(currUser)) {
            respBean.setCodeAndData(ResponseCode.SUCCESS, currUser);
        } else {
            respBean.setResponseCode(ResponseCode.ERROR);
        }
        return respBean;
    }

    @Secured("ROLE_admin")
    @GetMapping("/user")
    public PageInfo<User> searchUserInfos(@RequestParam(value = "keywords", required = false) String keywords,
                                          @RequestParam("pageNum") Integer pageNum,
                                          @RequestParam("pageSize") Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> users = userService.getUserInfoByKeyword(keywords.trim());
        PageInfo<User> pageInfo = new PageInfo<>(users);
        if (keywords.trim().length() > 0) {
            pageInfo.setTotal(userService.getTotalByKeyWords(keywords));
        } else {
            pageInfo.setTotal(userService.getUserNum());
        }
        log.info("获取的部分用户信息为：{}", pageInfo);
        return pageInfo;
    }

    @Secured("ROLE_admin")
    @DeleteMapping("/system/user/{id}")
    public RespBean deleteUser(@PathVariable("id") String id) {
        userService.deleteUser(id);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @Secured("ROLE_admin")
    @GetMapping("/user/allRoles")
    public List<Role> getAllRoles() {
        return userService.getAllRoles();
    }

    @Secured("ROLE_admin")
    @DeleteMapping("/userDeleteRole/{userId}/{roleId}")
    public RespBean deleteUserRole(@PathVariable("userId")String uid,
                                   @PathVariable("roleId")Integer roleId) {
        userService.deleteRoleWithUid(uid, roleId);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @Secured("ROLE_admin")
    @PostMapping("/user/addRoles")
    public RespBean addRoles(@RequestParam("userId")String username,
                             @RequestParam("roleId")List<Integer> roleIds) {
        userService.addRolesWithUid(username, roleIds);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @Secured("ROLE_admin")
    @GetMapping("/user/changeEnabled")
    public RespBean changeEnabled(@RequestParam("uid") String username,
                                  @RequestParam("enabled") Boolean enabled) {
        userService.changeUserEnabled(username, enabled);
        return new RespBean(ResponseCode.SUCCESS);
    }
}
