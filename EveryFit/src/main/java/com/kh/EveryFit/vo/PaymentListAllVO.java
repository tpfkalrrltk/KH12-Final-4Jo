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
public class PaymentListAllVO {
	private int paymentNo;
	private String paymentTid;
	private String paymentName;
	private int paymentPrice;
	private Date paymentTime;
	private int paymentProduct;
	private String paymentMember;
	private int periodPaymentNo;
	private String periodPaymentSid;
	private Date periodPaymentStart;
	private Date periodPaymentEnd;
	private String periodPaymentStatus;
}
