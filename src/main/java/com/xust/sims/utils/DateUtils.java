package com.xust.sims.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author LeeCue
 * @date 2020-03-29
 */
public class DateUtils {
    private static ThreadLocal<SimpleDateFormat> local = null;

    static {
        local = new ThreadLocal<>();
    }

    public static String dateFormat(Date date) {
        SimpleDateFormat dateFormat = local.get();
        if (dateFormat == null) {
            dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            local.set(dateFormat);
        }
        return dateFormat.format(date);
    }

    public static void main(String[] args) {
        Date date = new Date(System.currentTimeMillis());
        System.out.println(date);
        System.out.println(dateFormat(date));
    }
}
