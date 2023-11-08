package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueDto;

@RestController
@CrossOrigin
@RequestMapping("/league")
public class LeagueRestController {

	@Autowired
	private LeagueDao leagueDao;
	
	@GetMapping("/")
	public List<LeagueDto> list(){
		return leagueDao.selectLeagueList();
	}
	
	@PostMapping("/")
	public void insert(LeagueDto leagueDto) {
		leagueDto.setLeagueNo(leagueDao.leagueSequence());
		leagueDao.insertLeague(leagueDto);
	}
}
