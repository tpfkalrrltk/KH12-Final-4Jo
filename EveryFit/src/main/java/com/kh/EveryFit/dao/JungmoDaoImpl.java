package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.vo.JungmoMemberListVO;
import com.kh.EveryFit.vo.JungmoWithMembersVO;

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
	
//	@Override
//	public List<JungmoListByMoimNoVO> selectList(int moimNo) {
//		return sqlSession.selectList("moim.jungmoList", moimNo);
//	}
	
	@Override
	public List<JungmoMemberListVO> selectListByJungmoNo(int jungmoNo) {
		return sqlSession.selectList("moim.jungmoMemberList", jungmoNo);
	}
	
	@Override
	public void memberJoin(String memberEmail, int jungmoNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("jungmoNo", jungmoNo);
		sqlSession.insert("moim.insertJungmoMember", params);
	}
	
	@Override
	public JungmoDto selectOneByJungmoNo(int jungmoNo) {
		return sqlSession.selectOne("moim.findJungmo", jungmoNo);	
	}
	
	@Override
	public int selectOneJungmoMemberCount(int jungmoNo) {
		return sqlSession.selectOne("moim.jungmoMemberCount", jungmoNo);
	}
	
	@Override
	public boolean deleteJungmoMember(String memberEmail, int jungmoNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("jungmoNo", jungmoNo);
		return sqlSession.delete("moim.deleteJungmoMember", params) > 0;
	}
	@Override
	public List<JungmoWithMembersVO> selectTotalList(int moimNo) {
		return sqlSession.selectList("moim.jungmoListAll", moimNo);
	}
	
	@Override
	public boolean cancel(int jungmoNo) {
		return sqlSession.update("moim.deleteJungmo", jungmoNo) > 0;
	}
	
	@Override
	public String selectMemberEmail(String memberEmail, int jungmoNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("jungmoNo", jungmoNo);
		return sqlSession.selectOne("moim.memberCheck", params);
	}
}
