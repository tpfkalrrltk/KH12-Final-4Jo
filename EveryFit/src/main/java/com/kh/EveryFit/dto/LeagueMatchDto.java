package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueMatchDto {
	private Integer leagueMatchNo;
    private Integer leagueNo;
    private Integer leagueMatchHome; // league_team_no를 참조
    private Integer leagueMatchAway; // league_team_no를 참조
    private String leagueMatchDate;
    private Integer leagueMatchHomeScore; // Integer 타입으로 nullable 처리
    private Integer leagueMatchAwayScore; // Integer 타입으로 nullable 처리
    private String leagueMatchLocation;
}
