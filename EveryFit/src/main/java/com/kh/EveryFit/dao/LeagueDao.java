package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;
import com.kh.EveryFit.vo.LeagueListVO;

public interface LeagueDao {

	//리그관련
	int leagueSequence();
	List<LeagueListDto> selectLeagueList();
	List<LeagueListDto> selectLeagueListSearch(LeagueListVO vo);
	void insertLeague(LeagueDto leagueDto);
	void updateLeague(int leagueNo, LeagueDto leagueDto);
	LeagueDto selectOneLeague(int leagueNo);
	void deleteLeague(int leagueNo);
	
	//리그참여팀 관련
	List<LeagueTeamDto> selectLeagueTeamList();
	int leagueTeamSequence();
	void insertLeagueTeam(LeagueTeamDto leagueTeamDto);
	LeagueTeamDto selectOneLeagueTeam(int leagueTeamNo);
	void updateLeagueTeam(LeagueTeamDto leagueTeamDto, int leagueTeamNo);
	void deleteLeagueTeam(int leagueTeamNo);
	
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
	List<LeagueMatchDto> selectLeagueMatchList();
	LeagueMatchDto selectOneLeagueMatch(int leagueMatchNo);
	void updateLeagueMatch(int leagueMatchNo, LeagueMatchDto leagueMatchDto);
	void deleteLeagueMatch(int leagueMatchNo);

}
