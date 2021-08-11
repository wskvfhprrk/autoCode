package ${daoPackage};

import ${entityPackage}.${className?cap_first};
import org.apache.ibatis.annotations.*;

import java.util.*;

/**
* ${moduleName}dao方法
* Created by 代码自动生成.
* 时间:${.now?string("yyyy-MM-dd HH:mm:ss")}
*/
@Mapper
public interface ${className?cap_first}Dao {

    /**
    * 条件查询全部数据
    * @param ${className}
    * @return List<Map>类型的集合
    */
    @Results(<#--id = "${className}Result", -->value = {
    <#list data as d>
        @Result(column = "${d.columnName}", property = "${d.beanName}"${d.id?string(", id=true","")}),
    </#list>
    })
    @SelectProvider(type = ${className?cap_first}DaoSQL.class, method = "select${className?cap_first}s")
    List<${className?cap_first}> select${className?cap_first}s(${className?cap_first} ${className});


    /**
    * 添加
    * @param ${className}
    */
    @SelectProvider(type = ${className?cap_first}DaoSQL.class, method = "insert")
    void insert(${className?cap_first} ${className});

    /**
    * 更新
    * @param ${className}
    */
    @SelectProvider(type = ${className?cap_first}DaoSQL.class, method = "update")
    void update(${className?cap_first} ${className});

    /**
    * 根据条件删除
    * @param ${className}
    */
    @SelectProvider(type = ${className?cap_first}DaoSQL.class, method = "delete")
    void delete(${className?cap_first} ${className});

    /**
    * 根据主键IDS批量删除(只适合单主键,不支持多主键批量删除,多主键时请删除SQL中多余主键字段)
    * @param ids 主键字符串集合
    */
    <#--@SelectProvider(type = ${className?cap_first}DaoSQL.class, method = "deleteAll")-->
    @Select("<script>" +
    <#assign str='#\{item}' >
        "DELETE FROM ${tableName} WHERE <#list data as d><#if d.id=true>${d.columnName} </#if></#list>IN " +
        "<foreach item='item' index='index' collection='ids' open='(' separator=',' close=')'>${str}</foreach> </script>")
    void deleteAll(@Param("ids") List<String> ids);

}
