package com.xust.sims.web.aspect;

import lombok.AllArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
@Component
@Aspect
@Slf4j
public class LogAspect {

    @Pointcut("execution(* com.xust.sims.web.controller..*.*(..))")
    public void pointcut(){
    }

    @Before("pointcut()")
    public void deBefore(JoinPoint joinPoint) {
        ServletRequestAttributes attributes = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes());
        assert attributes != null;
        HttpServletRequest request = attributes.getRequest();
        String url = request.getRequestURL().toString();
        String ip = request.getRemoteAddr();
        String sessionId = request.getSession().getId();
        String classMethod = joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName();
        Object[] args = joinPoint.getArgs();
        RequestLog requestLog = new RequestLog(url, sessionId, ip, classMethod, args);
        log.info("Request: {}", requestLog);
    }

    @AfterThrowing(pointcut = "pointcut()", throwing = "exception")
    public void doAfterThrowing(Throwable exception) {
        log.info("Exception: {}", exception.getMessage());
    }

    @AfterReturning(pointcut = "pointcut()", returning = "result")
    public void doAfterReturning(Object result) {
        log.info("Result: {}", result);
    }

    @AllArgsConstructor
    @ToString
    private static class RequestLog {
        private final String url;
        private final String sessionId;
        private final String ip;
        private final String classMethod;
        private final Object[] args;
    }

}
