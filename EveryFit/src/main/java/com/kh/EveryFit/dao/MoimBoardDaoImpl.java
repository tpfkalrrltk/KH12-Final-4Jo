package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MoimBoardDto;

@Repository
public class MoimBoardDaoImpl implements MoimBoardDao {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MoimBoardDto> list() {

		return sqlSession.selectList("MoimBoard.list");
	}

	@Override
	public void add(MoimBoardDto moimBoardDto) {
		sqlSession.insert("MoimBoard.add", moimBoardDto);

	}

	@Override
	public void edit(MoimBoardDto moimBoardDto, int moimBoardNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("no", moimBoardNo);
		params.put("moimBoardDto", moimBoardDto);
		sqlSession.update("MoimBoard.edit", params);

	}

	@Override
	public void delete(int moimBoardNo) {
		sqlSession.delete("MoimBoard.delete", moimBoardNo);

	}

	@Override
	public int sequence() {
		 return  sqlSession.selectOne("MoimBoard.sequence");
	}

	@Override
	public MoimBoardDto selelctOne(int moimBoardNo) {
		return sqlSession.selectOne("MoimBoard.selectOne",moimBoardNo);
	}

	@Override
	public List<MoimBoardDto> listByMoimNo(int moimNo) {
		return sqlSession.selectList("MoimBoard.listByMoimNo", moimNo);
	}

//	@Override
//	public List<MoimBoardDto> listByMoimNo() {
//		return sqlSession.selectList("MoimBoard.listByMoimNo");
//	}
	
}
