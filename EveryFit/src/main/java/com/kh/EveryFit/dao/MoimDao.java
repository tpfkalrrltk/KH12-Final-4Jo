package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;

public interface MoimDao {
	//모임
	MoimDto selectOne(int moimNo);
	int sequence();
	void insert(MoimDto moimDto);
	
	//모임회원
	List<MoimMemberDto> selectAllMoimMembers(int moimNo);
}
