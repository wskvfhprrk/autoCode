package ${servicePackage};

import ${entityPackage}.${className?cap_first};
import ${basePackage}.util.entity.*;

import java.util.*;

/**
* ${moduleName}方法类接口
* Created by 代码自动生成.
* 时间:${.now?string("yyyy-MM-dd HH:mm:ss")}
*/
public interface ${className?cap_first}Service {
    /**
    * 分页查询
    * @param page 页码
    * @param row 每页最行数
    * @param ${className} 条件参数
    * @return easyui结果集
    */
    EasyUIDataGridResult findPageBy${className?cap_first}(Integer page, Integer row, ${className?cap_first} ${className});

    /**
    * 条件查询全部数据
    * @param ${className} 条件参数
    * @return 全部数据
    */
    List<${className?cap_first}> findAllBy${className?cap_first}(${className?cap_first} ${className});

    /**
    * 根据条件,只查询唯一一个值,如果存在多个只返回第一个
    * @param ${className} 条件参数
    * @return K,V键值对类型的Map对象
    */
    ${className?cap_first} find${className?cap_first}(${className?cap_first} ${className});

    /**
    * 添加
    * @param ${className} 条件参数
    * @return 结果集
    */
    Result insert(${className?cap_first} ${className});
    /**
    * 修改
    * @param ${className} 条件参数
    * @return 结果集
    */
    Result update(${className?cap_first} ${className});
    /**
    * 删除
    * @param ${className} 条件参数
    * @return 结果集
    */
    Result delete(${className?cap_first} ${className});
    /**
    * 批量删除
    * @param ids 以逗号隔开的主键字符串
    * @return 结果集
    */
    Result deleteAll(String ids);
}
