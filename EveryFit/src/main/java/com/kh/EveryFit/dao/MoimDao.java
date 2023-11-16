package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;
import com.kh.EveryFit.vo.CheckMoimListVO;

public interface MoimDao {
	//모임
	MoimDto selectOne(int moimNo);
	int sequence();
	void insert(MoimDto moimDto);
	
	//모임회원
	List<MoimMemberDto> selectAllMoimMembers(int moimNo);
	
	//회원이 가입한 모임 확인용
	List<MoimDto> moimListByEmail(String memberEmail);
	//리그 참여 가능한 모임 확인용 모임 리스트
	List<MoimDto> checkMoimList(CheckMoimListVO vo);
	
	//프로필 관련 기능
	void insertMoimProfile(int moimNo, int attachNo);
	boolean deleteMoimProfile(int moimNo);
	Integer findMoimProfile(Integer moimNo);
	void insertJungmoProfile(int jungmoNo, int attachNo);
	boolean deleteJungmoProfile(int jungmoNo);
	Integer findJungmoProfile(Integer jungmoNo);
	
	//모임장등록
	void addMoimJang(int moimNo, String memberEmail);
	//모임회원등록
	void addMoimMember(int moimNo, String memberEmail);
	
}
