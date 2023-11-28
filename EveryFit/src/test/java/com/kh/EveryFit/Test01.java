package com.kh.EveryFit;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.EveryFit.component.LeagueMatchMaker;
import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class Test01 {

	@Autowired LeagueDao leagueDao;
	
	@Test
	public void test() {
		int leagueNo = 2;
		boolean isDouble = false;
		List<LeagueTeamDto> leagueTeamList = leagueDao.lsitLeagueTeamApprove(leagueNo);
		List<Integer> leagueTeamNoList = new ArrayList<>();
		for(int i=0;i<leagueTeamList.size();i++) {
			leagueTeamNoList.add(leagueTeamList.get(i).getLeagueTeamNo());
		}
		LeagueMatchMaker.addTeamList(leagueTeamNoList);
		List<List<Integer>> matchList = LeagueMatchMaker.makeMatch(leagueTeamNoList, isDouble);
		Collections.shuffle(matchList);
		for(List<Integer> match : matchList) {
			int leagueMatchNo = leagueDao.leagueMatchSequence();
			leagueDao.insertLeagueMatch(LeagueMatchDto.builder()
										.leagueNo(leagueNo)
										.leagueMatchNo(leagueMatchNo)
										.leagueMatchHome(match.get(0))
										.leagueMatchAway(match.get(1))
										.build());
		}
	}
	
}
