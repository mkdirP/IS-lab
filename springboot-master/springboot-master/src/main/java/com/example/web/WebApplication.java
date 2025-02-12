package com.example.web;

import com.example.web.tools.BaseContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@ComponentScan(basePackages = {"com.example"})
@SpringBootApplication 
@EnableScheduling
public class WebApplication {

    public static void main(String[] args) {

        ConfigurableApplicationContext run = SpringApplication.run(WebApplication.class, args);

        BaseContext.setApplicationContext(run);
    }
}
