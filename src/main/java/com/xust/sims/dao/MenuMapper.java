package com.xust.sims.dao;

import com.xust.sims.entity.Menu;
import com.xust.sims.entity.Meta;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Repository
public interface MenuMapper {
    /**
     * 查找所有菜单的信息
     * @return 所有菜单信息
     */
    List<Menu> findAllMenus();

    /**
     * 根据父菜单的id，来查询子菜单（二级导航）
     * @param parentId 父菜单
     * @return 二级导航
     */
    List<Menu> findChildMenus(Integer parentId);

    /**
     * 根据用户身份查找菜单
     * @param status 用户身份
     * @return 菜单信息
     */
    List<Menu> findAllMenusByStatus(Integer status);

    /**
     * 根据标签id来查找标签
     * @param metaId 标签id
     * @return 标签
     */
    Meta findMeta(Integer metaId);

    /**
     * 添加菜单
     * @param menu 菜单
     */
    void insertMenu(Menu menu);

    /**
     * 根据菜单id来删除菜单
     * @param id 菜单id
     */
    void deleteMenuById(Integer id);

    /**
     * 根据id来修改菜单信息
     * @param id 菜单id
     * @param menu 要改的菜单信息
     */
    void updateMenuById(Integer id, Menu menu);
}
