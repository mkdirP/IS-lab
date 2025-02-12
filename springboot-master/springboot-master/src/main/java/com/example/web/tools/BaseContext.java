package com.example.web.tools;

import com.example.web.tools.dto.CurrentUserDto;
import org.springframework.context.ApplicationContext;

/**
 * 当前现成中的一些公共上下文
 */
public class BaseContext {
    private static ThreadLocal<CurrentUserDto> threadLocal = new ThreadLocal<>();

    /**
     * 设置当前的用户信息
     */
    public static void setCurrentUserDto(CurrentUserDto dto) {
        threadLocal.set(dto);
    }

    /**
     * 获取当前的用户信息
     */
    public static CurrentUserDto getCurrentUserDto() {
        return threadLocal.get();
    }

    private static ApplicationContext _applicationContext;

    public static void setApplicationContext(ApplicationContext applicationContext) {
        _applicationContext = applicationContext;
    }

    /**
     * 得到应用程序的上下文对象
     * @return
     */
    public static ApplicationContext getApplicationContext(){
        return _applicationContext;

    }
}
