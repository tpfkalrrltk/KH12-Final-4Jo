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
	public boolean delete(int moimBoardNo) {
		return sqlSession.delete("MoimBoard.delete", moimBoardNo)>0;

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

	@Override
	public boolean edit(MoimBoardDto moimBoardDto) {
		return sqlSession.update("MoimBoard.edit", moimBoardDto)>0;
	}

	@Override
	public List<MoimBoardDto> listByMoimCategory(MoimBoardDto moimBoardDto) {
		return sqlSession.selectList("MoimBoard.listByMoimCategory", moimBoardDto);
	}

	@Override
	public List<MoimBoardDto> listByMoimNoSortedByCategory(int moimNo, String category) {
		return sqlSession.selectList("MoimBoard.listByMoimNoSortedByCategory", Map.of("moimNo", moimNo, "category", category));
	}
	


//	@Override
//	public List<MoimBoardDto> listByMoimNo() {
//		return sqlSession.selectList("MoimBoard.listByMoimNo");
//	}

}
