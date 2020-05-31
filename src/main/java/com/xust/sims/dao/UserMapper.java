package com.xust.sims.dao;

import com.xust.sims.entity.Registry;
import com.xust.sims.entity.Role;
import com.xust.sims.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Repository
public interface UserMapper {
    /**
     * 根据uid和password来查找用户
     * @param uid uid
     * @return 注册用户信息
     */
    Registry checkUserByUid(@Param("uid") String uid);

    /**
     * 根据uid来查询管理员用户信息
     * @param uid uid
     * @return user info
     */
    User findAdminInfoByUid(String uid);

    /**
     * 根据uid来查询学生信息
     * @param uid
     * @return
     */
    User findStudentInfoByUid(String uid);

    /**
     * 根据用户姓名来查找用户id
     * @param name 用户姓名
     * @return ids
     */
    List<String> findUserIdByName(String name);

    /**
     * 根据 uid 查找用户角色信息
     * @param uid uid
     * @return roles information
     */
    List<Role> findRolesByUid(String uid);

    /**
     * 获取所有角色信息
     * @return all roles info
     */
    List<Role> findAllRoles();

    /**
     * 查找全部用户信息
     * @return all users' info
     */
    List<String> findAllUsername();

    /**
     * 获取用户总数
     * @return
     */
    Long findUserNum();

    /**
     * 根据uid获取总数
     * @param uid
     * @return
     */
    Long findUserNumByUid(String uid);

    /**
     * 根据姓名来获取总数
     * @param name
     * @return
     */
    Long findUserNumByName(String name);

    /**
     * 添加用户注册信息（单条）
     * @param registry 注册信息
     * @return 影响的行数
     */
    int insertRegistryInfo(Registry registry);

    /**
     * 批量添加用户注册信息
     * @param registries
     */
    void insertRegistryInfoBatch(@Param("registries") List<Registry> registries);

    /**
     * 更新管理员用户基础信息
     * @param user user's status is admin
     * @return effect rows
     */
    int updateAdminBaseInfo(User user);

    /**
     * 更新学生用户基础信息
     * @param user
     * @return
     */
    int updateStudentBaseInfo(User user);

    /**
     * 删除注册表的信息
     * @param id id
     * @return effect rows
     */
    int deleteRegistryInfo(String id);

    /**
     * 更新用户的状态
     * @param uid uid
     * @param enabled enabled
     */
    void updateUserEnabled(@Param("uid") String uid,
                           @Param("enabled") Boolean enabled);

    /**
     * 删除相关的token信息
     * @param id id
     */
    void deleteToken(String id);

    /**
     * 根据用户名和角色id来删除用户所属角色信息
     * @param uid uid
     * @param roleId roleId
     */
    void deleteRoleWithUid(@Param("userId") String uid,
                           @Param("roleId") Integer roleId);

    /**
     * 根据uid来添加角色信息(批量导入)
     * @param uid uid
     * @param roleIds roleIds
     */
    void addRoleWithUid(@Param("userId") String uid,
                        @Param("roleIds") List<Integer> roleIds);
}
