package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueTeamRosterDto {
	private int leagueTeamRosterNo;
    private int leagueNo;
    private int leagueTeamNo;
    private String memberEmail;
}
