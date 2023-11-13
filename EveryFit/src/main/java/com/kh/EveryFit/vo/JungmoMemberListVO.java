package com.kh.EveryFit.vo;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
//@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JungmoMemberListVO {
	private String memberEmail;
	private int jungmoNo;
	private Integer attachNo;
}
