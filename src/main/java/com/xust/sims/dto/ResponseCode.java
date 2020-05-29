package com.xust.sims.dto;

/**
 * @author LeeCue
 * @date 2020-03-16
 */
public enum ResponseCode {
    /**
     * 请求成功
     */
    SUCCESS(200, "请求成功"),
    /**
     * 权限不足
     */
    WARN(403, "权限不足，请求联系管理员"),
    /**
     * 尚未登录
     */
    NOT_LOGIN(206, "尚未登录，请登录"),
    /**
     * 验证码错误
     */
    IMAGE_CODE_ERROR(405, "验证码错误"),
    /**
     * 发生其他错误
     */
    ERROR(406, "错误");
    ResponseCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
    public int getCode() {
        return code;
    }
    public String getMsg() {
        return msg;
    }

    private int code;
    private String msg;
}
