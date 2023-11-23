package com.kh.EveryFit.dao;

import java.util.List;

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

public interface AdminDao {
	//관리자 기능
	
	//회원
	List<MemberDto>adminMemberList();

	MemberDto adminMemberTarget(String memberEmail);

	List<MemberDto> adminMemberSearch(AdminMemberSearchVO adminMemberSearchVO);

	
	//모임
	List<MoimDto>adminMoimList();
	
	List<MoimDto> adminMoimSearch(AdminMoimSearchVO adminMoimSearchVO);
	
	Integer moimMemberCount(int moimNo);

	
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
	
	
	//신고
	List<ReportDto> reportList();
	List<ReportDto> adminReportSearch(AdminReportSearchVO adminReportSearchVO);
	
	//모임 멤버 인원수 조회
	List< AdminMoimMemberCountVO> memberCount();

	
	
	//회원 차단
	boolean insertBlock(String memberEmail);

	boolean deleteBlock(String memberEmail);
	
	
	//신고 등록
	void reportApply(ReportDto reportDto); 
	//신고 확인
	ReportDto reportDetail(int reportNo);
	
	int sequence();

	void insertReportImage(int reportNo, int attachNo);

	Integer findReportImage(Integer reportNo);

	void deleteReportImage(int reportNo);
}
