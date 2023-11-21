package com.kh.EveryFit.dao;

import com.kh.EveryFit.dto.AttachDto;

public interface AttachDao {
	
	int sequence();
	void insert(AttachDto attachDto);
	boolean delete(int attach_no);
	AttachDto selectOne(int attach_no);
	AttachDto selectOneleague(int leagueNo);

}
