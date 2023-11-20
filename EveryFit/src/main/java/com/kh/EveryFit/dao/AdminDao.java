package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;

public interface AdminDao {
	//관리자 기능
	
	//회원
	List<MemberDto>adminMemberList();

	MemberDto adminMemberTarget(String memberEmail);

	List<MemberDto> adminMemberSearch(AdminMemberSearchVO adminMemberSearchVO);

	
	//모임
	List<MoimDto>adminMoimList();
	
	List<MoimDto> adminMoimSearch(AdminMoimSearchVO adminMoimSearchVO);

	
	//정모
	List<JungmoDto> adminJungmoList();
	
	List<JungmoDto>  adminJungmoSearch(AdminJungmoSearchVO adminJungmoSearchVO);

	
	//사진불러오기
	AttachDto findImage(int moimNo);

	List<MoimDto> moimProfileList();
	
	
	//메인홈페이지 목록
	List<MoimDto> NewMoimList();
	List<MoimDto> PremiumMoimList();
	List<MoimDto> GenderCheckMoimList();
	
	
}
