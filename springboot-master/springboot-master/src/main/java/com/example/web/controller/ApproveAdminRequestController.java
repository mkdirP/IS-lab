package com.example.web.controller;

import com.example.web.entity.AppUser;
import com.example.web.enums.RoleTypeEnum;
import com.example.web.PendingAdminRequest;
import com.example.web.mapper.AppUserMapper;
import com.example.web.mapper.PendingAdminRequestMapper;
import com.example.web.tools.dto.ResponseData;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@PreAuthorize("hasRole('ADMIN')")
@RestController
@RequestMapping("/admin") // 统一前缀，规范 API 设计
public class ApproveAdminRequestController {

    @Autowired
    private PendingAdminRequestMapper pendingAdminRequestMapper;

    private static final Logger logger = LoggerFactory.getLogger(ApproveAdminRequestController.class);

    @Autowired
    private AppUserMapper appUserMapper;

    /**
     * 审核管理员申请接口
     */
    @SneakyThrows
    @PostMapping("/approve/{username}")
    public ResponseEntity<ResponseData> approveAdminRequest(@PathVariable String username) {
        // 根据用户名从待审核表中获取该用户
        PendingAdminRequest pendingRequest = pendingAdminRequestMapper.selectByUsername(username);
        if (pendingRequest == null) {
            // 返回响应数据：没有找到待审核的管理员请求
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    ResponseData.GetResponseDataInstance(null, "No pending admin request found for this username.", false)
            );
        }

        // 构造 AppUser 实体
        AppUser appUser = new AppUser();
        appUser.setUserName(pendingRequest.getUsername());
        appUser.setPassword(pendingRequest.getPassword()); // 密码应在注册时已加密
        appUser.setEmail(pendingRequest.getEmail());
        appUser.setPhoneNumber(pendingRequest.getPhonenumber());
        appUser.setRoleType(RoleTypeEnum.admin.index()); // 设为管理员

        // 插入新管理员信息
        appUserMapper.insert(appUser);

        // 删除待审核表中的记录
        pendingAdminRequestMapper.deleteByUsername(username);

        // 返回响应数据：管理员请求审核通过
        return ResponseEntity.ok(
                ResponseData.GetResponseDataInstance(null, "Admin request approved and user added as admin.", true)
        );
    }

    /**
     * 获取所有待审核的管理员申请
     */
    @GetMapping("/pending")
    public ResponseEntity<List<PendingAdminRequest>> getPendingAdminRequests() {
        List<PendingAdminRequest> pendingRequests = pendingAdminRequestMapper.selectList(null);
        logger.info("查询到的待审核管理员申请: {}", pendingRequests);
        return ResponseEntity.ok(pendingRequests);
    }
}
