package com.guardlbt.autoCode;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/6.
 */
@Mapper
public interface AutoCodeDao {
    @Select("SELECT COLUMN_NAME, COLUMN_COMMENT,DATA_TYPE,COLUMN_KEY,IS_NULLABLE,EXTRA FROM information_schema.columns" +
            " WHERE table_schema = #{table_schema}  AND table_name = #{table_name}")
    List<Map<String,Object>> selectTable(@Param("table_schema") String table_schema, @Param("table_name") String table_name);
}
