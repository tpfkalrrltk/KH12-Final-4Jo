package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MemberDto;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	SqlSession sqlSession;

	// 관리자 기능
	@Override
	public List<MemberDto> adminMemberList() {
		return sqlSession.selectList("admin.adminMemberList");
	}

	@Override
	public MemberDto adminMemberTarget(String memberEmail) {
		return sqlSession.selectOne("admin.adminMemberTarget",memberEmail);
	}
}
