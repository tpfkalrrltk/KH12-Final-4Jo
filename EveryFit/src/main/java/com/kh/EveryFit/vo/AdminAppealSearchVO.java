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
public class AdminAppealSearchVO {
	private Integer appealNo;
	private	String appealReason, appealContent;
	private	Date appealTime;
	private String memberEmail;
	private List<String> orderList;
	private List<String> appealCategoryList;

	private String appealTimeStart;
	private String appealTimeEnd;
}
