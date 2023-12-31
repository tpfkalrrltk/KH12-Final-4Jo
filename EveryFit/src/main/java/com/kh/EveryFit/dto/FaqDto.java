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
public class FaqDto {

 private	String memberEmail, faqTitle,faqDetail,faqCategory, memberNick;
 private	int faqNo;
 private	Date faqTime;
}
