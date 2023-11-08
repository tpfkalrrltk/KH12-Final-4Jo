package com.kh.EveryFit.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
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
public class KakaoPayApproveResponseVO {

	private String aid;//요청
	private String tid;//거래
	private String cid;//가맹점
	private String sid;//정기결제
	private String partnerOrderId, partnerUserId;
	private String paymentMethodType; //결제수단(card / money)
	private KakaoPayAmountVO amount;
	private KakaoPayCardInfoVO cardInfo;
	private String itemName, itemCode;//상품명,코드
	private int quantity; //수량
	private Date createdAt, approvedAt;//준비/승인시각
	private String payload; //메모
	
	
}
