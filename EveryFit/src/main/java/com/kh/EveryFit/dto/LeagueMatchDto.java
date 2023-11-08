package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueMatchDto {
	private int leagueMatchNo;
    private int leagueNo;
    private int leagueMatchHome; // league_team_no를 참조
    private int leagueMatchAway; // league_team_no를 참조
    private Date leagueMatchDate;
    private Integer leagueMatchHomeScore; // Integer 타입으로 nullable 처리
    private Integer leagueMatchAwayScore; // Integer 타입으로 nullable 처리
    private String leagueMatchLocation;
}
