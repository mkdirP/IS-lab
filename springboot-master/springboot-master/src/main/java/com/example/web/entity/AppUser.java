package com.example.web.entity;
import com.baomidou.mybatisplus.annotation.*;
import com.example.web.dto.AppUserDto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.apache.commons.beanutils.BeanUtils;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

@Data
@TableName("AppUser")
public class AppUser extends  BaseEntity {

    /**
     * 账号
     */
    @JsonProperty("UserName")
    @TableField(value = "UserName")
    private String UserName;
    /**
     * 密码
     */
    @JsonProperty("Password")
    @TableField(value = "Password")
    private String Password;

    /**
     * 邮箱
     */
    @JsonProperty("Email")
    @TableField(value = "Email")
    private String Email;
    /**
     * 头像
     */
    @JsonProperty("ImageUrls")
    @TableField(value = "ImageUrls")
    private String ImageUrls;
    /**
     * 名称
     */
    @JsonProperty("Name")
    @TableField(value = "Name")
    private String Name;
    /**
     * 手机号码
     */
    @JsonProperty("PhoneNumber")
    @TableField(value = "PhoneNumber")
    private String PhoneNumber;
    /**
     * 出生年月
     */
    @JsonProperty("Birth")
    @TableField(value = "Birth")
    private LocalDateTime Birth;

    /**
     * 用户角色
     */
    @JsonProperty("RoleType")
    @TableField(value = "RoleType")
    private Integer RoleType;

    @JsonProperty("EyeColor")
    @TableField(value="EyeColor",updateStrategy = FieldStrategy.IGNORED)
    private String EyeColor;

    @JsonProperty("HairColor")
    @TableField(value="HairColor",updateStrategy = FieldStrategy.IGNORED)
    private String HairColor;

    @JsonProperty("Height")
    @TableField(value="Height",updateStrategy = FieldStrategy.IGNORED)
    private String Height;

    @JsonProperty("Nationality")
    @TableField(value="Nationality",updateStrategy = FieldStrategy.IGNORED)
    private String Nationality;

    @JsonProperty("Location")
    @TableField(value="Location",updateStrategy = FieldStrategy.IGNORED)
    private String Location;

    /**
     * 把用户实体转换成用户传输模型
     */
    public AppUserDto MapToDto() throws InvocationTargetException, IllegalAccessException {
        AppUserDto AppUserDto = new AppUserDto();
        BeanUtils.copyProperties(AppUserDto,this);
        return AppUserDto;
    }

}
