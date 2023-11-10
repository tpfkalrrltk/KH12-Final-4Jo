package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PeriodPaymentDto {
	private int periodPaymentNo;
	private String periodPaymentSid;
	private Date periodPaymentStart;
	private Date periodPaymentEnd;
	private String periodPaymentStatus;
}
