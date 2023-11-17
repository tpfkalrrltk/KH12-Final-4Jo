package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MemberLikeDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;
import com.kh.EveryFit.vo.CheckMoimListVO;

import com.kh.EveryFit.vo.MoimTitleForPaymentVO;

import com.kh.EveryFit.vo.MoimMemberStatusVO;


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
	public boolean updateMoimInfo(MoimDto moimDto) {
		return sqlSession.update("moim.editMoim", moimDto) > 0;
	}
	
	@Override
	public List<MoimMemberDto> selectAllMoimMembers(int moimNo) {
		return sqlSession.selectList("moim.moimMemberList", moimNo);
	}
	
	@Override
	public List<MoimDto> moimListByEmail(String memberEmail) {
		return sqlSession.selectList("moim.moimListByEmail", memberEmail);
	}
	
	@Override
	public List<MoimDto> checkMoimList(CheckMoimListVO vo) {
		return sqlSession.selectList("moim.checkMoimList", vo);
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
	public Integer findMoimProfile(Integer moimNo) {
		try {
			//queryForObject는 1개의 결과가 나오지 않으면 예외가 발생
			return sqlSession.selectOne("moim.findMoimProfile", moimNo);
		}
		catch(Exception e) {
			//예외 발생 시 null로 대체하여 반환
			return null;
		}
	}
	
	@Override
	public void insertJungmoProfile(int jungmoNo, int attachNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("jungmoNo", jungmoNo);
	    params.put("attachNo", attachNo);
		sqlSession.insert("moim.insertJungmoProfile", params);
	}
	
	@Override
	public boolean deleteJungmoProfile(int jungmoNo) {
		return sqlSession.delete("moim.deleteJungMoProfile", jungmoNo) > 0;
	}
	 
	@Override
	public Integer findJungmoProfile(Integer jungmoNo) {
		try {
			return sqlSession.selectOne("findJungmoProfile", jungmoNo);
		}
		catch(Exception e) {
			//예외 발생 시 null로 대체하여 반환
			return null;
		}
	}
	
	@Override
	public void addMoimJang(int moimNo, String memberEmail) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("moimNo", moimNo);
	    params.put("memberEmail", memberEmail);
		sqlSession.insert("moim.insertMoimJang", params);
	}
	
	@Override
	public void addMoimMember(int moimNo, String memberEmail) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("moimNo", moimNo);
	    params.put("memberEmail", memberEmail);
		sqlSession.insert("moim.insertMoimMember", params);
	}
	//회원EMAIL이 모임장으로 가입된 MOIM 번호 조회
	@Override
	public List<MoimMemberDto> selectAllMoimNo(String memberEmail) {
		return sqlSession.selectList("moim.findMoimNoPerMemberEmailAndCrown", memberEmail);
	}

	@Override
	public List<MoimTitleForPaymentVO> selectTitleMoimNo(String memberEmail) {
		return sqlSession.selectList("moim.findMoimNoAndMoimTitlePerMemberEmailAndCrown", memberEmail);
	}
	
	@Override
	public void updateMoimMember(MoimMemberStatusVO vo) {	
		sqlSession.update("moim.updateMoimMemberStatus", vo);
	}
	@Override
	public MoimMemberDto selectOneMyInfo(String memberEmail) {
		return sqlSession.selectOne("moim.selectOneMyInfo", memberEmail);
	}
	
	//모임 좋아요
	@Override
	public void memberLikeInsert(MemberLikeDto memberLikeDto) {
		sqlSession.insert("moim.insertMemberLike", memberLikeDto);
	}
	@Override
	public boolean memberLikeCheck(MemberLikeDto memberLikeDto) {
		List<MemberLikeDto> list = sqlSession.selectList("moim.checkMemberLike", memberLikeDto);
		return !list.isEmpty();
	}
	@Override
	public boolean memberLikeDelete(MemberLikeDto memberLikeDto) {
		return sqlSession.delete("moim.deleteMemberLike", memberLikeDto) > 0;
	}
	@Override
	public int memberLikeCount(int moimNo) {
		return sqlSession.selectOne("moim.countMemberLike", moimNo);
	}
	
}
