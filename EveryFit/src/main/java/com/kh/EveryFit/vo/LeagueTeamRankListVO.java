package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueTeamRankListVO {
	private int leagueTeamNo;
    private int leagueNo;
    private int moimNo;
    private String leagueTeamName;
    private String leagueTeamStatus;
    private Integer leagueTeamMatchCount;
    private Integer leagueTeamWin;
    private Integer leagueTeamLose;
    private Integer leagueTeamDraw;
    private Integer leagueTeamG;
    private Integer leagueTeamD;
    private Integer leagueTeamGD;
    private Integer leagueTeamPoint;
    private int leagueTeamRank;
}
