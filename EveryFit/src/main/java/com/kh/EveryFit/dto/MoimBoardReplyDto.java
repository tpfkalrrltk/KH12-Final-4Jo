package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MoimBoardReplyDto {
	
String moimBoardReplyContent, memberEmail;
int moimBoardReplyNo, moimBoardNo;


}