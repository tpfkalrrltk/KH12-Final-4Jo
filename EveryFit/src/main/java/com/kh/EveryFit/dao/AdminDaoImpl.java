package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;

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
		return sqlSession.selectOne("admin.adminMemberTarget", memberEmail);
	}

	@Override
	public List<MemberDto> adminMemberSearch(AdminMemberSearchVO adminMemberSearchVO) {
		List<MemberDto> list = sqlSession.selectList("admin.adminMemberSearch", adminMemberSearchVO);
		return list;
	}

	@Override
	public List<MoimDto> adminMoimList() {
		return sqlSession.selectList("admin.adminMoimList");
	}

	@Override
	public List<MoimDto> adminMoimSearch(AdminMoimSearchVO adminMoimSearchVO) {
		List<MoimDto> list = sqlSession.selectList("admin.adminMoimSearch", adminMoimSearchVO);
		return list;
	}

}
