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
import java.util.ArrayList;

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
}
