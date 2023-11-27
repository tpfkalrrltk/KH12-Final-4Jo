package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class JungmoStatusVO {
	private boolean isOver;
	private boolean isCancel;
	private int jungmoNo;
}
