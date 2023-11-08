package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class KakaoPayReadyRequestVO {
	public String partnerOrderId;
	public String partnerUserId;
	public String itemName;
	public int itemPrice;
}
