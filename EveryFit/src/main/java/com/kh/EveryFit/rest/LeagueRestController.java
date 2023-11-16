package com.kh.EveryFit.rest;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.CheckMoimListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/league")
public class LeagueRestController {

	@Autowired private LeagueDao leagueDao;
	@Autowired private MoimDao moimDao;
	
	@PostMapping("/addLeagueApplication")
	public void addLeagueApplication(@ModelAttribute LeagueApplicationDto applicationDto) throws ParseException {
		int applicationNo = leagueDao.leagueApplicationSeqeunce();
		applicationDto.setLeagueApplicationNo(applicationNo);
		leagueDao.insertLeagueApplication(applicationDto);
	}
	
	@PostMapping("/findLeagueApplication")
	public LeagueApplicationDto findLeagueApplication(@RequestParam int leagueNo) {
		LeagueApplicationDto dto = leagueDao.selectOneLeagueApplication(leagueNo);
		return dto;
	}
	
	@PostMapping("/updateLeagueApplication")
	public void updateLeagueApplication(@ModelAttribute LeagueApplicationDto applicationDto) {
		leagueDao.updateLeagueApplication(applicationDto.getLeagueApplicationNo(), applicationDto);
	}
	
	@PostMapping("/checkMoim")
	public List<MoimDto> checkMoim(@RequestParam int leagueNo){
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		String memberEmail = "leaguetest1";
		int locationNo = leagueDto.getLocationNo();
		int eventNo = leagueDto.getEventNo();
		CheckMoimListVO vo = CheckMoimListVO.builder()
								.memberEmail(memberEmail)
								.locationNo(locationNo)
								.eventNo(eventNo)
								.build();
		List<MoimDto> list = moimDao.checkMoimList(vo);
		return list;
	}
	
	@PostMapping("/updateLeagueTeamStatus")
	public boolean updateLeagueTeamStatus(@RequestParam int leagueTeamNo) {
		String origin = leagueDao.selectOneLeagueTeam(leagueTeamNo).getLeagueTeamStatus();
		String status;
		status = origin.equals("N") ? "Y" : "N";
		return leagueDao.updateLeagueTeamStatus(leagueTeamNo, status); 
	}
	
	@PostMapping("/loadLeagueTeamList")
	public List<LeagueTeamDto> loadLeagueTeamList(@RequestParam int leagueNo){
		return leagueDao.listLeagueTeamByLeague(leagueNo);
	}
}
