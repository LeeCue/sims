package com.xust.sims;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import redis.clients.jedis.Jedis;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

@SpringBootTest
@Slf4j
class SimsApplicationTests {
    @Autowired
    private RedisConnectionFactory connectionFactory;

    @Autowired
    private RedisTemplate redisTemplate;

    @Test
    void contextLoads() {
        RedisConnection connection = connectionFactory.getConnection();
        Jedis jedis = ((Jedis) connection.getNativeConnection());
        Object o = jedis.eval("return 'hello world'");

        log.info(o.toString());
    }

    @Test
    void encodeURL() {
        String url = "http://localhost:9000/web/good/";
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(url.getBytes(StandardCharsets.UTF_8));
            byte[] b = md5.digest();
            int i = 0;
            StringBuilder sb = new StringBuilder();
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0) {
                    i += 256;
                }
                if (i < 16) {
                    sb.append("0");
                }
                sb.append(Integer.toHexString(i));
            }
            url = sb.toString();
            System.out.println("result = " + url);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

}
