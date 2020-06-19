package com.xust.sims.web.aspect;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;
import org.springframework.util.StringUtils;
import redis.clients.jedis.Jedis;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author LeeCue
 * @date 2020-06-17
 */
@Component
@Aspect
@Slf4j
public class ScriptAspect {
    @Autowired
    private RedisConnectionFactory connectionFactory;
    public static String shaCourseValue = null;
    public static String shaCancelCourseValue = null;

    @Pointcut("execution(* com.xust.sims.web.controller.CourseController.selectCourse(..))")
    public void pointcut() {

    }

    @Before("pointcut()")
    public void before(JoinPoint joinPoint) {
        Jedis jedis = null;
        try {
            if (!StringUtils.isEmpty(shaCourseValue)) {
                log.info("已经初始化脚本文件，sha值为：{}", shaCourseValue);
                return;
            }
            jedis = (Jedis) connectionFactory.getConnection().getNativeConnection();
            InputStream inputStream1 = new ClassPathResource("select_course_procedure.lua").getInputStream();
            InputStream inputStream2 = new ClassPathResource("cacel_course_procedure.lua").getInputStream();
            byte[] bytes1 = new byte[inputStream1.available()];
            byte[] bytes2 = new byte[inputStream2.available()];
            inputStream1.read(bytes1);
            inputStream2.read(bytes2);
            String script1 = new String(bytes1);
            String script2 = new String(bytes2);
            shaCourseValue = jedis.scriptLoad(script1);
            shaCancelCourseValue = jedis.scriptLoad(script2);
            log.info("第一次进入 选课方法 初始化脚本文件，sha值：{}，{}", shaCourseValue, shaCancelCourseValue);
        } catch (IOException e) {
            log.error("初始化脚本文件失败");
            e.printStackTrace();
        } finally {
            if (jedis != null) {
                jedis.close();
            }
        }
    }

}
