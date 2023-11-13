package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.FreeBoardDto;

import lombok.extern.slf4j.Slf4j;

@Repository
public class FreeBoardImpl implements FreeBoardDao {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<FreeBoardDto> list() {

		return sqlSession.selectList("freeBoard.list");
	}

	@Override
	public void add(FreeBoardDto freeBoardDto) {
		
		sqlSession.insert("freeBoard.add", freeBoardDto);



	}

	@Override
	public void edit(FreeBoardDto freeBoardDto, int freeBoardNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("freeBoardDto", freeBoardDto);
		params.put("no", freeBoardNo);
		sqlSession.update("freeBoard.edit", params);


	}

	@Override
	public boolean delete(int freeBoardNo) {
		return sqlSession.delete("freeBoard.delete", freeBoardNo) >0;

	}

	@Override
	public int sequence() {

		return sqlSession.selectOne("freeBoard.sequence");
	}

	@Override
	public FreeBoardDto selectOne(int freeBoardNo) {

		return sqlSession.selectOne("freeBoard.selectOne", freeBoardNo);
	}

	@Override
	public void edit(int freeBoardNo) {
		sqlSession.update("freeBoard.edit", freeBoardNo);
		
	}

	@Override
	public boolean edit(FreeBoardDto freeBoardDto) {
		 return sqlSession.update("freeBoard.edit", freeBoardDto)>0;
		
	}

}
