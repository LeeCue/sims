package com.xust.sims.utils;

/**
 * @author LeeCue
 * @date 2020-03-18
 */
public class TestMenu {
    /*public static JSON getTestMenu() {
        JSONObject json = new JSONObject();
        List<Menu> menus = new ArrayList<>();
        initData(menus);
        json.put("menus", menus);
        return json;
    }

    private static void initData(List<Menu> menus) {
        Meta meta1 = Meta.builder()
                .keepAlive(true)
                .requireAuth(true)
                .build();
        Menu menu2 = Menu.builder()
                .id(2)
                .url("/test")
                .meta(meta1)
                .name("导航1-1")
                .component("Test1-1")
                .path("/test1-1")
                .build();
        Menu menu4 = Menu.builder()
                .id(4)
                .url("/test")
                .meta(meta1)
                .name("导航1-2")
                .component("Test1-2")
                .path("/test1-2")
                .build();
        List<Menu> children = new ArrayList<>();
        children.add(menu2);
        children.add(menu4);
        Menu menu1 = Menu.builder()
                .id(1)
                .iconCls("el-icon-platform-eleme")
                .url("/test")
                .meta(meta1)
                .name("导航1")
                .component("Index")
                .path("/Test1")
                .children(children)
                .build();
        Menu menu3 = Menu.builder()
                .id(3)
                .iconCls("el-icon-eleme")
                .url("/test")
                .meta(null)
                .component("Index")
                .name("导航2")
                .path("/Test2")
                .build();
        menus.add(menu1);
        menus.add(menu3);
    }*/
}
