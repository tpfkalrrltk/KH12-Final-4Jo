package com.kh.EveryFit.component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

@Component
public class TimeFormatter {

	 public void stringToDate() {
	        // 패턴을 사용하여 DateTimeFormatter 생성
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	        // LocalDateTime를 문자열로 포맷팅
	        LocalDateTime now = LocalDateTime.now();
	        String formattedDateTime = now.format(formatter);
	        System.out.println("Formatted DateTime: " + formattedDateTime);

	        // 문자열을 LocalDateTime으로 파싱
	        String dateTimeString = "2023-11-01 12:00:00";
	        LocalDateTime parsedDateTime = LocalDateTime.parse(dateTimeString, formatter);
	        System.out.println("Parsed DateTime: " + parsedDateTime);
	    }
}
