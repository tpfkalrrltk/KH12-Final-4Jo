package com.kh.EveryFit.vo;

import java.sql.Date;
import java.util.List;

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
public class KakaoPayCancelResponseVO {
    private String aid; // 요청 고유 번호
    private String tid; // 결제 고유 번호, 10자
    private String cid; // 가맹점 코드, 20자
    private String status; // 결제 상태
    private String partnerOrderId; // 가맹점 주문번호, 최대 100자
    private String partnerUserId; // 가맹점 회원 id, 최대 100자
    private String paymentMethodType; // 결제 수단, CARD 또는 MONEY 중 하나
    private KakaoPayAmountVO amount; // 결제 금액 정보
    private KakaoPayAmountVO approvedCancelAmount; // 이번 요청으로 취소된 금액
    private KakaoPayAmountVO canceledAmount; // 누계 취소 금액
    private KakaoPayAmountVO cancelAvailableAmount; // 남은 취소 가능 금액
    private String itemName; // 상품 이름, 최대 100자
    private String itemCode; // 상품 코드, 최대 100자
    private int quantity; // 상품 수량
    private Date createdAt; // 결제 준비 요청 시각
    private Date approvedAt; // 결제 승인 시각
    private Date canceledAt; // 결제 취소 시각
    private String payload; // 취소 요청 시 전달한 값
}
