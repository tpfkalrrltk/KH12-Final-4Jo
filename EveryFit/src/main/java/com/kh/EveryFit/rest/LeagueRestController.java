package com.kh.EveryFit.rest;

import java.sql.Date;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.component.TimeFormatter;
import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueApplicationDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/league")
public class LeagueRestController {

	@Autowired private LeagueDao leagueDao;
	
	@PostMapping("/addLeagueApplication")
	public void addLeagueApplication(@ModelAttribute LeagueApplicationDto applicationDto) throws ParseException {
		log.debug("dto = {}", applicationDto);
		
		int applicationNo = leagueDao.leagueApplicationSeqeunce();
		applicationDto.setLeagueApplicationNo(applicationNo);
		leagueDao.insertLeagueApplication(applicationDto);
	}
	
	@PostMapping("/findLeagueApplication")
	public LeagueApplicationDto findLeagueApplication(@RequestParam int leagueNo) {
		LeagueApplicationDto dto = leagueDao.selectOneLeagueApplication(leagueNo);
		return dto==null? null: dto;
	}
	
	@PostMapping("/updateLeagueApplication")
	public void updateLeagueApplication(@ModelAttribute LeagueApplicationDto applicationDto) {
		leagueDao.updateLeagueApplication(applicationDto.getLeagueApplicationNo(), applicationDto);
	}
}
