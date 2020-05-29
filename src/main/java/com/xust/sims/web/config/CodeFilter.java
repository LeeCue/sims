package com.xust.sims.web.config;

import com.alibaba.fastjson.JSONObject;
import com.xust.sims.utils.CodeUtils;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author LeeCue
 * @date 2020-03-19
 */
@Component
public class CodeFilter extends GenericFilterBean {
    private String defaultFilterProcessUrl = "/doLogin";

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (HttpMethod.POST.name().equalsIgnoreCase(request.getMethod()) && defaultFilterProcessUrl.equals(request.getServletPath())) {
            //验证码验证
            String requestCaptcha = request.getParameter("imageCode");
            if (!CodeUtils.checkVerifyCode(request, requestCaptcha)) {
                response.setStatus(405);
                response.setContentType("application/json;charset=utf-8");
                PrintWriter writer = response.getWriter();
                JSONObject json = new JSONObject();
                json.put("msg", "验证码有误");
                writer.write(json.toJSONString());
                writer.flush();
                writer.close();
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
}
