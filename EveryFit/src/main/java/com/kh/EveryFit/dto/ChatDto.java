package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatDto {
	private int chatNo;
	private int chatRoomNo;
	private String memberEmail;
	private String chatMemtionTarget;
	private Date chatTime;
}