package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MoimBoardDto;

public interface MoimBoardDao {

	List<MoimBoardDto> list();
	void add(MoimBoardDto moimBoardDto);
	void edit(MoimBoardDto moimBoardDto, int moimBoardNo);
	void delete(int moimBoardNo);
}
