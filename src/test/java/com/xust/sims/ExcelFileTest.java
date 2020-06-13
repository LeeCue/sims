package com.xust.sims;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.alibaba.excel.write.metadata.style.WriteCellStyle;
import com.alibaba.excel.write.style.HorizontalCellStyleStrategy;
import com.xust.sims.dto.StudentExcelData;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @author LeeCue
 * @date 2020-05-06
 */
@SpringBootTest
@Slf4j
public class ExcelFileTest {
    @Test
    public void WriteTemplateFile() {
        //标题头样式策略
        WriteCellStyle headStyle = new WriteCellStyle();
        headStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
        HorizontalCellStyleStrategy horizontalCellStyleStrategy = new HorizontalCellStyleStrategy(headStyle, new WriteCellStyle());
        String path = System.getProperty("user.dir");
        String filePath = path + File.separator + "test" + System.currentTimeMillis() + ".xlsx";
        ExcelWriter excelWriter = EasyExcel.write(filePath, StudentExcelData.class)
                .registerWriteHandler(horizontalCellStyleStrategy).build();
        WriteSheet writeSheet = EasyExcel.writerSheet("模板").build();
        excelWriter.write(new ArrayList(), writeSheet);
        excelWriter.finish();
    }

    @Test
    public void testSchedule() throws Exception{
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date date = dateFormat.parse("2020-6-11 15:30:00");
        ScheduledExecutorService executorService = Executors.newScheduledThreadPool(10);
        executorService.schedule(new Runnable() {
            @Override
            public void run() {
                System.out.println("我被执行了..." + dateFormat.format(new Date()));
            }
        }, date.getTime(), TimeUnit.MILLISECONDS);
    }
}
