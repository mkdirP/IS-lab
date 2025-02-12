package com.example.web.dto;

import com.example.web.entity.AppUser;
import com.example.web.enums.RoleTypeEnum;
import com.example.web.tools.dto.BaseDto;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.apache.commons.beanutils.BeanUtils;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

@Data
public class AppUserDto extends BaseDto
{
    /**
     * 账号
     */
    @JsonProperty("UserName")
    private String UserName;
    /**
     * 密码
     */
    @JsonProperty("Password")
    private String Password;
    /**
     * 原始密码
     */
    @JsonProperty("OrginPassword")
    private String OrginPassword;


    /**
     * 邮箱
     */
    @JsonProperty("Email")
    private String Email;
    /**
     * 头像
     */
    @JsonProperty("ImageUrls")
    private String ImageUrls;
    /**
     * 名称
     */
    @JsonProperty("Name")
    private String Name;
    /**
     * 手机号码
     */
    @JsonProperty("PhoneNumber")
    private String PhoneNumber;
    /**
     * 出生年月
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonProperty("Birth")
    @JsonSerialize(using= LocalDateTimeSerializer.class)
    @JsonDeserialize(using= LocalDateTimeDeserializer.class)
    private LocalDateTime Birth;


    /**
     * 用户角色
     */
    @JsonProperty("RoleType")
    private Integer RoleType;

    @JsonProperty("RoleTypeFormat")
    public  String RoleTypeFormat(){
        return RoleTypeEnum.GetEnum(RoleType).toString();
    };

    /**
     * 眼睛颜色
     */
    @JsonProperty("EyeColor")
    private String EyeColor;

    /**
     * 头发颜色
     */
    @JsonProperty("HairColor")
    private String HairColor;

    /**
     * 体重
     */
    @JsonProperty("Height")
    private String Height;

    /**
     * 国家
     */
    @JsonProperty("Nationality")
    private String Nationality;

    @JsonProperty("Location")
    private String Location;

    /**
     * 把用户传输模型转换成用户实体
     */
    public AppUser MapToEntity() throws InvocationTargetException, IllegalAccessException {
        AppUser AppUser= new AppUser();
        BeanUtils.copyProperties(AppUser,this);
        return AppUser;
    }
//    private String salt;
//    public String getSalt() {
//        return salt;
//    }
//
//    public void setSalt(String salt) {
//        this.salt = salt;
//    }

}
