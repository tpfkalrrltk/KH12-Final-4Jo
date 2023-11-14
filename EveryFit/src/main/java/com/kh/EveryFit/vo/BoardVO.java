package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class BoardVO {
	String type, keyword;
	private int page = 1;
	private int size = 10;
	private int count;
	private int navigatorSize = 10;

	boolean isSearch() {
		return type != null && keyword != null;
	}

	int getBegin() {
		return (page - 1) / navigatorSize * navigatorSize * 1;
	}

	int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end);
	}

	boolean isFirst() {
		return getBegin() == 1;
	}

	public String getPrevQueryString() {
		if (isSearch()) {
			return "page=" + (getBegin() - 1) + "&type=?" + type + "&keyword=" + keyword;
		} else {
			return "page= " + (getBegin() - 1);
		}
	}

	public int getPageCount() {
		return (count - 1) / size + 1;
	}

	public boolean isLast() {
		return getEnd() >= getPageCount();
	}

	public String getNextQueryString() {
		if (isSearch()) {
			return "page=" + (getEnd() + 1) + "&size=" + size + "&type=?" + type + "&keyword=" + keyword;
		} else {
			return "page= " + (getEnd() + 1) + "&size=" + size;
		}
	}

	public String getQueryString(int page) {
		if (isSearch()) {
			return "page=" + page + "&size=" + size + "&type=" + type + "&keyword=" + keyword;
		} else {
			return "page=" + page + "&size=" + size;
		}
	}

	public int getStartRow() {
		return getFinishRow() - (size - 1);
	}

	public int getFinishRow() {
		return page * size;
	}
}
