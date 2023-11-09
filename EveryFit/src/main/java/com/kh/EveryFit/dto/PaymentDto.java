package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentDto {
	private int paymentNo;
	private String paymentTid;//PG사 결제 거래번호KakaoPayApproveResponseVO.tid
	private String paymentName;//PG사 결제 상품명 KakaoPayApproveResponseVO.itemName
	private int paymentPrice;//PG사 결제 가격 KakaoPayApproveResponseVO.amount.gettotal
	private Date paymentTime;//결제시간
	private int paymentProduct;//구매상품번호 productNo
	private String paymentMember;//구매회원ID KakaoPayApproveResponseVO.partnerUserId
}
