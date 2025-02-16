package com.example.web.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.web.PendingAdminRequest;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface PendingAdminRequestMapper extends BaseMapper<PendingAdminRequest> {
    // 根据 username 查找待审核记录
    @Select("SELECT * FROM pending_admin_request WHERE username = #{username}")
    PendingAdminRequest selectByUsername(String username);

    // 根据 username 删除待审核记录
    @Delete("DELETE FROM pending_admin_request WHERE username = #{username}")
    public void deleteByUsername(String username);

}