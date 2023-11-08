package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueDto {
	private int leagueNo;
	private int eventNo;
	private String leagueManager;
	private String leagueTitle;
	private String leagueDetail;
	private double leagueEntryFee;
	private Date leagueStart;
	private Date leagueEnd;
	private String leagueStatus;
	private int chatRoomNo;
}
