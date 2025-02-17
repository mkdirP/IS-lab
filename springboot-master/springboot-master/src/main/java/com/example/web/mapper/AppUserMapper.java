package com.example.web.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.web.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户表对应的Mapper
 */
@Mapper
public interface AppUserMapper extends BaseMapper<AppUser> {

    @Select("SELECT AVG(CAST(height AS DECIMAL(10,2))) FROM appuser")
    Double calculateAverageHeight();


    // 查询并统计 hairColor 的数量
    @Select("SELECT haircolor AS color, COUNT(*) AS count FROM appuser GROUP BY haircolor")
    List<Map<String, Object>> countHairColor();

    // 查询并统计 eyeColor 的数量
    @Select("SELECT eyecolor AS color, COUNT(*) AS count FROM appuser GROUP BY eyecolor")
    List<Map<String, Object>> countEyeColor();

}
