package com.example.web.tools.dto;
import com.example.web.enums.RoleTypeEnum;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class CurrentUserDto {

    @JsonProperty("UserId")
    private Integer UserId;
  
    @JsonProperty("RoleType")
    private RoleTypeEnum RoleType;
}
