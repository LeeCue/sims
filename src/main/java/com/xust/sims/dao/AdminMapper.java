package com.xust.sims.dao;

import com.xust.sims.entity.Admin;
import com.xust.sims.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Repository
public interface AdminMapper {
    /**
     * 根据 uid 来查询管理员的信息
     * @param uid uid
     * @return admin's information
     */
    Admin findAdminByUid(String uid);

    /**
     * 根据
     * @param uid
     * @return
     */
    User findAdminBaseInformation(String uid);

    /**
     * 添加管理员信息（单条）
     * @param admin admin's information
     */
    void insertAdmin(Admin admin);

    /**
     * 根据 uid 来修改管理员信息
     * @param uid uid
     * @param admin admin's information
     */
    void updateAdmin(@Param("uid") String uid,
                     @Param("admin") Admin admin);

    /**
     * 根据 id 来删除管理员信息
     * @param id uid
     */
    void deleteAdmin(String id);
}
