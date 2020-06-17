package com.xust.sims.web.controller;

import com.alibaba.fastjson.JSON;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.xust.sims.dto.RespBean;
import com.xust.sims.dto.ResponseCode;
import com.xust.sims.dto.TestUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-02
 */
@RestController
@RequestMapping("/web")
@Slf4j
public class LoginController {
    @Autowired
    private DefaultKaptcha defaultKaptcha;

    @RequestMapping("/login")
    public void login(HttpServletResponse response) throws Exception {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        response.setStatus(401);
        writer.write(JSON.toJSONString(new RespBean(ResponseCode.NOT_LOGIN)));
        writer.flush();
        writer.close();
    }

    @GetMapping("/createImageCode")
    public void createImageCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        byte[] captchaAsJpeg = null;
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        try {
            //生产验证码并保存到session中
            String createText = defaultKaptcha.createText();
            request.getSession().setAttribute("imageCode", createText);
            BufferedImage image = defaultKaptcha.createImage(createText);
            log.info("产生的验证码为:{}", createText);
            ImageIO.write(image, "jpg", outputStream);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        //定义响应的类型
        captchaAsJpeg = outputStream.toByteArray();
        //告诉浏览器该响应的属性
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        try (ServletOutputStream responseOutputStream = response.getOutputStream()) {
            responseOutputStream.write(captchaAsJpeg);
            responseOutputStream.flush();
        }
    }

    @PostMapping("/test")
    public TestUser test(TestUser user) {
        log.info("获取的前端的时间为:{}", user);
        user.setTime(new Date(System.currentTimeMillis()));
        return user;
    }
}
