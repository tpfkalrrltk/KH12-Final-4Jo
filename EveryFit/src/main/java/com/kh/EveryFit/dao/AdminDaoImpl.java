package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.ReportDto;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimMemberCountVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class AdminDaoImpl implements AdminDao {

	@Autowired
	SqlSession sqlSession;
	@Autowired
	JdbcTemplate tem;

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
	
	
	@Override
	public List<JungmoDto> adminJungmoList() {
		return sqlSession.selectList("admin.adminMoimList");
	}

	@Override
	public List<JungmoDto> adminJungmoSearch(AdminJungmoSearchVO adminJungmoSearchVO) {
		List<JungmoDto> list = sqlSession.selectList("admin.adminJungmoSearch", adminJungmoSearchVO);
		return list;
	}

	@Override
	public AttachDto findImage(int moimNo) {

		List<AttachDto>list=sqlSession.selectList("admin.findMoimProfile", moimNo);
		return list.isEmpty() ? null : list.get(0);
		
	}
	
	@Override
	public List<MoimDto> moimProfileList() {
		return sqlSession.selectList("admin.moimProfileList");
	}

	@Override
	public List<MoimDto> NewMoimList() {
		return sqlSession.selectList("admin.adminMoimList");
	}

	@Override
	public List<MoimDto> PremiumMoimList() {
		return sqlSession.selectList("admin.PremiumMoimList");
	}

	@Override
	public List<MoimDto> GenderCheckMoimList() {
		return sqlSession.selectList("admin.GenderCheckMoimList");
	}

	@Override
	public Integer moimMemberCount(int moimNo) {
		return sqlSession.selectOne("moim.moimMemberCount",moimNo);
	}

	@Override
	public List<ReportDto> reportList() {
		
		return sqlSession.selectList("admin.ReportList");
	}

	@Override
	public List<ReportDto> adminReportSearch(AdminReportSearchVO adminReportSearchVO) {
		List<ReportDto> list = sqlSession.selectList("admin.adminReportSearch", adminReportSearchVO);
		return list;
	}

	@Override
	public List<AdminMoimMemberCountVO> memberCount() {
		List<AdminMoimMemberCountVO> list = sqlSession.selectList("admin.memberCount");
		return list;
	}

	@Override
	public void insertBlock(String memberEmail) {
		String sql = "insert into member_report(member_email) values(?)";
		Object[] data = {memberEmail};
		tem.update(sql, data);
	}

	@Override
	public boolean deleteBlock(String memberEmail) {
		String sql = "delete member_report where member_email=?";
		Object[] data = {memberEmail};
		return tem.update(sql,data) > 0;
		
	}

	@Override
	public void reportApply(ReportDto reportDto) {
		sqlSession.insert("admin.reportApply",reportDto);
		
	}

	@Override
	public ReportDto reportDetail(int reportNo) {
		return sqlSession.selectOne("admin.reportDetail",reportNo);
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("admin.sequence");
	}

}
