package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MoimBoardDto {
	int moimBoardNo, moimNo;
	String memberEmail, moimBoardTitle, moimBoardContent,moimBoardCategory;
	
	int moimBoardReplyCount;

}
