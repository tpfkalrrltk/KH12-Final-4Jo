package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MemberDto;

public interface MemberDao {

	List<MemberDto> selectList();

	MemberDto slelctOne(String memberEmail);

	List<MemberDto> searchList(String memberNick);

	void insert(MemberDto memberDto);

	void edit(String memberEmail, MemberDto memberDto);

	void delete(String memberEmail);

	List<MemberDto> selectListByPage(int page, int size);
	
}
