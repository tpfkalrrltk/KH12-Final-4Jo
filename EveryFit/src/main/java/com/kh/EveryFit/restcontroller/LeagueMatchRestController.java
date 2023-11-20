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
		leagueDao.updateLeagueMatch(leagueMatchNo, leagueMatchDto);
	}
	
	@DeleteMapping("/{leagueMatchNo}")
	public void delete(@PathVariable int leagueMatchNo) {
		leagueDao.deleteLeagueMatch(leagueMatchNo);
	}
	
	@PutMapping("/result/{leagueMatchNo}")
	public void updateResult(@ModelAttribute LeagueMatchDto leagueMatchDto, @PathVariable int leagueMatchNo) {
		LeagueMatchDto originMatchDto = leagueDao.selectOneLeagueMatch(leagueMatchNo);
		boolean isEdit = originMatchDto.getLeagueMatchAwayScore() != null;
		LeagueTeamDto homeDto = leagueDao.selectOneLeagueTeam(leagueMatchDto.getLeagueMatchHome());
		LeagueTeamDto awayDto = leagueDao.selectOneLeagueTeam(leagueMatchDto.getLeagueMatchAway());
		int homeScore = leagueMatchDto.getLeagueMatchHomeScore();
		int awayScore = leagueMatchDto.getLeagueMatchAwayScore();

		if(isEdit) {
			int originHomeScore = originMatchDto.getLeagueMatchHomeScore();
			int originAwayScore = originMatchDto.getLeagueMatchAwayScore();
			homeDto.setLeagueTeamG(homeDto.getLeagueTeamG() - originHomeScore);
			homeDto.setLeagueTeamD(homeDto.getLeagueTeamD() - originAwayScore);
			awayDto.setLeagueTeamG(awayDto.getLeagueTeamG() - originAwayScore);
			awayDto.setLeagueTeamD(awayDto.getLeagueTeamD() - originHomeScore);
			if(originHomeScore > originAwayScore) {
				homeDto.setLeagueTeamWin(homeDto.getLeagueTeamWin() - 1);
				awayDto.setLeagueTeamLose(awayDto.getLeagueTeamLose() - 1);
			}
			else if(originHomeScore < originAwayScore) {
				awayDto.setLeagueTeamWin(awayDto.getLeagueTeamWin() - 1);
				homeDto.setLeagueTeamLose(homeDto.getLeagueTeamLose() - 1);
			}
			else {
				awayDto.setLeagueTeamDraw(awayDto.getLeagueTeamDraw() - 1);
				homeDto.setLeagueTeamDraw(homeDto.getLeagueTeamDraw() - 1);
			}
		}
		
		
		homeDto.setLeagueTeamG(homeDto.getLeagueTeamG() + homeScore);
		homeDto.setLeagueTeamD(homeDto.getLeagueTeamD() + awayScore);
		awayDto.setLeagueTeamG(awayDto.getLeagueTeamG() + awayScore);
		awayDto.setLeagueTeamD(awayDto.getLeagueTeamD() + homeScore);
		
		if(homeScore > awayScore) {
			homeDto.setLeagueTeamWin(homeDto.getLeagueTeamWin() + 1);
			awayDto.setLeagueTeamLose(awayDto.getLeagueTeamLose() + 1);
		}
		else if(homeScore < awayScore) {
			homeDto.setLeagueTeamLose(homeDto.getLeagueTeamLose() + 1);
			awayDto.setLeagueTeamWin(awayDto.getLeagueTeamWin() + 1);
		}
		else {
			homeDto.setLeagueTeamDraw(homeDto.getLeagueTeamDraw() + 1);
			awayDto.setLeagueTeamDraw(awayDto.getLeagueTeamDraw() + 1);
		}
		
		leagueDao.updateLeagueMatch(leagueMatchNo, leagueMatchDto);
		leagueDao.updateLeagueTeam(homeDto, homeDto.getLeagueTeamNo());
		leagueDao.updateLeagueTeam(awayDto, awayDto.getLeagueTeamNo());
		leagueDao.leagueTeamCalculate(homeDto.getLeagueTeamNo());
		leagueDao.leagueTeamCalculate(awayDto.getLeagueTeamNo());
	}
	
}
