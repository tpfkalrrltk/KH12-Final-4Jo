package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FreeBoardDto {
int freeBoardNo;
String freeBoardTitle, freeBoardContent, freeBoardCategory;
String memberEmail, memberNick;
	
}
