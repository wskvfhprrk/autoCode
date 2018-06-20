package com.hejz.autoCode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * 代码实现类
 *
 * @author 何建哲
 * @date 2018/6/20
 */
@Service
public class CreateCodeService {

    @Autowired
    private AutoCodeDao autoCodeDao;

    @Value("${database-name}")
    private String databaseName;

    public void start(AutoCode code) {
        // 所需要参数
        Map<String, Object> map = getJavaObject(code);
        // java类名(首字母大写)
        String className = AutoCodeUtil.captureName(AutoCodeUtil.getBeanName(code.getTableName()));
        // 生成实体类
        creatEntity(code, map, className);
        // 生成dao类
        createDao(code, map, className);
        // 生成daoSQL类
        createDaoSQL(code, map, className);
        // 生成service接口类
        createService(code, map, className);
        // 生成serviceImpl实现类
        createServiceImpl(code, map, className);
        // 生成controller实现类
        createController(code, map, className);
        // 生成list页面
        createListPage(code, map);
        // 生成add页面
        createAddPage(code, map);
    }

    private void createAddPage(AutoCode code, Map<String, Object> map) {
        StringBuffer addPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        addPathAndName.append("autoCode/ftl/html-add.ftl");
        // 输出路径+名称
        StringBuffer addOutFile = new StringBuffer(code.getPagePath());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(addOutFile.toString());
        addOutFile.append(AutoCodeUtil.getBeanName(code.getTableName())
                + "-add.html");
        AutoCodeUtil.getNewFile(addPathAndName.toString(), map, addOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "-add页面生成完毕------------------------------------");
    }

    private void createListPage(AutoCode code, Map<String, Object> map) {
        StringBuffer pagePathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        pagePathAndName.append("autoCode/ftl/html-list.ftl");
        // 输出路径+名称
        StringBuffer listOutFile = new StringBuffer(code.getPagePath());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(listOutFile.toString());
        listOutFile.append(AutoCodeUtil.getBeanName(code.getTableName())
                + "-list.html");
        AutoCodeUtil.getNewFile(pagePathAndName.toString(), map, listOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "-list页面生成完毕------------------------------------");
    }

