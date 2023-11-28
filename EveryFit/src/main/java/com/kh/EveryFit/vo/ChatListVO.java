package com.kh.EveryFit.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatListVO {
	
	private int chatRoomNo;
	private Date moimMemberJoin;
		
}
	