package com.xust.sims.web.config;

import com.alibaba.fastjson.JSON;
import com.xust.sims.entity.User;
import com.xust.sims.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.*;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;

import javax.sql.DataSource;
import java.io.PrintWriter;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 * @author LeeCue
 * @date 2020-03-18
 */
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
@Slf4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserService userService;
    @Autowired
    private CodeFilter codeFilter;
    @Autowired
    private DataSource dataSource;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService);
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl jdbcTokenRepository = new JdbcTokenRepositoryImpl();
        jdbcTokenRepository.setDataSource(dataSource);
        //启动时创建一张表 token
        //jdbcTokenRepository.setCreateTableOnStartup(true);
        return jdbcTokenRepository;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.addFilterBefore(codeFilter, UsernamePasswordAuthenticationFilter.class);
        http.authorizeRequests()
                .antMatchers("/web/createImageCode").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().loginProcessingUrl("/web/doLogin")
                .loginPage("/web/login")
                .usernameParameter("username").passwordParameter("password")
                .successHandler(successHandler())
                .failureHandler(failureHandler())
                .permitAll()
                .and()
                .logout().logoutUrl("/web/logout").clearAuthentication(true).invalidateHttpSession(true)
                .addLogoutHandler((httpServletRequest, httpServletResponse, authentication) -> {})
                .logoutSuccessHandler(logoutSuccessHandler())
                .and()
                .rememberMe().rememberMeParameter("rememberMe").key("accessToken")
                .tokenRepository(persistentTokenRepository())
                .tokenValiditySeconds(((int) Duration.ofDays(7).getSeconds()))
                .and()
                .cors()
                .and()
                .csrf().disable();
    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return (httpServletRequest, httpServletResponse, authentication) -> {
            httpServletResponse.setContentType("application/json;charset=UTF-8");
            PrintWriter writer = httpServletResponse.getWriter();
            httpServletResponse.setStatus(HttpStatus.OK.value());
            Map<String, Object> map = new HashMap<>();
            map.put("status", HttpStatus.OK.value());
            map.put("msg", "登录成功");
            User user = userService.getUserInfoByUsername(authentication.getName());
            user.setRoles(null);
            map.put("user", user);
            writer.write(JSON.toJSONString(map));
            writer.flush();
            writer.close();
        };
    }

    @Bean
    public AuthenticationFailureHandler failureHandler() {
        return (httpServletRequest, httpServletResponse, e) -> {
            httpServletResponse.setContentType("application/json;charset=UTF-8");
            httpServletResponse.setCharacterEncoding("UTF-8");
            PrintWriter writer = httpServletResponse.getWriter();
            httpServletResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
            Map<String, Object> map = new HashMap<>();
            map.put("status", HttpStatus.UNAUTHORIZED.value());
            if (e instanceof LockedException) {
                map.put("msg", "账户被锁定，登录失败!");
            } else if (e instanceof BadCredentialsException) {
                map.put("msg", "账户名或者密码输入错误，登录失败!");
            } else if (e instanceof DisabledException) {
                map.put("msg", "账户被禁用，登录失败!");
            } else if (e instanceof AccountExpiredException) {
                map.put("msg", "账户已过期，登录失败!");
            } else if (e instanceof CredentialsExpiredException) {
                map.put("msg", "密码已过期，登录失败!");
            } else {
                map.put("msg", "登录失败，未知错误!");
            }
            writer.write(JSON.toJSONString(map));
            writer.flush();
            writer.close();
        };
    }

    @Bean
    public LogoutSuccessHandler logoutSuccessHandler() {
        return (httpServletRequest, httpServletResponse, authentication) -> {
            httpServletResponse.setStatus(HttpStatus.OK.value());
            httpServletResponse.setContentType("application/json;charset=utf-8");
            PrintWriter writer = httpServletResponse.getWriter();
            Map<String, Object> map = new HashMap<>();
            map.put("status", HttpStatus.OK.value());
            map.put("msg", "注销成功");
            writer.write(JSON.toJSONString(map));
            writer.flush();
            writer.close();
        };
    }
}
