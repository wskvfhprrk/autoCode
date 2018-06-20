package ${serviceImplPackage};

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${daoPackage}.${className?cap_first}Dao;
import ${entityPackage}.${className?cap_first};
import ${servicePackage}.${className?cap_first}Service;
import ${basePackage}.util.entity.*;
import ${basePackage}.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;


/**
* ${moduleName}方法实现类
* Created by 代码自动生成.
* 时间:${.now?string("yyyy-MM-dd HH:mm:ss")}
*/
@Service
@Transactional
public class ${className?cap_first}ServiceImpl implements ${className?cap_first}Service {

    @Autowired
    private ${className?cap_first}Dao dao;

    @Override
    public EasyUIDataGridResult findPageBy${className?cap_first}(Integer page, Integer row, ${className?cap_first} ${className}) {
        EasyUIDataGridResult result=new EasyUIDataGridResult();
        PageHelper.startPage(page,row);
        List<${className?cap_first}> list = dao.select${className?cap_first}s(${className});
        PageInfo<${className?cap_first}> info=new PageInfo<>(list);
        result.setTotal(info.getTotal());
        result.setRows(info.getList());
        return result;
    }

    @Override
    public List<${className?cap_first}> findAllBy${className?cap_first}(${className?cap_first} ${className}) {
        return dao.select${className?cap_first}s(${className});
    }

    @Override
    public ${className?cap_first} find${className?cap_first}(${className?cap_first} ${className}) {
        List<${className?cap_first}> list = dao.select${className?cap_first}s(${className});
        if(!list.isEmpty()){
            return list.get(0);
        }
        return null;
    }

    @Override
    public Result insert(${className?cap_first} ${className}) {
        <#list data as d><#if d.id==true && d.extpa==false >${className}.set${d.beanName?cap_first}(UuidUtild.getUUID());//如果多主键此处要更改</#if></#list>
        <#list data as d><#if d.isNull==false && d.id==false>
        if(${className}.get${d.beanName?cap_first}()==null || ${className}.get${d.beanName?cap_first}().toString().length()==0){
            return Result.build(500,"${d.commentName}不能为空值");
        }
        </#if></#list>
        try{
            dao.insert(${className});
            return Result.ok();
        }catch (Exception e){
            e.printStackTrace();
            return Result.build(500,e.getCause().getMessage());
        }
    }

    @Override
    public Result update(${className?cap_first} ${className}) {
        <#list data as d><#if d.isNull==false>
        if(${className}.get${d.beanName?cap_first}()==null || ${className}.get${d.beanName?cap_first}().toString().length()==0){
            return Result.build(500,"${d.commentName}不能为空值");
        }
        </#if></#list>
        try{
            dao.update(${className});
            return Result.ok();
        }catch (Exception e){
            e.printStackTrace();
            return Result.build(500,e.getCause().getMessage());
        }
    }

    @Override
    public Result delete(${className?cap_first} ${className}) {
        try{
            dao.delete(${className});
            return Result.ok();
        }catch (Exception e){
            e.printStackTrace();
            return Result.build(500,e.getCause().getMessage());
        }
    }

    @Override
    public Result deleteAll(String ids) {
        try{
            String[] strings = ids.split(",");
            List<String> list=new ArrayList<>();
            for (int i = 0; i <strings.length ; i++) {
                list.add(strings[i]);
            }
            dao.deleteAll(list);
            return Result.ok();
        }catch (Exception e){
            e.printStackTrace();
            return Result.build(500,e.getCause().getMessage());
        }
    }
}
