package com.kh.EveryFit.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.vo.LeagueScoreCalculateVO;

public class LeagueMatchCalculater {

	@Autowired LeagueDao leagueDao;
	
	public static LeagueScoreCalculateVO calculateTotalScore(int leagueTeamNo, List<LeagueMatchDto> list) {
		int totalG = 0;
		int totalD = 0;
		
		for(LeagueMatchDto match : list) {
			if(match.getLeagueMatchHomeScore()==null) {
				match.setLeagueMatchHomeScore(0);
			}
			if(match.getLeagueMatchAwayScore()==null) {
				match.setLeagueMatchAwayScore(0);
			}
		}
		
		for(LeagueMatchDto match : list) {
			if(match.getLeagueMatchHome() == leagueTeamNo) {
				totalG += match.getLeagueMatchHomeScore();
				totalD += match.getLeagueMatchAwayScore();
			}
			if(match.getLeagueMatchAway() == leagueTeamNo) {
				totalG += match.getLeagueMatchAwayScore();
				totalD += match.getLeagueMatchHomeScore();
			}
		}
		
		int totalGD = totalG - totalD;
		return LeagueScoreCalculateVO.builder().totalG(totalG).totalD(totalD).totalGD(totalGD).build();
	}
}
