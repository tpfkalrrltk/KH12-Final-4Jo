package com.kh.EveryFit.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminReportSearchVO {
	private Integer reportNo;
	private	String reportReason, reportContent;
	private	Date reportTime;
	private String memberEmail;
	private List<String> orderList;
	private List<String> reportCategoryList;

	private String reportTimeStart;
	private String reportTimeEnd;
}
