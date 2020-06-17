package com.xust.sims.utils;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @author LeeCue
 * @date 2020-06-17
 */
public class UrlEncodeUtils {
    /**
     * 获取URL编码
     * @param url
     * @return
     */
    public static String getUrlSign(String url) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            url = url + System.currentTimeMillis();
            md5.update(url.getBytes(StandardCharsets.UTF_8));
            byte[] b = md5.digest();
            int i = 0;
            StringBuilder sb = new StringBuilder();
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0) {
                    i += 256;
                } else if (i < 16) {
                    sb.append("0");
                }
                sb.append(Integer.toHexString(i));
            }
            url = sb.toString();
            System.out.println("加密后的URL为：" + url);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return url;
    }
}
