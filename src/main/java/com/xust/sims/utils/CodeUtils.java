package com.xust.sims.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author LeeCue
 * @date 2020-03-14
 */
public class CodeUtils {
    /**
     * 对验证码校验
     * @param request 请求
     * @return 验证码是否正确，true为正确，false为错误
     */
    public static boolean checkVerifyCode(HttpServletRequest request, String verifyCodeActual) {
        String verifyCodeExcepted = (String) request.getSession().getAttribute("imageCode");
        if (verifyCodeActual == null || !verifyCodeActual.equalsIgnoreCase(verifyCodeExcepted)) {
            return false;
        }
        return true;
    }
}
