package com.xust.sims.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@ToString
@Setter
@NoArgsConstructor
public class Registry implements UserDetails {
    @Getter
    private String uid;
    @JsonIgnore
    private String password;
    private String name;
    @Getter
    private Integer status;
    private Boolean locked = Boolean.FALSE;
    private Boolean enabled = Boolean.TRUE;
    @Getter
    private List<Role> roles;

    public Registry(String uid, String password, String name, Integer status) {
        this.uid = uid;
        this.password = password;
        this.name = name;
        this.status = status;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> list = new ArrayList<>();
        for (Role role : roles) {
            list.add(new SimpleGrantedAuthority(role.getName()));
        }
        return list;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return uid;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return !locked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }
}
