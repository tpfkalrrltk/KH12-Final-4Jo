package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;
import com.kh.EveryFit.vo.LeagueListVO;
import com.kh.EveryFit.vo.LeagueMatchListVO;
import com.kh.EveryFit.vo.LeagueTeamRankListVO;

public interface LeagueDao {

	//리그관련
	int leagueSequence();
	List<LeagueListDto> selectLeagueList();
	List<LeagueListDto> selectLeagueListSearch(LeagueListVO vo);
	int countLeague(LeagueListVO vo);
	void insertLeague(LeagueDto leagueDto);
	void updateLeague(int leagueNo, LeagueDto leagueDto);
	LeagueDto selectOneLeague(int leagueNo);
	void deleteLeague(int leagueNo);
	void insertLeagueImage(int leagueNo, int attachNo);
	List<LeagueDto> selectLeagueDtoList();
	
	//리그참여팀 관련
	List<LeagueTeamDto> selectLeagueTeamList();
	int leagueTeamSequence();
	void insertLeagueTeam(LeagueTeamDto leagueTeamDto);
	LeagueTeamDto selectOneLeagueTeam(int leagueTeamNo);
	void updateLeagueTeam(LeagueTeamDto leagueTeamDto, int leagueTeamNo);
	void deleteLeagueTeam(int leagueTeamNo);
	List<LeagueTeamDto> listLeagueTeamByLeague(int leagueNo);
	List<LeagueTeamDto> listLeagueTeamNonApprove(int leagueNo);
	List<LeagueTeamDto> lsitLeagueTeamApprove(int leagueNo);
	List<LeagueTeamRankListVO> leagueTeamRank(int leagueNo);
	boolean updateLeagueTeamStatus(int leagueTeamNo, String status);
	void leagueTeamCalculate(int leagueTeamNo);
	List<LeagueTeamDto> isTeamRegistered(int leagueNo, int moimNo);//참여가능확인
	void insertLeagueTeamImage(int leagueTeamNo, int attachNo);//리그팀이미지
	
	
	//리그 접수 관련
	List<LeagueApplicationDto> selectLeagueApplcationList();
	int leagueApplicationSeqeunce();
	void insertLeagueApplication(LeagueApplicationDto leagueApplicationDto);
	LeagueApplicationDto selectOneLeagueApplication(int leagueNo);
	void updateLeagueApplication(int leagueApplicationNo, LeagueApplicationDto leagueApplicationDto);
	void deleteLeagueApplication(int leagueApplicationNo);
	
	//리그팀로스터 관련
	int leagueTeamRoasterSequence();
	List<LeagueTeamRoasterDto> selectLeagueTeamRoasterList();
	void insertLeagueTeamRoaster(LeagueTeamRoasterDto LeagueTeamRoasterDto);
	LeagueTeamRoasterDto selectOneLeagueTeamRoaster(int leagueTeamRoasterNo);
	void updateLeagueTeamRoaster(int leagueTeamRoasterNo, LeagueTeamRoasterDto leagueTeamRoasterDto);
	void deleteLeagueTeamRoaster(int leagueTeamRoasterNo);
	
	//리그 경기 관련
	int leagueMatchSequence();
	void insertLeagueMatch(LeagueMatchDto leagueMatchDto);
	LeagueMatchDto selectOneLeagueMatch(int leagueMatchNo);
	void updateLeagueMatch(int leagueMatchNo, LeagueMatchDto leagueMatchDto);
	void deleteLeagueMatch(int leagueMatchNo);
	List<LeagueMatchDto> selectLeagueMatchList(int leagueNo);
	LeagueMatchListVO selectOneLeagueMatchListVO(int leaugeMatchNo);
	List<LeagueMatchListVO> selectLeagueMatchVOList(int leagueNo);
	List<LeagueMatchListVO> selectLeagueMatchVOListByTeamNo(int leagueNo, int leagueTeamNo);
	
	
	
	
	
	

}
