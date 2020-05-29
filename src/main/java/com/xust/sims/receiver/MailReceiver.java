package com.xust.sims.receiver;

import com.xust.sims.entity.Student;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;

/**
 * @author LeeCue
 * @date 2020-05-06
 */
@Component
@Slf4j
public class MailReceiver {
    private final JavaMailSender javaMailSender;
    @Autowired
    private MailProperties mailProperties;
    @Autowired
    private TemplateEngine templateEngine;

    public MailReceiver(@Autowired @Qualifier("mailConfig") Properties mailConfig,
                        @Autowired JavaMailSender javaMailSender) {
        ((JavaMailSenderImpl) javaMailSender).setJavaMailProperties(mailConfig);
        this.javaMailSender = javaMailSender;
    }

    @JmsListener(destination = "com.xust.student.welcome")
    public void handler(Student student) {
        log.info(student.toString());
        log.info("mailProperties is {}", mailProperties.toString());
        //收到消息，发送邮件
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        try {
            helper.setTo(student.getEmail());
            helper.setFrom(mailProperties.getUsername());
            helper.setSubject("欢迎邮件");
            helper.setSentDate(new Date());
            Context context = new Context();
            context.setVariable("name", student.getName());
            context.setVariable("id", student.getId());
            String idCard = student.getIdCard();
            context.setVariable("password", idCard.substring(idCard.length() - 6));
            String mail = templateEngine.process("mail", context);
            helper.setText(mail, true);
            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            log.error("邮件发送失败：" + e.getMessage());
        }
    }

}
