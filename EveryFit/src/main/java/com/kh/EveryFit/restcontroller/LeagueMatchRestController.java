package com.kh.EveryFit.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/leagueMatch")
public class LeagueMatchRestController {

	@Autowired private LeagueDao leagueDao;
	
	@PostMapping("/")
	public void insert(@ModelAttribute LeagueMatchDto leagueMatchDto) {
		log.debug("leagueMatchDto = {}", leagueMatchDto);
		leagueMatchDto.setLeagueMatchNo(leagueDao.leagueMatchSequence());
		leagueDao.insertLeagueMatch(leagueMatchDto);
	}
	
	
	@GetMapping("/{leagueMatchNo}")
	public LeagueMatchDto selectOne(@PathVariable int leagueMatchNo) {
		return leagueDao.selectOneLeagueMatch(leagueMatchNo);
	}
	
	@PutMapping("/{leagueMatchNo}")
	public void update(@ModelAttribute LeagueMatchDto leagueMatchDto, @PathVariable int leagueMatchNo) {
		LeagueMatchDto originLeagueMatchDto = leagueDao.selectOneLeagueMatch(leagueMatchNo);
		LeagueTeamDto homeDto = leagueDao.selectOneLeagueTeam(leagueMatchDto.getLeagueMatchHome());
		LeagueTeamDto AwayDto = leagueDao.selectOneLeagueTeam(leagueMatchDto.getLeagueMatchAway());
		int homeScore = leagueMatchDto.getLeagueMatchHomeScore();
		int awayScore = leagueMatchDto.getLeagueMatchAwayScore();
		
		if(originLeagueMatchDto.getLeagueMatchHomeScore()==null) {
			homeDto.setLeagueTeamMatchCount(homeDto.getLeagueTeamMatchCount()+1);
			
		}
		
		
		if(homeScore > awayScore) {
			
		}
		else if (homeScore < awayScore) {
			
		}
		else {
			
		}
		
		leagueDao.updateLeagueMatch(leagueMatchNo, leagueMatchDto);
	}
	
	@DeleteMapping("/{leagueMatchNo}")
	public void delete(@PathVariable int leagueMatchNo) {
		leagueDao.deleteLeagueMatch(leagueMatchNo);
	}
	
}
