package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueListDto {
	private int leagueNo;
	private String leagueManager;
	private String leagueTitle;
	private int leagueEntryFee;
	private String leagueStatus;
	private String eventName;
	private String locationDepth1;
	private String locationDepth2;
}
