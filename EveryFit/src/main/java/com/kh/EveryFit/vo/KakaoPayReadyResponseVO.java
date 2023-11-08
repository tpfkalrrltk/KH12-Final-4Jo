package com.kh.EveryFit.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KakaoPayReadyResponseVO {
	private String tid;//결제 고유번호
	public String nextRedirectAppUrl;
	public String nextRedirectMobileUrl;
	public String nextRedirectPcUrl;
	public String androidAppScheme;
	public String iosAppScheme;
	public Date createdAt;//결제 준비를 요청한 시각
}
