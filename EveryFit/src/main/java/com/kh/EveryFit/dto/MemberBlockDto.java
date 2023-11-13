package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberBlockDto {

	private String memberEmail;
	private Date blockTime;
}
