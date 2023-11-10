package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MemberDto;

public interface MemberDao {

	
	
	List<MemberDto> selectList();

	MemberDto slelctOne(String memberEmail);

	List<MemberDto> searchList(String memberNick);

	void insert(MemberDto memberDto);

	void edit(String memberEmail, MemberDto memberDto);

	void delete(String memberEmail);

	List<MemberDto> selectListByPage(int page, int size);

	MemberDto selectOne(String memberEmail);

	//지역 조회(목록/상세)
	List<LocationDto> selectLocationList();
	LocationDto selectOneByLocationNo(int locationNo);

	//종목 조회(목록/상세)
	List<EventDto> selectEventList();	
	EventDto selectOneByEventNo(int eventNo);
	
	
	
}
