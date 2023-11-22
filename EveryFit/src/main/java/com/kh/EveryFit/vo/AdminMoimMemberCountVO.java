package com.kh.EveryFit.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminMoimMemberCountVO {
	private Integer moimNo;
	private Integer locationNo;
	private Integer eventNo;
	private String moimTitle;
	private String moimContent;
	private Date moimTime;
	private String moimUpgrade;
	private String moimState;
	private Integer moimMemberCount;
	private String moimGenderCheck;
	private Integer chatRoomNo;
	
	private Integer memberCount;
}
