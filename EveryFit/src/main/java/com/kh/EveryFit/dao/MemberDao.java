package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MemberBlockDto;
import com.kh.EveryFit.dto.MemberDto;

public interface MemberDao {

	
	
	List<MemberDto> selectList();

	MemberDto slelctOne(String memberEmail);

	List<MemberDto> searchList(String memberNick);

	void insert(MemberDto memberDto);

	void edit(String memberEmail, MemberDto memberDto);

//	void delete(String memberEmail);
	void delete(String memberDto);

	List<MemberDto> selectListByPage(int page, int size);

	MemberDto selectOne(String memberEmail);

	//지역 조회(목록/시도별 목록/상세)
	List<LocationDto> selectLocationList();
	List<LocationDto> selectLocationListByDepth1(String locationDepth1);
	LocationDto selectOneByLocationNo(int locationNo);

	//종목 조회(목록/상세)
	List<EventDto> selectEventList();	
	EventDto selectOneByEventNo(int eventNo);

	//회원 개인정보변경 
	void updateMemberInfo(MemberDto inputDto);

	
	
	void changeMemberInfo(MemberDto memberDto);
	
//	로그인 시간 갱신 
//	void updateMemberLogin(String memberEmail);
	
	// 회원권 구매 후 member_moim_count (3->10) 수정 
	boolean updateMemberMoimCount(String memberEmail);
	
}
