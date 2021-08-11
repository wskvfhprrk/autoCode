package com.guardlbt.autoCode;

import lombok.Data;

/**
 * Created by Administrator on 2017/7/6.
 */
@Data
public class AutoCode {
    /**
     * 基础类包
     */
    private String basePackage = "com.guardlbt";
    /**
     * 表名
     */
    private String tableName = "tableName";
    /**
     * 模块名称
     */
    private String moduleName = "moduleName";
    /**
     * 实体类包名
     */
    private String entity = "entity";
    /**
     * dao包名
     */
    private String dao = "dao";
    /**
     * service包名
     */
    private String service = "service";
    /**
     * serviceImpl包名
     */
    private String serviceImpl = "service.Impl";
    /**
     * controller包名
     */
    private String controller = "controller";
    /**
     * 网页路径
     */
    private String pagePath = "src/main/resources/templates/";


    public AutoCode() {
    }

    /**
     * 构造方法
     *
     * @param tableName  数据表名
     * @param moduleName 模块名称
     */
    public AutoCode(String tableName, String moduleName) {
        super();
        this.tableName = tableName;
        this.moduleName = moduleName;
    }

}
