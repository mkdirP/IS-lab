package com.example.web.tools;

import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.web.tools.dto.PagedInput;
import com.example.web.tools.dto.PagedResult;
import java.time.LocalDate;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

/**
 * 扩展方法
 */
public class Extension {

    /**
     * 判断字符串是否为空或者空串
     */
    public static boolean isNotNullOrEmpty(String str) {
        return str != null && !str.isEmpty();
    }

    /**
     * 判断字符串是否是空或者空串
     */
    public static boolean isNullOrEmpty(String str) {
        return !isNotNullOrEmpty(str);
    }
    /**
     * 判断Id是否存在
     */
    public static boolean isNullOrZero(Integer value) {
        return value==null||value==0;
    }

    /**
     * 拷贝一个列表到另外一个列表
     */
    public static <T> List<T> copyBeanList(List<?> resourceList, Class<T> target) {
        List<T> targetList = new LinkedList<>();
        if (resourceList.isEmpty()) {
            return targetList;
        }
        resourceList.forEach(e -> {
            T o = null;
            try {
                o = target.newInstance();
            } catch (InstantiationException | IllegalAccessException ex) {
                ex.printStackTrace();
            }
            org.springframework.beans.BeanUtils.copyProperties(e, o);
            targetList.add(o);
        });
        return targetList;
    }

    /**
     * 获取当前的用户信息 根据token
     */
    public static String  getTokenInfo(String token,String key)
    {
        token=token.replace("Bearer ","");
        DecodedJWT jwt=JWTUtils.getTokenInfo(token);
        return   jwt.getClaims().get(key).asString();
    }

    /**
     * LocalDateTime戳转换成字符串
     */
    public static String LocalDateTimeConvertString(LocalDateTime localDateTime, String format){
        if(localDateTime==null){
            return "";
        }
        if(format==null) {
            format = format = "yyyy-MM-dd HH:mm:ss";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);

        return localDateTime.format(formatter);
    }
    /**
     * 保留4位小数
     */
    public static double ToFixed4(double value) {
        return Math.round(value * Math.pow(10, 4)) / Math.pow(10, 4);
    }
    /**
     * 保留2位小数
     */
    public static double ToFixed2(double value) {
        return Math.round(value * Math.pow(10, 2)) / Math.pow(10, 2);
    }
    /**
     * 去掉小数
     */
    public static double ToFixed0(double value) {
        return Math.round(value * Math.pow(10, 0)) / Math.pow(10, 0);
    }
    /**
     * 构建分页结果
     */
    public static <T> PagedResult PagedResultBuild(List<T> items, PagedInput input) {
        int totalCount = items.size();
        items = items.subList((int) ((input.getPage() - 1) * input.getLimit()), (int) Math.min(input.getPage() * input.getLimit(), items.size()));
        //返回一个分页结构给前端
        return PagedResult.GetInstance(items, (long) totalCount);
    }
     /**
     * 生成一个单号
     * @return
     */
    public static String GenerateOrderNumber() {
        // 获取当前时间
        Date now = new Date();
        // 格式化时间，例如：20220101123456
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String timeStr = dateFormat.format(now);
        // 生成随机数，例如：123456
        int randomNum = (int) (Math.random() * 900000 + 100000);
        // 拼接单号
        String orderNumber = timeStr + randomNum;
        return orderNumber;
    }
  
     /**
     * 根据日期得到今天是星期几
     */
    public static String GetWeek(LocalDate localDate) {
        return localDate.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.CHINESE);
    }
}