    private void createController(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer controllerPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        controllerPathAndName.append("autoCode/ftl/controller.ftl");
        // 输出路径+名称
        StringBuffer controllerOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage() + "." + code.getController());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(controllerOutFile.toString());
        controllerOutFile.append(className + "Controller.java");
        AutoCodeUtil.getNewFile(controllerPathAndName.toString(), map, controllerOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "Controller实现类生成完毕----------------------------");
    }

    private void createServiceImpl(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer serviceImplPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        serviceImplPathAndName.append("autoCode/ftl/serviceImpl.ftl");
        // 输出路径+名称
        StringBuffer serviceImplOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage() + "." + code.getServiceImpl());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(serviceImplOutFile.toString());
        serviceImplOutFile.append(className + "ServiceImpl.java");
        AutoCodeUtil.getNewFile(serviceImplPathAndName.toString(), map, serviceImplOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "ServiceImpl实现类生成完毕--------------------------");
    }

    private void createService(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer servicePathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        servicePathAndName.append("autoCode/ftl/service.ftl");
        // 输出路径+名称
        StringBuffer serviceOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage() + "." + code.getService());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(serviceOutFile.toString());
        serviceOutFile.append(className + "Service.java");
        AutoCodeUtil.getNewFile(servicePathAndName.toString(), map, serviceOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "Service接口类生成完毕-----------------------------");
    }

    private void createDaoSQL(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer daoSQLPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        daoSQLPathAndName.append("autoCode/ftl/daoSQL.ftl");
        // 输出路径+名称
        StringBuffer daoSQLOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage() + "." + code.getDao());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(daoSQLOutFile.toString());
        daoSQLOutFile.append(className + "DaoSQL.java");
        AutoCodeUtil.getNewFile(daoSQLPathAndName.toString(), map, daoSQLOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "DaoSQL类生成完毕---------------------------------");
    }

    private void createDao(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer daoPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        daoPathAndName.append("autoCode/ftl/dao.ftl");
        // 输出路径+名称
        StringBuffer daoOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage()
                + "." + code.getDao());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(daoOutFile.toString());
        daoOutFile.append(className + "Dao.java");
        AutoCodeUtil.getNewFile(daoPathAndName.toString(), map, daoOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "Dao类生成完毕------------------------------------");
    }

    private void creatEntity(AutoCode code, Map<String, Object> map, String className) {
        StringBuffer entityPathAndName = AutoCodeUtil.getPathByCom(code.getBasePackage());
        entityPathAndName.append("autoCode/ftl/entity.ftl");
        // 输出路径+名称
        StringBuffer entityOutFile = AutoCodeUtil.getPathByCom(code.getBasePackage() + "." + code.getEntity());
        // 先看是否存在路径没有先创建
        AutoCodeUtil.getPath(entityOutFile.toString());
        entityOutFile.append(className + ".java");
        AutoCodeUtil.getNewFile(entityPathAndName.toString(), map, entityOutFile.toString());
        System.out.println("-------------------------------------"
                + AutoCodeUtil.getBeanName(code.getTableName())
                + "实体类生成完毕------------------------------------");
    }

    private Map<String, Object> getJavaObject(AutoCode code) {
        List<Map<String, Object>> columnNameList = autoCodeDao.selectTable(
                databaseName, code.getTableName());
        if (columnNameList.isEmpty()) {
            System.out.println("查询无此表，请检查表名是否正确");
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        // 原来表名
        map.put("tableName", code.getTableName());
        // 模块名称---解释使用
        map.put("moduleName", code.getModuleName());
        // java类名称(首字母小写)
        map.put("className", AutoCodeUtil.getBeanName(code.getTableName()));
        // 基础包
        map.put("basePackage", code.getBasePackage());
        // 实体类包名
        map.put("entityPackage", code.getBasePackage() + "." + code.getEntity());
        // dao类包名
        map.put("daoPackage", code.getBasePackage() + "." + code.getDao());
        // service类包名
        map.put("servicePackage", code.getBasePackage() + "." + code.getService());
        // serviceImpl类包名
        map.put("serviceImplPackage", code.getBasePackage() + "." + code.getServiceImpl());
        // controller类包名
        map.put("controllerPackage", code.getBasePackage() + "." + code.getController());
        List<Map<String, Object>> l = searchType(columnNameList);
        map.put("data", l);
        return map;
    }

    private List<Map<String, Object>> searchType(List<Map<String, Object>> list) {
        List<Map<String, Object>> l = new ArrayList<>();
        for (Map<String, Object> aList : list) {
            Map<String, Object> typeMap = new HashMap<>();
            // 原来数据库字段名
            typeMap.put("columnName", aList.get("COLUMN_NAME").toString());
            // javaBean字段是否为空
            if (aList.get("IS_NULLABLE") != null
                    && aList.get("IS_NULLABLE").toString().equals("NO")) {
                typeMap.put("isNull", false);
            } else {
                typeMap.put("isNull", true);
            }
            // javaBean字段名
            typeMap.put("beanName", AutoCodeUtil.getBeanName(aList.get("COLUMN_NAME").toString()));
            // 是否为KEY
            if (aList.get("COLUMN_KEY") != null
                    && aList.get("COLUMN_KEY").toString().equals("PRI")) {
                typeMap.put("id", true);
            } else {
                typeMap.put("id", false);
            }
            // 是否有外键
            if (aList.get("COLUMN_KEY") != null
                    && aList.get("COLUMN_KEY").toString().equals("MUL")) {
                typeMap.put("mul", true);
            } else {
                typeMap.put("mul", false);
            }
            // 是否为自增
            if (aList.get("EXTRA") != null
                    && aList.get("EXTRA").toString().length() > 0) {
                typeMap.put("extpa", true);
            } else {
                typeMap.put("extpa", false);
            }
            // 由数据库类型转JAVA类型
            String s = AutoCodeUtil.ColumnTypeEnum.getColumnTypeEnumByDBType(aList.get("DATA_TYPE").toString().toUpperCase());
            int i1 = s.lastIndexOf(".");
            typeMap.put("type", s.substring(i1 + 1));
            // 备注,仅用于实体类,是可无的对象
            if (aList.get("COLUMN_COMMENT") != null) {
                typeMap.put("commentName", aList.get("COLUMN_COMMENT")
                        .toString());
            }
            l.add(typeMap);
        }
        return l;
    }
}
