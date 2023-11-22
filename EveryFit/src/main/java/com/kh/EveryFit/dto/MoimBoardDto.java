package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MoimBoardDto {
	private int moimBoardNo, moimNo;
	private 	String memberEmail, moimBoardTitle, moimBoardContent,moimBoardCategory, memberNick;
	
	private int moimBoardReplyCount;
	private Date moimBoardTime;

}
