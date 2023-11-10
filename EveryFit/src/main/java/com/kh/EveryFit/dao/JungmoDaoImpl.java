package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.vo.JungmoListByMoimNoVO;

@Repository
public class JungmoDaoImpl implements JungmoDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("moim.jungmoSequence");
	}
	
	@Override
	public void insert(JungmoDto jungmoDto) {
		sqlSession.insert("moim.createJungmo", jungmoDto);
	}
	
	@Override
	public void edit(JungmoDto jungmoDto) {
		sqlSession.update("moim.editJungmo", jungmoDto);
	}
	
	@Override
	public List<JungmoListByMoimNoVO> selectList(int moimNo) {
		return sqlSession.selectList("moim.jungmoList", moimNo);
	}
}
