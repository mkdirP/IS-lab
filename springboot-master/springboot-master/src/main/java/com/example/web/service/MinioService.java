package com.example.web.service;

import com.example.web.TransactionalFileService;
import com.example.web.tools.MinioConfig;
import io.minio.*;
import io.minio.messages.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Value;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service
public class MinioService {

    private final MinioConfig minioConfig;
    private final MinioClient minioClient;
    private final String bucketName = "is-lab";
//    private final ImportLogMapper importLogMapper;

    @Autowired
    public MinioService(MinioConfig minioConfig, MinioClient minioClient) {
        this.minioConfig = minioConfig;
        this.minioClient = minioClient;
//        this.importLogMapper = importLogMapper;
    }

    // 上传文件，并记录日志（使用事务）
    @Transactional
    public String uploadFileWithLog(MultipartFile file) throws Exception {
        createBucketIfNotExists(); // 确保桶存在

        String fileName = file.getOriginalFilename();
        InputStream inputStream = file.getInputStream();
//        String bucketName = minioConfig.getBucketName();

        String fileUrl = "http://127.0.0.1:9000/" + bucketName + "/" + fileName;

        try {
            // 1. 上传文件到 MinIO
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucketName)
                            .object(fileName)
                            .stream(inputStream, file.getSize(), -1)
                            .contentType(file.getContentType())
                            .build()
            );
            System.out.println("文件上传成功：" + fileName);
        } catch (Exception e) {
            System.err.println("文件上传失败：" + e.getMessage());
        }

        // 2. 插入数据库日志
//            importLogMapper.insertImportLog(new ImportLog(fileName, fileUrl, "SUCCESS"));
//        } catch (Exception e) {
//            // 如果上传文件成功，但数据库插入失败，则删除 MinIO 文件（补偿机制）
//            minioClient.removeObject(
//                    RemoveObjectArgs.builder().bucket(bucketName).object(fileName).build()
//            );
//            throw new RuntimeException("The file was uploaded successfully, but the database log insertion failed and was rolled back：" + e.getMessage());
//    }
        return fileUrl;
    }

    // 确保桶存在
    private void createBucketIfNotExists() throws Exception {
        boolean found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(minioConfig.getBucketName()).build());
        if (!found) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(minioConfig.getBucketName()).build());
        }
    }
}
