package com.kh.EveryFit.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MemberBlockDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.error.NoTargetException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberDto> selectList() {
		return sqlSession.selectList("member.findAll");
	}

	@Override
	public MemberDto slelctOne(String memberEmail) {
		MemberDto memberDto = sqlSession.selectOne("member.findByMemberEmail", memberEmail);
		if (memberDto == null)
			throw new NoTargetException();
		return memberDto;
	}

	@Override
	public List<MemberDto> searchList(String memberNick) {
		return sqlSession.selectList("member.findByMemberNick", memberNick);
	}

	@Override
	public void insert(MemberDto memberDto) {
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		sqlSession.insert("member.save", memberDto);
//		log.debug("ss=${}",memberDto);
	}

	@Override
	public void edit(String memberEmail, MemberDto memberDto) {
		Map<String, Object> param = Map.of("memberEmail", memberEmail, "memberDto", memberDto);
		int result = sqlSession.update("member.change", param);
//		log.debug("param={}",param);
	}

	@Override
	public void delete(String memberEmail) {
		int result = sqlSession.delete("member.deleteByMemberEmail", memberEmail);
		if (result == 0)
			throw new NoTargetException();
	}

	@Override
	public List<MemberDto> selectListByPage(int page, int size) {
		int end = page * size;
		int begin = end - (size - 1);
		Map params = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("member.selectListByPage", params);
	}

//	mypage
	@Override
	public MemberDto selectOne(String memberEmail) {

		MemberDto memberDto = sqlSession.selectOne("member.findByMemberEmail", memberEmail);
		return memberDto; 
	}

	// 지역조회
	@Override
	public List<LocationDto> selectLocationList() {
		return sqlSession.selectList("member.locationList");
	}
	// 시/도별 지역 조회
	@Override
	public List<LocationDto> selectLocationListByDepth1(String locationDepth1) {
		return sqlSession.selectList("member.locationListByDepth1", locationDepth1);
	}

	@Override
	public LocationDto selectOneByLocationNo(int locationNo) {
		return sqlSession.selectOne("member.locationFind", locationNo);
	}

	// 종목조회
	@Override
	public List<EventDto> selectEventList() {
		return sqlSession.selectList("member.eventList");
	}

	@Override
	public EventDto selectOneByEventNo(int eventNo) {
		return sqlSession.selectOne("member.eventFind", eventNo);
	}
	
	@Override
	public void updateMemberInfo(MemberDto inputDto) {
		 sqlSession.selectOne("member.eventFind", inputDto);
	}
	
	@Override
	public void changeMemberInfo(MemberDto memberDto) {
		sqlSession.update("member.changeMemberInfo", memberDto);
	}
	
	@Override
	public void deleteProfile(String memberId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDto selectOneByMemberNick(String memberNick) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto target = sqlSession.selectOne("secureMember.find", memberDto.getMemberEmail());
		if(target != null) {//아이디가 존재한다면
			boolean result = encoder.matches(memberDto.getMemberPw(), target.getMemberPw());
			if(result == true) {//비밀번호가 암호화 도구에 의해 맞다고 판정된다면
				return target;
			}
		}
		return null;
	}
}

//	로그인 시간 갱신 
//	@Override
//	public void updateMemberLogin(String memberEmail) {
//		String sql = "update member " + "set member_login=sysdate " + "where member_email = ?";
//		Object[] data = {memberEmail};
//		return sqlSession.selectOne(member.) > 0;
//	}
