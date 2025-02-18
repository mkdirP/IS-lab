package com.example.web.controller;

import com.example.web.service.MinIOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/minio")
public class MinIOController {

    private final MinIOService minIOService;

    // 构造函数注入 MinIOService
    @Autowired
    public MinIOController(MinIOService minIOService) {
        this.minIOService = minIOService;
    }

    // 上传文件的 POST 请求
    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            // 调用 MinIOService 的 uploadFileWithTransaction 方法上传文件
            String filePath = saveFileToLocal(file);  // 将 MultipartFile 保存到本地路径
            minIOService.uploadFileWithTransaction(filePath, file.getOriginalFilename());

            // 返回成功响应
            return ResponseEntity.ok("File uploaded successfully: " + file.getOriginalFilename());
        } catch (Exception e) {
            // 如果发生错误，返回失败响应
            return ResponseEntity.internalServerError().body("File upload failed: " + e.getMessage());
        }
    }

    // 辅助方法：将 MultipartFile 保存为临时文件
    private String saveFileToLocal(MultipartFile file) throws Exception {
        // 设置临时文件路径
        String tempFilePath = "C:/temp/" + file.getOriginalFilename();
        file.transferTo(new java.io.File(tempFilePath));
        return tempFilePath;
    }
}
