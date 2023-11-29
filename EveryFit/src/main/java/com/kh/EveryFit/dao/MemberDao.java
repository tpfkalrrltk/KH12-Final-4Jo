package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimMemberDto;

public interface MemberDao {

	
	
	List<MemberDto> selectList();

	

	List<MemberDto> searchList(String memberNick);

	void insert(MemberDto memberDto);

	void edit(String memberEmail,String memberPw);

//	void delete(String memberEmail);
	void delete(String memberDto);

	List<MemberDto> selectListByPage(int page, int size);

	MemberDto selectOne(String memberEmail);

	//지역 조회(목록/시도별 목록/상세)
	List<LocationDto> selectLocationList();
	List<LocationDto> selectLocationListByDepth1(String locationDepth1);
	LocationDto selectOneByLocationNo(int locationNo);

	//종목 조회(목록/상세)
	List<EventDto> selectEventList();	
	EventDto selectOneByEventNo(int eventNo);

	//회원 개인정보변경 
	void updateMemberInfo(MemberDto inputDto);
//	void changeMemberInfo(MemberDto inputDto);
	void changeMemberInfo(MemberDto memberDto);
	
	//비밀정보 변경
	void changePw(MemberDto memberDto);
	void changeMemberPw(MemberDto memberDto);
//    void changePassword(String memberEmail, String newPassword);
//	void changeMemberPassword(MemberDto memberDto);
//	로그인 안된 상태에서 비밀번호 찾기
    void updatePassword(MemberDto memberDto);

	
	MemberDto selectOneByMemberNick(String memberNick);
	
	
	
	MemberDto login(MemberDto dto);
	
//	로그인 시간 갱신 
//	void updateMemberLogin(String memberEmail);
	

	// 회원권 구매 후 member_moim_count (3->10) 수정 
	boolean updateMemberMoimCount(String memberEmail);
	
	//내가 가입한 모임 갯수 
	boolean updateMemberMoimProduce(int memberEmail);
	
	//프로필 관련 기능
		void insertProfile(String memberEmail, int attachNo);
		boolean deleteProfile(String memberEmail);
		Integer findProfile(String memberEmail);


		//로그인x비밀번호찾기 
		void findePw(MemberDto memberDto);
		//가입한 모임에서 나의 level
		MoimMemberDto selectMoimMemberLevelByEmail(MoimMemberDto moimMemberDto);



//		void changePw(String resetPwMemberEmail, String encryptedNewPassword);



	



		
}
