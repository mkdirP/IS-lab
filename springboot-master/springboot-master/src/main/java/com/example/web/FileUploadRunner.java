package com.example.web;

import com.example.web.service.MinIOService;
import io.minio.MinioClient;
import io.minio.BucketExistsArgs;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class FileUploadRunner implements CommandLineRunner {

    private final MinIOService minIOService;
    private final MinioClient minioClient;
    private final String bucketName;

    // 注入依赖
    public FileUploadRunner(MinIOService minIOService, MinioClient minioClient, @Value("${minio.bucket-name}") String bucketName) {
        this.minIOService = minIOService;
        this.minioClient = minioClient;
        this.bucketName = bucketName;
    }

    // 检查 MinIO 连接
    public void checkMinioConnection() {
        try {
            // 检查桶是否存在
            boolean isBucketExist = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());

            if (isBucketExist) {
                System.out.println("Successfully connected to MinIO and bucket exists.");
            } else {
                System.out.println("Connected to MinIO, but the bucket does not exist.");
            }
        } catch (Exception e) {
            System.out.println("Failed to connect to MinIO: " + e.getMessage());
        }
    }

    @Override
    public void run(String... args) throws Exception {
        checkMinioConnection();
        minIOService.uploadFileWithTransaction("C:\\Users\\MkdirP\\Desktop\\1.txt", "uploaded/test.txt");
    }
}
