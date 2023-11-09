package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.FreeBoardDto;

public interface FreeBoardDao {

	List<FreeBoardDto> list();

	void add(FreeBoardDto freeBoardDto);

	void edit(FreeBoardDto freeBoardDto, int freeBoardNo);

	void delete(int freeBoardNo);

	int sequence();

	FreeBoardDto selectOne(int freeBoardNo);
}
