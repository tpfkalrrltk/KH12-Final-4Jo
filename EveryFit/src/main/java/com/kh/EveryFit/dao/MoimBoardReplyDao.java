package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MoimBoardReplyDto;

public interface MoimBoardReplyDao {

	List<MoimBoardReplyDto> list(int moimBoardNo);

	boolean update(MoimBoardReplyDto moimBoardReplyDto);

	boolean delete(int moimBoardReplyNo);

	void add(MoimBoardReplyDto moimBoardReplyDto);

	int sequence();

	MoimBoardReplyDto selectOne(int moimBoardReplyNo);
}
