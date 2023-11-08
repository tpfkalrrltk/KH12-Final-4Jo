package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.LeagueDto;

public interface LeagueDao {

	int leagueSequence();
	List<LeagueDto> selectLeagueList();
	void insertLeague(LeagueDto leagueDto);
	void updateLeague(int leagueNo, LeagueDto leagueDto);
	LeagueDto selectOneLeague(int leagueNo);
	void deleteLeague(int leagueNo);

}
