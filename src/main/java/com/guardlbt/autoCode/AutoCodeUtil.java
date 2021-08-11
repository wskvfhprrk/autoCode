package com.guardlbt.autoCode;

import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by Administrator on 2017/7/6.
 */
public class AutoCodeUtil {

    /**
     * 调用freemarker生成静态文件
     *
     * @param modelPathAndName 模版路径+文件名（带后缀.ftl）
     * @param map              带进去的参数值
     * @param outFile          生成文件路径+名称+后缀
     */
    public static String getNewFile(String modelPathAndName, Map map, String outFile) {
        int i = modelPathAndName.lastIndexOf("/");
        String urlPath = modelPathAndName.substring(0, i);
        String fileName = modelPathAndName.substring(i + 1);
        try {
            Configuration configuration = new Configuration(Configuration.getVersion());
            configuration.setDirectoryForTemplateLoading(new File(urlPath));
            configuration.setDefaultEncoding("utf-8");
            Template template = configuration.getTemplate(fileName);
            Writer out = new FileWriter(new File(outFile));
            template.process(map, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将数据库字段转换成bean属性
     *
     * @param columnName
     * @return
     */
    public static String getBeanName(String columnName) {
        char[] columnCharArr = columnName.toLowerCase().toCharArray();
        StringBuffer sb = new StringBuffer();
        int ad = -1;
        for (int i = 0; i < columnCharArr.length; i++) {
            char cur = columnCharArr[i];
            if (cur == '_') {
                ad = i;
            } else {
                if ((ad + 1) == i && ad != -1) {
                    sb.append(Character.toUpperCase(cur));
                } else {
                    sb.append(cur);
                }
                ad = -1;
            }
        }
        return sb.toString();
    }

    /**
     * 首字母大写
     */
    public static String captureName(String name) {
        name = name.substring(0, 1).toUpperCase() + name.substring(1);
        return name;

    }

    /**
     * 数据库类型枚举——用于数据库转类时的类型转换时使用
     *
     * @author LUSHUIFA
     */
    public enum ColumnTypeEnum {
        BOOLEAN("BOOLEAN", "java.lang.Boolean"),
        SMALLINT("SMALLINT", "java.lang.Integer"),
        MEDIUMINT("SMALLINT", "java.lang.Integer"),
        INT("INT", "java.lang.Integer"),
        INTEGER("INTEGER", "java.lang.Integer"),
        BIGINT("BIGINT", "java.lang.Long"),
        FLOAT("FLOAT", "java.lang.Float"),
        DOUBLE("DOUBLE", "java.lang.Double"),
        DECIMAL("DECIMAL", "java.math.BigDecimal"),
        DATE("DATE", "java.sql.Date"),
        DATETIME("DATETIME", "java.sql.Timestamp"),
        TIMESTAMP("TIMESTAMP", "java.sql.Timestamp"),
        TIME("TIME", "java.sql.Time"),
        CHAR("CHAR", "java.lang.String"),
        VARCHAR("VARCHAR", "java.lang.String"),
        TINYINT("TINYINT", "java.lang.String"),
        TEXT("TEXT", "java.lang.String"),
        MEDIUMTEXT("MEDIUMTEXT", "java.lang.String"),
        LONGTEXT("LONGTEXT", "java.lang.String"),
        ENUM("ENUM", "java.lang.String"),
        SET("SET", "java.lang.String");

        private String dbType;
        private String javaType;

        ColumnTypeEnum(String dbType, String javaType) {
            this.dbType = dbType;
            this.javaType = javaType;
        }

        public static String getColumnTypeEnumByDBType(String dbType) {
            for (ColumnTypeEnum columnTypeEnum : ColumnTypeEnum.values()) {
                if (columnTypeEnum.getDbType().equals(dbType)) {
                    return columnTypeEnum.getJavaType();
                }
            }
            return "";
        }
        public String getDbType() {
            return dbType;
        }
        public String getJavaType() {
            return javaType;
        }
    }

    /**
     * 查看当前路径，如果没有新建一个
     *
     * @param path
     */
    public static void getPath(String path) {
        File file = new File(path);
        //如果文件夹不存在则创建
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
    }

    /**
     * 区分项目路径——Mac和windows项目路径不同
     */

    public static StringBuffer getPathByCom(String comPath) {
        String[] split = comPath.split("\\.");
        //win动态路径
//        StringBuffer stringBuffer= new StringBuffer("src/main/java/");
        //mac动态路径
        ///Users/hejianzhe/IdeaProjects/autoCode/src/main/java/com/guardlbt
        StringBuffer stringBuffer = new StringBuffer(System.getProperty("user.dir") + "/src/main/java/");
        for (int i = 0; i < split.length; i++) {
            stringBuffer.append(split[i] + "/");
        }
        return stringBuffer;
    }

}
