package com.xust.sims.dto;

import lombok.Getter;
import lombok.ToString;

/**
 * @author LeeCue
 * @date 2020-03-20
 */
@ToString
@Getter
public class RespBean {
    private Integer status;
    private String msg;
    private Object object;

    public RespBean() {}

    public RespBean(ResponseCode code) {
        this(code.getCode(), code.getMsg());
    }

    public RespBean(ResponseCode code, Object object) {
        this(code.getCode(), code.getMsg());
        this.object = object;
    }

    private RespBean(Integer status, String message) {
        this.status = status;
        this.msg = message;
    }

    private RespBean(Integer status, String message, Object object) {
        this.status = status;
        this.msg = message;
        this.object = object;
    }

    public void setResponseCode(ResponseCode responseCode) {
        this.status = responseCode.getCode();
        this.msg = responseCode.getMsg();
    }

    public void setCodeAndData(ResponseCode responseCode, Object data) {
        this.status = responseCode.getCode();
        this.msg = responseCode.getMsg();
        this.object = data;
    }
}
