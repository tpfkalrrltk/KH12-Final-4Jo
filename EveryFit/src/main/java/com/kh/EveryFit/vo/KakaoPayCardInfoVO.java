package com.kh.EveryFit.vo;

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
public class KakaoPayCardInfoVO {

	public String purchaseCorp, purchaseCorpCode, issuerCorp, issuerCorpCode;
	public String kakaopayPurchaseCorp, kakaopayPurchaseCorpCode;
	public String kakaopayIssuerCorp, kakaopayIssuerCorpCode;
	public String bin, cardType, installMonth, approvedId, cardMid, interestFreeInstall, cardItemCode;
}
