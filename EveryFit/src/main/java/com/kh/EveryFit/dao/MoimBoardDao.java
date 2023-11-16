package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MoimBoardDto;

public interface MoimBoardDao {

	List<MoimBoardDto> list();
	void add(MoimBoardDto moimBoardDto);
	boolean delete(int moimBoardNo);
	int sequence();
	MoimBoardDto selelctOne(int moimBoardNo);
	
	List<MoimBoardDto> listByMoimNo(int moimNo);
	List<MoimBoardDto> listByMoimCategory(MoimBoardDto moimBoardDto);
	boolean edit(MoimBoardDto moimBoardDto);
	List<MoimBoardDto> listByMoimNoSortedByCategory(int moimNo, String category);
}
