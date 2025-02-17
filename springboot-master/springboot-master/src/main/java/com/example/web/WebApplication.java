package com.example.web;

import com.example.web.tools.BaseContext;
import com.example.web.tools.MinioConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@ComponentScan(basePackages = {"com.example"})
@SpringBootApplication 
@EnableScheduling
@EnableTransactionManagement
@EntityScan(basePackages = "com.example.web.model")
@EnableConfigurationProperties(MinioConfig.class)
public class WebApplication {

    public static void main(String[] args) {

        ConfigurableApplicationContext run = SpringApplication.run(WebApplication.class, args);

        BaseContext.setApplicationContext(run);
    }
}
