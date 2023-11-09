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
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;


@CrossOrigin
@RestController
@RequestMapping("/leagueTeamRoaster")
public class LeagueTeamRoasterRestController {

	@Autowired private LeagueDao leagueDao;
	
	@GetMapping("/")
	public List<LeagueTeamRoasterDto> list() {
		return leagueDao.selectLeagueTeamRoasterList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody LeagueTeamRoasterDto dto) {
		dto.setLeagueTeamRoasterNo(leagueDao.leagueTeamRoasterSequence());
		leagueDao.insertLeagueTeamRoaster(dto);
	}
	
	@GetMapping("/{leagueTeamRoasterNo}")
	public LeagueTeamRoasterDto selectOne(@PathVariable int leagueTeamRoasterNo) {
		return leagueDao.selectOneLeagueTeamRoaster(leagueTeamRoasterNo);
	}
	
	@PutMapping("/{leagueTeamRoasterNo}")
	public void update(@PathVariable int leagueTeamRoasterNo, @RequestBody LeagueTeamRoasterDto leagueTeamRoasterDto) {
		leagueDao.updateLeagueTeamRoaster(leagueTeamRoasterNo, leagueTeamRoasterDto);
	}
	
	@DeleteMapping("/{leagueTeamRoasterNo}")
	public void delete(@PathVariable int leagueTeamRoasterNo) {
		leagueDao.deleteLeagueTeamRoaster(leagueTeamRoasterNo);
	}
}
