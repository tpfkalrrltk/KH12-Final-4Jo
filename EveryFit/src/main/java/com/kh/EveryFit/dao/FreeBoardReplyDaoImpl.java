package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import com.kh.EveryFit.dto.FreeBoardReplyDto;


@Repository
public class FreeBoardReplyDaoImpl implements FreeBoardReplyDao {

	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	JdbcTemplate tem;


	@Override
	public boolean update(FreeBoardReplyDto freeBoardReplyDto) {

		return sqlSession.update("freeBoardReply.edit",freeBoardReplyDto) >0;
	}

	@Override
	public boolean delete(int freeBoardReplyNo) {

		return sqlSession.delete("freeBoardReply.delete",freeBoardReplyNo)>0;
	}

	@Override
	public void add(FreeBoardReplyDto freeBoardReplyDto) {
		sqlSession.selectList("freeBoardReply.add",freeBoardReplyDto);
		
	}

	@Override
	public List<FreeBoardReplyDto> list(int freeBoardNo) {
		return sqlSession.selectList("freeBoardReply.list",freeBoardNo);
	}

	@Override
	public int sequence() {

		return sqlSession.selectOne("freeBoardReply.sequence");
	}

	@Override
	public FreeBoardReplyDto selectOne(int freeBoardReplyNo) {
		return sqlSession.selectOne("freeBoardReply.selectOne",freeBoardReplyNo);
	}



	
}
