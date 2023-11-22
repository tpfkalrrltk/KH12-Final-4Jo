package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;



import com.kh.EveryFit.dto.MoimBoardReplyDto;


@Repository
public class MoimBoardReplyDaoImpl implements MoimBoardReplyDao {

	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	JdbcTemplate tem;


	@Override
	public boolean update(MoimBoardReplyDto moimBoardReplyDto) {

		return sqlSession.update("moimBoardReply.edit",moimBoardReplyDto) >0;
	}

	@Override
	public boolean delete(int moimBoardReplyNo) {

		return sqlSession.delete("moimBoardReply.delete",moimBoardReplyNo)>0;
	}

	@Override
	public void add(MoimBoardReplyDto moimBoardReplyDto) {
		sqlSession.selectList("moimBoardReply.add",moimBoardReplyDto);
		
	}

	@Override
	public List<MoimBoardReplyDto> list(int moimBoardNo) {
		return sqlSession.selectList("moimBoardReply.list",moimBoardNo);
	}

	@Override
	public int sequence() {

		return sqlSession.selectOne("moimBoardReply.sequence");
	}

	@Override
	public MoimBoardReplyDto selectOne(int moimBoardReplyNo) {
		return sqlSession.selectOne("moimBoardReply.selectOne",moimBoardReplyNo);
	}



	
}
