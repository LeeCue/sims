package com.xust.sims.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-04-08
 */
@Data
public class TestUser {
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date time;
}
