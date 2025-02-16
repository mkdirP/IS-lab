package com.example.web.dto.query;

import com.baomidou.mybatisplus.annotation.TableField;
import com.example.web.dto.AppUserDto;
import com.example.web.tools.dto.PagedInput;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class AppUserPagedInput  extends PagedInput {
    @JsonProperty("Id")
    private Integer Id;

    /**
     * 姓名
     */
    @JsonProperty("Name")
    private String Name;

    /**
     * 邮箱
     */
    @JsonProperty("Email")
    private String Email;

    /**
     * 手机号码
     */
    @JsonProperty("PhoneNumber")
    private String PhoneNumber;

    /**
     * 用户角色
     */
    @JsonProperty("RoleType")
    private Integer RoleType;

    /**
     * 眼睛颜色查询条件
     */
    @JsonProperty("EyeColor")
    private String EyeColor;
    /**
     * 头发颜色模糊查询条件
     */
    @JsonProperty("HairColor")
    private String HairColor;
    /**
     * 体重模糊查询条件
     */
    @JsonProperty("Height")
    private String Height;
    /**
     * 国家查询条件
     */
    @JsonProperty("Nationality")
    private String Nationality;

    @JsonProperty("Location")
    private String Location;


}
