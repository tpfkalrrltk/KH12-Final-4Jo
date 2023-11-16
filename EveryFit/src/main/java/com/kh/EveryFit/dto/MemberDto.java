package com.kh.EveryFit.dto;



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
	private int locationNo;
	private String memberPw;
	private String memberName;
	private String memberNick;
	private String memberGender;
	private String memberContact;
	private String memberBirth;
//	private String memberLevel;
//	private Date memberJoin;
//	private Date memberLogin;
//	private Date memberPwChange;
//	private int memberMoimProduce;
//	private int memberMoimCount;
//	private char memberBlock;
	
	
}
