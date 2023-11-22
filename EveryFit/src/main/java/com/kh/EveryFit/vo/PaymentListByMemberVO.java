package com.kh.EveryFit.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PaymentListByMemberVO {
	private int moimNo;
	private int periodPaymentNo;
	private String moimTitle;
	private String moimUpgrade;
	private String memberEmail;
	private String moimMemberLevel;
	private String periodPaymentStatus;
}
