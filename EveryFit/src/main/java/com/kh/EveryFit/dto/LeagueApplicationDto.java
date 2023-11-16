package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueApplicationDto {
	private Integer leagueApplicationNo;
    private Integer leagueNo;
    private String leagueApplicationStart;
    private String leagueApplicationEnd;
}
