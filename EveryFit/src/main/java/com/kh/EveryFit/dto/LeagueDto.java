package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueDto {
	private Integer leagueNo;
	private Integer eventNo;
	private String leagueManager;
	private String leagueTitle;
	private String leagueDetail;
	private Integer leagueEntryFee;
	private Date leagueStart;
	private Date leagueEnd;
	private String leagueStatus;
	private Integer chatRoomNo;
	private Integer locationNo;
	private Integer leagueTeamCount;
	private Integer leagueRoasterCount;
}
