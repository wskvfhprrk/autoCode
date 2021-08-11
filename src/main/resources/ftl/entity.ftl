package ${entityPackage};

import org.springframework.format.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


<#list data as d>
    <#if d.type=='Timestamp' ||d.type=='Date'>
import java.util.Date;
	<#break>
    </#if>
</#list>
/**
* Created by 代码自动生成.
* 时间:${.now?string("yyyy-MM-dd HH:mm:ss")}
*/
@ApiModel("${moduleName}实体类")
@Data
public class ${className?cap_first} {
<#list data as d>
    <#if d.type=="Timestamp">
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")</#if> <#if d.type=="date">
    @DateTimeFormat(pattern = "yyyy-MM-dd")</#if>
    @ApiModelProperty("${d.commentName}") 
    private <#if d.type=='Timestamp'>Date<#else>${d.type}</#if> ${d.beanName};
</#list>
}
