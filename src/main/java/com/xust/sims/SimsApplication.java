package com.xust.sims;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author LeeCue
 * @date 2020-3-2
 */
@SpringBootApplication
@MapperScan("com.xust.sims.dao")
@EnableCaching
public class SimsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SimsApplication.class, args);
    }

}
