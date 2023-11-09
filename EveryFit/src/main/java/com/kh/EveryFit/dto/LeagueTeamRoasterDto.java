package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueTeamRoasterDto {
	private int leagueTeamRoasterNo;
    private Integer leagueNo;
    private Integer leagueTeamNo;
    private String memberEmail;
}
