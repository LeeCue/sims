package com.xust.sims.receiver;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import javax.jms.Queue;


/**
 * @author LeeCue
 * @date 2020-05-06
 */
@Component
public class MessageQueue {
    @Bean
    public Queue queue() {
        return new ActiveMQQueue("com.xust.student.welcome");
    }
}
