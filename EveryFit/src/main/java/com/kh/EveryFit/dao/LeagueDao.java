package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.LeagueDto;

public interface LeagueDao {

	int leagueSequence();
	List<LeagueDto> selectLeagueList();
	void insertLeague(LeagueDto leagueDto);

}
