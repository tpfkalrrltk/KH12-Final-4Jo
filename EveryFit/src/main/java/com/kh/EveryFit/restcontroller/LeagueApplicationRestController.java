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
import com.kh.EveryFit.dto.LeagueApplicationDto;

@CrossOrigin
@RestController
@RequestMapping("/leagueApplication")
public class LeagueApplicationRestController {

	@Autowired private LeagueDao leagueDao;
	
	@GetMapping("/")
	public List<LeagueApplicationDto> list(){
		return leagueDao.selectLeagueApplcationList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody LeagueApplicationDto leagueApplicationDto) {
		leagueApplicationDto.setLeagueApplicationNo(leagueDao.leagueApplicationSeqeunce());
		leagueDao.insertLeagueApplication(leagueApplicationDto);
	}
	
	@GetMapping("/{leagueApplicationNo}")
	public LeagueApplicationDto selectOne(@PathVariable int leagueApplicationNo) {
		return leagueDao.selectOneLeagueApplication(leagueApplicationNo);
	}
	
	@PutMapping("/{leagueApplicationNo}")
	public void update(@PathVariable int leagueApplicationNo, @RequestBody LeagueApplicationDto leagueApplicationDto) {
		leagueDao.updateLeagueApplication(leagueApplicationNo ,leagueApplicationDto);
	}
	
	@DeleteMapping("/{leagueApplicationNo}")
	public void delete(@PathVariable int leagueApplicationNo) {
		leagueDao.deleteLeagueApplication(leagueApplicationNo);
	}
}
