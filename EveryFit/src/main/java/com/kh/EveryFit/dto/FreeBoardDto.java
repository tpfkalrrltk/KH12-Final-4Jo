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
public class FreeBoardDto {
	private int freeBoardNo;
	private String freeBoardTitle, freeBoardContent, freeBoardCategory;
	private String memberEmail, memberNick;
	private int freeBoardReplyCount;
	private Date freeBoardTime;
	private 	int attachNo;
}
