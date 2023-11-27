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
public class AppealDto {
	int AppealNo;
	String AppealReason, AppealContent, AppealCategory;
	Date AppealTime;
	String memberEmail;
}
