package com.kh.EveryFit.dao;

import com.kh.EveryFit.dto.AttachDto;

public interface AttachDao {
	
	int sequence();
	void insert(AttachDto attachDto);
	boolean delete(int attachNo);
	AttachDto selectOne(int attachNo);
	
}
