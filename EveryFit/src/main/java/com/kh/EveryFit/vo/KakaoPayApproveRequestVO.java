package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KakaoPayApproveRequestVO {
	public String partnerOrderId;
	public String partnerUserId;
	public String cid;
	public String tid;
	public String pgToken;
}
