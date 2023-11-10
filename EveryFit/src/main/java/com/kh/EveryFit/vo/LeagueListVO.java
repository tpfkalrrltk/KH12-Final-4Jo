package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueListVO {
	private Integer leagueNo;
	private String leagueManager;
	private String leagueTitle;
	private int leagueEntryFee;
	private String leagueStatus;
	private String eventName;
	private String locationDepth1;
	private String locationDepth2;
}
