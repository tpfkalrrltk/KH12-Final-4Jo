package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueMatchDto {
	private Integer leagueMatchNo;
    private Integer leagueNo;
    private Integer leagueMatchHome;
    private Integer leagueMatchAway;
    private String leagueMatchDate;
    private String leagueMatchLocation;
    private Integer leagueMatchHomeScore;
    private Integer leagueMatchAwayScore;
}
