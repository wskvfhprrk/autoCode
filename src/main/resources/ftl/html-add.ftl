<div data-options="closed:'true'"
     style="width:810px;height:300px;padding:20px">
    <form class="easyui-form" id="${className}-form" method="post">
        <!-- 一般情况主键id要隐藏 -->
    <#list data as d><#if d.id=true>
        <input type="hidden" id="${className}-${d.beanName}" name="${d.beanName}"/><!--${d.commentName}-->
    </#if></#list>
    <#list data as d><#if d.id=false>
        <#if d.mul=true>
            <#--请根据数据库外键关联进行更改-->
            <div style="margin-bottom:20px">
                <input class="easyui-combobox" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请选择${d.commentName}'<#if d.isNull==false>,required:true</#if>,
                        valueField: '${d.beanName}',
                        textField: '开发时请修改此处',
                        url: '开发时在此修改关联类名(首字母小写)',
                        type:'post'
                       "/>
            </div>
        <#else>
        <#if d.type=='Timestamp'>
            <div style="margin-bottom:20px">
                <input class="easyui-datetimebox" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请填写${d.commentName}'<#if d.isNull==false>,required:true</#if>"/>
            </div>
        <#elseif d.type=='Date'>
            <div style="margin-bottom:20px">
                <input class="easyui-datebox" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请填写${d.commentName}'<#if d.isNull==false>,required:true</#if>"/>
            </div>
        <#elseif d.type=='Time'>
            <div style="margin-bottom:20px">
                <input class="easyui-timespinner" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请填写${d.commentName}'<#if d.isNull==false>,required:true</#if>"/>
            </div>
        <#elseif d.type=='Integer' || d.type=='Long' || d.type=='Float' || d.type=='DOUBLE' >
            <div style="margin-bottom:20px">
                <input class="easyui-numberbox" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请填写${d.commentName}'<#if d.isNull==false>,required:true</#if>,min:0,precision:<#if d.type=='Integer' || d.type=='Long'>0</#if><#if  d.type=='Float' || d.type=='DOUBLE'>2</#if>"/>
            </div>
        <#elseif d.type=='String'>
            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="${d.beanName}" id="${className}-${d.beanName}" style="width:50%;"
                       data-options="label:'${d.commentName}:',prompt:'请填写${d.commentName}'<#if d.isNull==false>,required:true</#if>"/>
            </div>
        </#if>
        </#if>
    </#if></#list>
    </form>
    <div style="margin-left:170px;padding:5px 0">
        <a href="javascript:void(0)" class="easyui-linkbutton"
           onclick="${className}_submitForm()" style="width:130px;height: 30px;">提交</a>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var title = $('.tabs-selected').text();
        if (title == "修改") {
            var s = sessionStorage.${className};//从sessionStorage得到数据  （json格式对象）
            s = JSON.parse(s);//将json格式转为js对象
        <#list data as d>
            $("#${className}-${d.beanName}").val(s.${d.beanName});
        </#list>
        }
    });
    /***********提交前进行验证**************************/
    function ${className}_submitForm() {
        $("#${className}-form").form("submit", {
            onSubmit: function () {
                return $(this).form("enableValidation").form("validate");
            },
            success: function () {
                ${className}Sub();//提交数据
            }
        });
    }
    /****************添加修改提交***********************/
    function ${className}Sub() {
        var params = $("#${className}-form").serialize();
        var type = "post";
        if ($("#${className}-<#list data as d><#if d.id=true>${d.beanName}</#if></#list>").val()) {
            type = "put";
        }
        $.ajax({
            type: type,
            // url: $("#contextPath").val() + "/${className}",
            url: "${className}",
            data: params,
            async: false,
            success: function (data) {
                if (data.status == 200) {
                    $("#${className}-list").datagrid("reload");
                    var title = $('.tabs-selected').text();
                    //关闭tab
                    var tabs = $("#tabs");
                    tabs.tabs("close", title);
                }else {
                    alert(data.msg);
                }
            },
            error: function () {
                alert("错误");
            }
        });
    }
</script>
