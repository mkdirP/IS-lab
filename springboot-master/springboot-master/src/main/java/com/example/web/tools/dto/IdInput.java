package com.example.web.tools.dto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class IdInput {
    @JsonProperty("Id")
    private Integer Id;
}
