package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public void insertMoimProfile(int moimNo, int attachNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("moimNo", moimNo);
	    params.put("attachNo", attachNo);
		sqlSession.insert("moim.insertMoimProfile", params);
	}
	
	@Override
	public boolean deleteMoimProfile(int moimNo) {
		return sqlSession.delete("moim.deleteMoimProfile", moimNo) > 0;
	}
	
	@Override
	public Integer findMoimProfile(int moimNo) {
		try {
			//queryForObject는 1개의 결과가 나오지 않으면 예외가 발생
			return sqlSession.selectOne("moim.findMoimProfile", moimNo);
		}
		catch(Exception e) {
			//예외 발생 시 null로 대체하여 반환
			return null;
		}
	}
	
}
