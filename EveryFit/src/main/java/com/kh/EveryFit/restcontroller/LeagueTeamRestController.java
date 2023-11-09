package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueTeamDto;


@RestController
@CrossOrigin
@RequestMapping("/leagueTeam")
public class LeagueTeamRestController {

	@Autowired private LeagueDao leagueDao;
	
	@GetMapping("/")
	public List<LeagueTeamDto> selectList(){
		return leagueDao.selectLeagueTeamList();
	}
	
	@GetMapping("/{leagueTeamNo}")
	public LeagueTeamDto selectOne(@PathVariable int leagueTeamNo) {
		return leagueDao.selectOneLeagueTeam(leagueTeamNo);
	}
	
	@PostMapping("/")
	public void insert(@RequestBody LeagueTeamDto leagueTeamDto) {
		leagueTeamDto.setLeagueTeamNo(leagueDao.leagueTeamSequence());
		leagueDao.insertLeagueTeam(leagueTeamDto);
	}
	
	@PutMapping("/{leagueTeamNo}")
	public void update(@RequestBody LeagueTeamDto leagueTeamDto, @PathVariable int leagueTeamNo) {
		leagueDao.updateLeagueTeam(leagueTeamDto, leagueTeamNo);
	}
	
	@DeleteMapping("/{leagueTeamNo}")
	public void delete(@PathVariable int leagueTeamNo) {
		leagueDao.deleteLeagueTeam(leagueTeamNo);
	}
}
