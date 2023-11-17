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
public class AdminMoimSearchVO {
	private int moimNo;
	private int locationNo;
	private int eventNo;
	private String moimTitle;
	private String moimContent;
	private Date moimTime;
	private String moimUpgrade;
	private String moimState;
	private Integer moimMemberCount;
	private String moimGenderCheck;
	private Integer chatRoomNo;

	private String moimTimeStart;
	private String moimTimeEnd;

	private List<String> moimUpgradeList;
	private List<String> moimGenderCheckList;
	private List<String> orderList;
}
