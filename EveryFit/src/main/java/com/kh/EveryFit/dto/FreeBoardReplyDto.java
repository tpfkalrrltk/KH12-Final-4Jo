package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FreeBoardReplyDto {
	
String freeBoardReplyContent, memberEmail;
int freeBoardReplyNo, freeBoardNo;

}