package com.hejz.util.entity;

import java.util.List;
/**
 * easyui返回页面值实体类
 * @author Administrator
 *
 */
public class EasyUIDataGridResult {

	private long total;
	private List<?> rows;
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
}
