package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.FaqDto;

public interface FaqDao {

	List<FaqDto> list();
	int sequence();
	void edit(int faqNo, FaqDto faqDto);
	boolean edit(FaqDto faqDto);
	boolean delete(int faqNo);
	void add(FaqDto faqDto);
	FaqDto selectOne(int faqNo);
}