<table id="${className}-list" class="easyui-datagrid"
       style="height:100%;width: auto;">
    <thead>
    <tr>
        <th data-options="field:'ck',checkbox:true"></th>
    <#list data as d>
        <th data-options="field:'${d.beanName}',align:'center'${d.id?string(",hidden:true","")}">${d.commentName}</th>
    </#list>
    </tr>
    </thead>
</table>
<!-- 页签 -->
<div id="${className}-tb">
    <form>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-application_form_add',plain:true"
       onclick="${className}_append()">添加</a>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-application_form_edit',plain:true"
       onclick="${className}_edit()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-application_form_delete',plain:true"
       onclick="${className}_remove()">删除</a>
    <#list data as d><#if d.id=false>
        <#if d.mul=true>
        <#--请根据数据库外键关联进行更改-->
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-combobox" name="${d.beanName}" id="${className}-list-${d.beanName}" style="width:110px;"
                   data-options="prompt:'请选择${d.commentName}',
                        valueField: '${d.beanName}',
                        textField: '开发时请修改此处',
                        url: '开发时在此修改关联类名/getAll'
                       "/>
        </#if>
        <#if d.type=='Timestamp'>
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-datetimebox" name="${d.beanName}" id="${className}-list-${d.beanName}"
                   style="width:110px;"
                   data-options="prompt:'请填写${d.commentName}'"/>
        <#elseif d.type=='Date'>
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-datebox" name="${d.beanName}" id="${className}-list-${d.beanName}" style="width:110px;"
                   data-options="prompt:'请填写${d.commentName}'"/>
        <#elseif d.type=='Time'>
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-timespinner" name="${d.beanName}" id="${className}-list-${d.beanName}"
                   style="width:110px;"
                   data-options="prompt:'请填写${d.commentName}'"/>
        <#elseif d.type=='Integer' || d.type=='Long' || d.type=='Float' || d.type=='DOUBLE' >
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-numberbox" name="${d.beanName}" id="${className}-list-${d.beanName}"
                   style="width:110px;"
                   data-options="prompt:'请填写${d.commentName}',min:0,precision:<#if d.type=='Integer' || d.type=='Long'>0</#if><#if  d.type=='Float' || d.type=='DOUBLE'>2</#if>"/>
        <#elseif d.type=='String' && d.mul=false>
            <span style="padding-left: 10px;">${d.commentName}:</span>
            <input class="easyui-textbox" name="${d.beanName}" id="${className}-list-${d.beanName}" style="width:110px;"
                   data-options="prompt:'请填写${d.commentName}'"/>
        </#if>
    </#if>
    </#list>
        <a href="javascript:void(0)" class="easyui-linkbutton"
           data-options="iconCls:'icon-application_form_add'"
           onclick="${className}_load()">查询</a>
    </form>
    <input type="hidden" id="${className}-contextPath" th:value="${r'${contextPath}'}" />
</div>
<script>
    /*************** 页面初始化 ************/
    sessionStorage.${className}_contextPath =$("#${className}-contextPath").val();//为了防止在添加时关闭list页面,先本地缓存contextPath
    var ${className}_contextPath =$("#${className}-contextPath").val();
    $(function () {
        ${className}_load();
    });
    /********* 页面及条件查询方法***********/
    function ${className}_load() {
        var params = $("#${className}-tb form").serialize();//序列化条件查询参数——注意与提交form区分
        $("#${className}-list").datagrid({
            pagination: true,
            pageSize: 30,
            pageNumber:1,
            rownumbers: true,
            fit: true,
            toolbar: "#${className}-tb",
            method: "get",
            async: false,
            url: ${className}_contextPath+"/${className}/getPage?" + params,
            onClickRow: function (rowIndex, rowData) {//加上这句话，再也不用担心你变黄了！
                $(this).datagrid('unselectRow', rowIndex);
            }
        });
    }
    /*************** 添加 ***************/
    function ${className}_append() {
        $("#${className}-form").form('clear');
        var tabs = $("#tabs");
        var tab = tabs.tabs("getTab", "添加");
        if (tab) {
            tabs.tabs("close", "添加");
            tabs.tabs('add', {
                title: "添加",
                //href: $("#contextPath").val()+"/${className}-add",
                href: "${className}-add",
                closable: true,
                bodyCls: "content"
            });
        } else {
            tabs.tabs('add', {
                title: "添加",
                //href: $("#contextPath").val()+"/${className}-add",
                href: "${className}-add",
                closable: true,
                bodyCls: "content"
            });
        }
    }
    /*************修改*****************/
    function ${className}_edit() {
        //将对象存在浏览器中
        var ${className} =
        $("#${className}-list").datagrid("getSelected");
        var str = JSON.stringify(${className}); //转为json格式对象
        if (${className}) {
            //注:sessionStorage._______后面名字不要重复
            sessionStorage.${className} = str;//存入浏览器sessionStorage
            var tabs = $("#tabs");
            var tab = tabs.tabs("getTab", "修改");
            if (tab) {
                tabs.tabs("close", "修改");
                tabs.tabs('add', {
                    title: "修改",
                    //href: $("#contextPath").val()+"/${className}-add",
                	href: "${className}-add",
                    closable: true,
                    bodyCls: "content"
                });
            } else {
                tabs.tabs('add', {
                    title: "修改",
                    //href: $("#contextPath").val()+"/${className}-add",
                	href: "${className}-add",
                    closable: true,
                    bodyCls: "content"
                });
            }
        } else {
            alert("请选择要修改的行");
        }
    }
    /*****************删除**********************/
    function ${className}_remove() {
        //获取选中的所有行数据
        var rows = $("#${className}-list").datagrid("getSelections");
        if (rows.length != 0) {
            var ids = "";
            rows.forEach(function (val, index) {
                if (index == 0) {
                    ids = rows[index]["<#list data as d><#if d.id=true>${d.beanName}</#if></#list>"];//此处如果是多主键此处和SQL都要改为一个对应的
                } else {
                    ids = ids + "," + rows[index]["<#list data as d><#if d.id=true>${d.beanName}</#if></#list>"];//此处如果是多主键此处和SQL都要改为一个对应的
                }
            })
            $.messager.confirm("确认", "您确认想要删除该信息吗？", function (r) {
                if (r) {
                    $.ajax({
                        type: "delete",
                        //url: $("#contextPath").val()+"/${className}/?ids=" + ids,
                        url: "${className}/?ids=" + ids,
                        async: false,
                        success: function (data) {
                            if (data.status == 200) { //如果状态为200（成功），刷新页面
                                $("#${className}-list").datagrid("reload");
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                }
            });
        } else {
            alert("请选择要删除的行！");
        }
    }
</script>