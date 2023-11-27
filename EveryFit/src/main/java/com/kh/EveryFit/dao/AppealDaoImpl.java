package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.AppealDto;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.ReportDto;
import com.kh.EveryFit.vo.AdminAppealSearchVO;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimMemberCountVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class AppealDaoImpl implements AppealDao {

	@Autowired
	SqlSession sqlSession;
	@Autowired
	JdbcTemplate tem;
	@Override
	public List<AppealDto> List() {
		return sqlSession.selectList("appeal.List");
	}
	@Override
	public int sequence() {
		return sqlSession.selectOne("appeal.sequence");
	}
	@Override
	public List<AppealDto> adminAppealSearch(AdminAppealSearchVO adminAppealSearchVO) {
		List<AppealDto> list = sqlSession.selectList("appeal.adminAppealSearch", adminAppealSearchVO);
		return list;
	}
	@Override
	public AppealDto Detail(int appealNo) {
		return sqlSession.selectOne("appeal.Detail",appealNo);
	}
	@Override
	public void appealApply(AppealDto reportDto) {
		sqlSession.insert("appeal.add",reportDto);
		
	}


}
