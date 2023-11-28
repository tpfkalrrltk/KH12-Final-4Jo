package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.vo.JungmoMemberListVO;
import com.kh.EveryFit.vo.JungmoStatusVO;
import com.kh.EveryFit.vo.JungmoWithMembersVO;

public interface JungmoDao {

	 int sequence();

	//정모등록
	 void insert(JungmoDto jungmoDto);
	 void edit(JungmoDto jungmoDto);
//	 List<JungmoListByMoimNoVO> selectList(int moimNo);
	//정모취소
	 boolean cancel(int jungmoNo);
	 
	 //정모멤버리스트
	 List<JungmoMemberListVO> selectListByJungmoNo(int jungmoNo);
	 void memberJoin(String memberEmail, int jungmoNo);
	JungmoDto selectOneByJungmoNo(int jungmoNo);
	int selectOneJungmoMemberCount(int jungmoNo);
	boolean deleteJungmoMember(String memberEmail, int jungmoNo);
	List<JungmoWithMembersVO> selectTotalList(int moimNo);

	String selectMemberEmail(String memberEmail, int jungmoNo);
	
	boolean updateJungmoStatus(JungmoStatusVO vo);
	
	//스케줄러로 정모 마감 처리
	void updateJungmoStatus();
}
