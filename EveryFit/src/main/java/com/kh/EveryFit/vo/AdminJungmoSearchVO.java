package com.kh.EveryFit.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminJungmoSearchVO {
	private Integer jungmoNo;
	private Integer moimNo;
	private String jungmoTitle;
	private String jungmoAddr;
	private String jungmoAddrLink;
	private Integer jungmoCapacity;
	private Integer jungmoPrice;
	private Timestamp jungmoSchedule;
	private String jungmoStatus;
	private Integer chatRoomNo;
	private String memberNick;

	private String jungmoScheduleStart;
	private String jungmoScheduleEnd;
	
	private List<String> memberNickList;
	private List<String> orderList;
	private List<String> jungmoStateList;
}
