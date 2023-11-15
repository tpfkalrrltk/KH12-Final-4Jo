package com.kh.EveryFit.component;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Component;

@Component
public class TimeFormatter {

	public java.sql.Date convertLocaldate(String stringDate) throws ParseException{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		Date parseDate = (Date) dateFormat.parse(stringDate);
		return new java.sql.Date(parseDate.getTime());
	}
}
