package com.example.web.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.web.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * 用户表对应的Mapper
 */
@Mapper
public interface AppUserMapper extends BaseMapper<AppUser> {

    @Select("SELECT AVG(CAST(height AS DECIMAL(10,2))) FROM appuser")
    Double calculateAverageHeight();

}
