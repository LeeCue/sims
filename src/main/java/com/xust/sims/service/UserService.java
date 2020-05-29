package com.xust.sims.service;

import com.xust.sims.entity.Registry;
import com.xust.sims.entity.Role;
import com.xust.sims.entity.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-18
 */
public interface UserService extends UserDetailsService {
    /**
     * 注册用户
     * @param registry 注册信息
     * @return 返回
     */
    boolean registryUser(Registry registry);

    /**
     * 批量注册
     * @param registries
     */
    void registryUser(List<Registry> registries);

    /**
     * 根据用户名来寻找用户
     * @param s 用户名，唯一
     * @return 用户信息
     * @throws UsernameNotFoundException username is not exist
     */
    @Override
    UserDetails loadUserByUsername(String s) throws UsernameNotFoundException;

    /**
     * 上传头像
     * @param file 头像文件
     * @param prefix 存储文件的文件夹名
     * @return avatar url
     */
    String uploadAvatar(MultipartFile file, String prefix);

    /**
     * 根据用户凭证，来查找用户的基本信息
     * @param username 用户凭证
     * @return users' information
     */
    User getUserInfoByUsername(String username);

    /**
     * 根据关键字获取total量
     * @param keywords
     * @return
     */
    Long getTotalByKeyWords(String keywords);

    /**
     * 根据关键词来搜索用户信息
     * @param keyword (关键词为 name or id)
     * @return users' info
     */
    List<User> getUserInfoByKeyword(String keyword);

    /**
     * 获取所有角色信息
     * @return all roles' info
     */
    List<Role> getAllRoles();

    /**
     * 更新当前用户的信息
     * @param currUser
     * @return
     */
    boolean updateUserBaseInfo(User currUser);

    /**
     * 根据uid来添加角色信息
     * @param uid 用户uid
     * @param roleIds 角色id数组
     */
    void addRolesWithUid(String uid, List<Integer> roleIds);

    /**
     * 改变用户登录状态
     * @param uid uid
     * @param enabled 登录状态（是否可登录）
     */
    void changeUserEnabled(String uid, Boolean enabled);

    /**
     * 删除用户所有信息
     * @param id id
     * @return 删除的状态
     */
    void deleteUser(String id);

    /**
     * 删除用户角色信息
     * @param uid uid
     * @param roleId roleId
     */
    void deleteRoleWithUid(String uid, Integer roleId);

    Long getUserNum();
}
