package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.FreeBoardReplyDto;

public interface FreeBoardReplyDao {

	List<FreeBoardReplyDto> list(int freeBoardNo);

	boolean update(FreeBoardReplyDto freeBoardReplyDto);

	boolean delete(int freeBoardReplyNo);

	void add(FreeBoardReplyDto freeBoardReplyDto);

	int sequence();

	FreeBoardReplyDto selectOne(int freeBoardReplyNo);
}
