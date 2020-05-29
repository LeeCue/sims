package com.xust.sims.exceldatalistener;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.excel.exception.ExcelDataConvertException;
import com.alibaba.fastjson.JSON;
import com.xust.sims.dto.StudentExcelData;
import com.xust.sims.service.StudentInfoService;
import com.xust.sims.service.StudentInfoServiceImpl;
import com.xust.sims.utils.ExcelValidateHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-05-23
 */
@Slf4j
public class StudentDataListener extends AnalysisEventListener<StudentExcelData> {
    private static final int BATCH_COUNT = 20;
    private final List<StudentExcelData> list = new ArrayList<>();
    private StudentInfoService studentInfoService;

    public StudentDataListener(StudentInfoService studentInfoService) {
        this.studentInfoService = studentInfoService;
    }

    /**
     * 每一条数据解析都会调用该方法
     * @param studentExcelData 一行的value
     * @param analysisContext
     */
    @Override
    public void invoke(StudentExcelData studentExcelData, AnalysisContext analysisContext) {
        log.info("解析到一条excel数据：{}", JSON.toJSONString(studentExcelData));
        String errorMessage = null;
        try {
            errorMessage = ExcelValidateHelper.validateEntity(studentExcelData);
        } catch (NoSuchFieldException e) {
            errorMessage = "解析数据出错";
            e.printStackTrace();
        }
        if (StringUtils.isEmpty(errorMessage)) {
            list.add(studentExcelData);
        } else {
            studentExcelData.setDescription(errorMessage);
            ((StudentInfoServiceImpl) studentInfoService).getErrorList().add(studentExcelData);
        }
        //达到BATCH_COUNT，需要存储一次数据库，防止几万条数据在内存中，出现OOM
        if (list.size() >= BATCH_COUNT) {
            try {
                studentInfoService.saveExcelData(list);
            } catch (Exception e) {
                e.printStackTrace();
            }
            list.clear();
        }
    }

    /**
     * 在转换异常，获取其他异常下会调用该接口。抛出异常则停止读取。如果这里不抛出异常，则继续读取下一行
     * @param exception
     * @param context
     * @throws Exception
     */
    @Override
    public void onException(Exception exception, AnalysisContext context) throws Exception {
        log.error("解析失败，但是继续解析下一行:{}", exception.getMessage());
        // 如果是某一个单元格的转换异常 能获取到具体行号
        // 如果要获取头的信息 配合invokeHeadMap使用
        if (exception instanceof ExcelDataConvertException) {
            ExcelDataConvertException excelDataConvertException = (ExcelDataConvertException)exception;
            log.error("第{}行，第{}列解析异常", excelDataConvertException.getRowIndex(),
                    excelDataConvertException.getColumnIndex());
        }
    }

    /**
     * 所有数据都被解析完成，会调用该方法
     * @param analysisContext
     */
    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        try {
            if (list.size() > 0) {
                studentInfoService.saveExcelData(list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        log.info("所有数据已被解析完成！");
        list.clear();
    }

}
