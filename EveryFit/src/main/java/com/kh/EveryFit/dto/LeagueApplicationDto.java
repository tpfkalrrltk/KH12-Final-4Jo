package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueApplicationDto {
	private int leagueApplicationNo;
    private int leagueNo;
    private Date leagueApplicationStart;
    private Date leagueApplicationEnd;
}
