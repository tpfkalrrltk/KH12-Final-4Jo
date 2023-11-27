package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueScoreCalculateVO {
	private int totalG;
	private int totalD;
	private int totalGD;
}
