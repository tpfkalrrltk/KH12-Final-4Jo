package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.FreeBoardReplyDto;

public interface FreeBoardReplyDao {

	List<FreeBoardReplyDto> list();

	boolean update(int freeBoardReplyNo,FreeBoardReplyDto freeBoardReplyDto);

	boolean delete(int freeBoardReplyNo);

	void add(FreeBoardReplyDto freeBoardReplyDto);

	int sequence();
}
