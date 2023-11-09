package com.kh.EveryFit.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.error.NoTargetException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public List<MemberDto> selectList() {
		return sqlSession.selectList("member.findAll");
	}
	
	
	@Override
	public MemberDto slelctOne(String memberEmail) {
		MemberDto memberDto = sqlSession.selectOne("member.findByMemberEmail",memberEmail);
		if(memberDto == null) throw new NoTargetException();
		return memberDto;
	}
	
	@Override
	public List<MemberDto> searchList(String memberNick) {
		return sqlSession.selectList("member.findByMemberNick", memberNick);
	}
	
	@Override
	public void insert(MemberDto memberDto) {
		sqlSession.insert("member.save",memberDto);
//		log.debug("ss=${}",memberDto);
	}
	
	@Override
	public void edit(String memberEmail, MemberDto memberDto) {
		Map<String,Object> param = Map.of("memberEmail", memberEmail,"memberDto",memberDto);
		int result = sqlSession.update("member.change",param);
//		log.debug("param={}",param);
	}
	
	@Override
	public void delete(String memberEmail) {
		int result = sqlSession.delete("member.deleteByMemberEmail",memberEmail);
		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public List<MemberDto> selectListByPage(int page, int size) {
		int end = page * size;
		int begin = end - (size-1);
		Map params = Map.of("begin",begin, "end",end);
		return sqlSession.selectList("member.selectListByPage",params);
	}
	
//	mypage
	@Override
	public MemberDto selectOne(String memberEmail) {
		
		return sqlSession.selectOne("member.findByMemberEmail",memberEmail);
	}

}