package com.xust.sims.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-04-16
 */
@Data
public class StudentInfoQuery {
    private String id;
    private String name;
    private Integer selectedAcademy;
    private Integer selectedMajor;
    private Integer selectedClass;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;
    @NotNull
    private Integer pageNum;
    @NotNull
    private Integer pageSize;
}
