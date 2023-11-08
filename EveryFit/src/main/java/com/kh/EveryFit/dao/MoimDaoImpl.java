package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;

@Repository
public class MoimDaoImpl implements MoimDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MoimDto selectOne(int moimNo) {
		return sqlSession.selectOne("moim.findMoim", moimNo);
	}
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("moim.sequence");
	}

	@Override
	public void insert(MoimDto moimDto) {
		sqlSession.insert("moim.createMoim", moimDto);
	}
	
	@Override
	public List<MoimMemberDto> selectAllMoimMembers(int moimNo) {
		return sqlSession.selectList("moim.moimMemberList", moimNo);
	}
	
	
	
}
