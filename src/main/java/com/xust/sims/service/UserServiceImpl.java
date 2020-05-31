package com.xust.sims.service;

import com.xust.sims.dao.AdminMapper;
import com.xust.sims.dao.ClassMapper;
import com.xust.sims.dao.StudentMapper;
import com.xust.sims.dao.UserMapper;
import com.xust.sims.entity.Registry;
import com.xust.sims.entity.Role;
import com.xust.sims.entity.User;
import com.xust.sims.utils.AvatarUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-18
 */
@Service
@Slf4j
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ClassMapper classMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean registryUser(Registry registry) {
        //对密码进行加密处理
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);
        registry.setPassword(encoder.encode(registry.getPassword()));
        boolean res = userMapper.insertRegistryInfo(registry) == 1;
        dealUserToRole(registry.getUid(), registry.getStatus());
        return res;
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void registryUser(List<Registry> registries) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);
        for (Registry registry : registries) {
            registry.setPassword(encoder.encode(registry.getPassword()));
        }
        userMapper.insertRegistryInfoBatch(registries);
        for (Registry registry : registries) {
            dealUserToRole(registry.getUid(), registry.getStatus());
        }
    }

    private void dealUserToRole(String id, Integer status) {
        List<Integer> roleIds = new ArrayList<>();
        if (status == 1) {
            roleIds.add(1);
            roleIds.add(4);
        } else if (status == 2) {
            roleIds.add(3);
            roleIds.add(4);
        } else if (status == 3) {
            roleIds.add(2);
            roleIds.add(4);
        }
        addRolesWithUid(id, roleIds);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Registry user = userMapper.checkUserByUid(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户不存在!");
        }
        user.setRoles(userMapper.findRolesByUid(username));
        return user;
    }

    @Override
    public String uploadAvatar(MultipartFile file, String prefix) {
        return AvatarUtils.uploadFile(file, prefix);
    }

    @Override
    public User getUserInfoByUsername(String username) {
        Registry user = userMapper.checkUserByUid(username);
        List<Role> roles = userMapper.findRolesByUid(username);
        Integer status = user.getStatus();
        User userInfo = null;
        switch (status) {
            case 1:
                userInfo = userMapper.findAdminInfoByUid(username);
                break;
            case 2:
                userInfo = userMapper.findStudentInfoByUid(username);
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + status);
        }
        userInfo.setStatus(status);
        userInfo.setRoles(roles);
        return userInfo;
    }

    @Override
    public Long getTotalByKeyWords(String keywords) {
        Long total = null;
        if (isNumber(keywords)) {
            //说明为学工号
            total = userMapper.findUserNumByUid(keywords);
        } else {
            //说明为姓名
            total = userMapper.findUserNumByName(keywords);
        }
        return total;
    }

    @Override
    public List<User> getUserInfoByKeyword(String keyword) {
        List<User> res = new ArrayList<>();
        if ("".equals(keyword)) {
            //如果空条件，则为查询所有用户信息
            List<String> ids = userMapper.findAllUsername();
            for (String id : ids) {
                User user = getUserInfoByUsername(id);
                res.add(user);
            }
        } else {
            if (isNumber(keyword)) {
                //根据学工号来查找
                User user = getUserInfoByUsername(keyword);
                res.add(user);
            } else {
                //根据姓名来查找
                List<String> ids = userMapper.findUserIdByName(keyword);
                for (String id : ids) {
                    User user = getUserInfoByUsername(id);
                    res.add(user);
                }
            }
        }
        return res;
    }

    @Override
    public List<Role> getAllRoles() {
        return userMapper.findAllRoles();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateUserBaseInfo(User currUser) {
        Integer status = currUser.getStatus();
        int row = 0;
        //根据当前身份来选择更新用户基础信息
        switch (status) {
            case 1:
                row = userMapper.updateAdminBaseInfo(currUser);
                break;
            case 2:
                row = userMapper.updateStudentBaseInfo(currUser);
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + status);
        }
        return row == 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void addRolesWithUid(String uid, List<Integer> roleIds) {
        userMapper.addRoleWithUid(uid, roleIds);
    }

    @Override
    public void changeUserEnabled(String uid, Boolean enabled) {
        userMapper.updateUserEnabled(uid, enabled);
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void deleteUser(String id) {
        User user = getUserInfoByUsername(id);
        userMapper.deleteToken(id);
        userMapper.deleteRegistryInfo(id);
        switch (user.getStatus()) {
            case 1:
                adminMapper.deleteAdmin(id);
                break;
            case 2:
                studentMapper.deleteStudentInfo(id);
                break;
            default:
                throw new IllegalStateException("Unexpected value:" + user.getStatus());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
    public void deleteRoleWithUid(String uid, Integer roleId) {
        userMapper.deleteRoleWithUid(uid, roleId);
    }

    @Override
    public Long getUserNum() {
        return userMapper.findUserNum();
    }

    /**
     * 判断字符串是否属于数字
     * @param input s
     * @return is number?
     */
    private static boolean isNumber(String input) {
        for (int i = 0; i < input.length(); i++) {
            if (!Character.isDigit(input.charAt(i))) {
                return false;
            }
        }
        return true;
    }
}
