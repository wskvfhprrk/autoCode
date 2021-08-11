package ${controllerPackage};

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import ${entityPackage}.${className?cap_first};
import ${servicePackage}.${className?cap_first}Service;
import ${basePackage}.util.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
* Created by 代码自动生成.
* 时间:${.now?string("yyyy-MM-dd HH:mm:ss")}
*/
@Api("${moduleName}控制器")
@RestController
@RequestMapping("${className}")
public class ${className?cap_first}Controller {

    @Autowired
    private ${className?cap_first}Service service;

    @RequestMapping(value = "getPage", method = RequestMethod.GET)
	@ApiOperation("分页条件查询${moduleName}")
    private EasyUIDataGridResult getPage(@RequestParam(defaultValue="1") Integer page,  @RequestParam(defaultValue="30")Integer rows, ${className?cap_first} ${className}){
        return service.findPageBy${className?cap_first}(page,rows,${className});
    }

    @RequestMapping(method = RequestMethod.GET)
	@ApiOperation("根据实体类查询全部${moduleName}")
    private List<${className?cap_first}> getAll(${className?cap_first} ${className}){
        return service.findAllBy${className?cap_first}(${className});
    }

    @RequestMapping(method = RequestMethod.POST)
	@ApiOperation("添加${moduleName}")
    private Result add(${className?cap_first} ${className}){
        return service.insert(${className});
    }

    @RequestMapping(method = RequestMethod.PUT)
	@ApiOperation("修改${moduleName}")
    private Result update(${className?cap_first} ${className}){
        return service.update(${className});
    }
    
    @RequestMapping(method = RequestMethod.DELETE)
	@ApiOperation("批量或单个删除${moduleName}")
    private Result deleteAll(String ids){
        return service.deleteAll(ids);
    }
}
