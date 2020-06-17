package com.xust.sims.web.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.AsyncConfigurerSupport;
import org.springframework.scheduling.annotation.EnableAsync;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author LeeCue
 * @date 2020-06-17
 */
@EnableAsync
@Configuration
@PropertySource("classpath:scheduledConfig.properties")
public class WebConfig extends AsyncConfigurerSupport {
    @Value("${taskPoolSize}")
    private int coreSize;
    @Value("${taskMaxPoolSize}")
    private int maxPoolSize;
    @Value("${queueCapacity}")
    private int queueCapacity;
    @Value("${maxWait}")
    private long maxWait;

    @Override
    public Executor getAsyncExecutor() {
        return new ThreadPoolExecutor(
            coreSize, maxPoolSize, maxWait, TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(queueCapacity)
        );
    }
}
