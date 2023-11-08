package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {

	private String memberEmail;
	private int memberNo;
	private String memberPw;
	private String memberName;
	private String memberNick;
	private char memberGender;
	private char memberContact;
	private char memberBirth;
	private String memberLevel;
	private Date memberJoin;
	private Date memberLogin;
	private Date memberPwChange;
	private int memberMoimProduce;
	private int memberMoimCount;
	private char memberBlock;
	
	
}
