package com.kh.EveryFit.component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatUtils {
	
	private static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";
	
	public static Date parseStringToDate(String dateString) throws ParseException {
        return parseStringToDate(dateString, DEFAULT_PATTERN);
    }

    public static Date parseStringToDate(String dateString, String pattern) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        return dateFormat.parse(dateString);
    }

    public static String formatDateToString(Date date) {
        return formatDateToString(date, DEFAULT_PATTERN);
    }

    public static String formatDateToString(Date date, String pattern) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        return dateFormat.format(date);
    }
}
