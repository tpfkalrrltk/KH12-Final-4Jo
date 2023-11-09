package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueTeamDto {
	private int leagueTeamNo;
    private int leagueNo;
    private int moimNo;
    private Integer leagueTeamMatchCount;
    private Integer leagueTeamWin;
    private Integer leagueTeamLose;
    private Integer leagueTeamDraw;
    private Integer leagueTeamG;
    private Integer leagueTeamD;
    private Integer leagueTeamGD;
}
