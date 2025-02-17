package com.example.web.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ImportFileService {

    private final MinioService minioService;

    public ImportFileService(MinioService minioService) {
        this.minioService = minioService;
    }

    public String importFile(MultipartFile file) {
        try {
            // 调用 MinioService 处理上传和数据库记录
            return minioService.uploadFileWithLog(file);
        } catch (Exception e) {
            throw new RuntimeException("Fail to upload file：" + e.getMessage());
        }
    }
}
