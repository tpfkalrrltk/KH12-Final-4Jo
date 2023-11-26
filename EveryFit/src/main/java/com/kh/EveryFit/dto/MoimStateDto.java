package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MoimStateDto {
	private int moimNo;
	private boolean isOver;
	private boolean isZero;
	private String moimState;
}
