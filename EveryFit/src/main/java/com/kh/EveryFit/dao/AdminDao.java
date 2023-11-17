package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.vo.AdminMemberSearchVO;

public interface AdminDao {
	//관리자 기능
	List<MemberDto>adminMemberList();

	MemberDto adminMemberTarget(String memberEmail);

	List<MemberDto> adminMemberSearch(AdminMemberSearchVO adminMemberSearchVO);
	
	
}
