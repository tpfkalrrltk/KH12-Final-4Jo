package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KakaoPayApproveRequestInPeriodVO {
	public String partnerOrderId;
	public String partnerUserId;
	public String cid;
	public String sid;
	public int quantity;
	public int totalAmount;
	public int taxFreeAmount;
}
