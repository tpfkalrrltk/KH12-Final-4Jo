package com.kh.EveryFit.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminMemberSearchVO {
	
	private String memberEmail;
	private Integer locationNo;
	private String memberPw;
	private String memberName;
	private String memberNick;
	private String memberGender;
	private String memberContact;
	private String memberBirth;
	private String memberLevel;
	
	private Integer begin;
	private Integer end;
	private String memberBirthBegin;
	private String memberBirthEnd;
	private List<String> orderList;
	private List<String> memberGenderList;
	private List<String> memberLevelList;
	
	
	
//	private Date memberJoin;
//	private Date memberLogin;
//	private Date memberPwChange;
//	private int memberMoimProduce;
	private int memberMoimCount;
//	private char memberBlock;
}
