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
    private int leagueTeamMatchCount;
    private int leagueTeamWin;
    private int leagueTeamLose;
    private int leagueTeamDraw;
    private int leagueTeamG;
    private int leagueTeamD;
    private int leagueTeamGD;
}
