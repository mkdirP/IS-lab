package com.example.web;


import lombok.Data;
import java.util.HashMap;
import java.util.Map;

@Data
public class R<T> {
    private Integer code; // 状态码
    private String msg;  // 消息
    private T data;      // 数据
    private Map<String, Object> extra = new HashMap<>(); // 扩展字段

    // 通用成功（无数据）
    public static <T> R<T> success() {
        R<T> r = new R<>();
        r.setCode(200);
        r.setMsg("成功");
        return r;
    }

    // 成功（带数据）
    public static <T> R<T> success(T data) {
        R<T> r = new R<>();
        r.setCode(200);
        r.setMsg("成功");
        r.setData(data);
        return r;
    }

    // 通用错误
    public static <T> R<T> error(String msg) {
        R<T> r = new R<>();
        r.setCode(500);
        r.setMsg(msg);
        return r;
    }

    // 带状态码的错误
    public static <T> R<T> error(int code, String msg) {
        R<T> r = new R<>();
        r.setCode(code);
        r.setMsg(msg);
        return r;
    }

    // 链式添加扩展字段
    public R<T> add(String key, Object value) {
        this.extra.put(key, value);
        return this;
    }
}