package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder	
public class MoimMemberStatusVO {
	
	private String memberEmail;
	private String memberBlock;
	private String memberApproval;
	private String memberUnBlock;
	private String memberTransfer;
	private String memberCancel;
	private int moimNo;
	
}
