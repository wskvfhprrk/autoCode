package com.guardlbt.util.entity;

import java.util.List;

public class EchartsResult {
	private List<String> names;
	private List<String> date;
	private List<Echart> series;


	public List<String> getNames() {
		return names;
	}

	public void setNames(List<String> names) {
		this.names = names;
	}

	public List<String> getDate() {
		return date;
	}

	public void setDate(List<String> date) {
		this.date = date;
	}

	public List<Echart> getSeries() {
		return series;
	}

	public void setSeries(List<Echart> series) {
		this.series = series;
	}
}
