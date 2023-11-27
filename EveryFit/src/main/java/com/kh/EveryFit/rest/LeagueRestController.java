package com.kh.EveryFit.rest;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.component.LeagueMatchMaker;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.CheckMoimListVO;
import com.kh.EveryFit.vo.LeagueMatchListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/league")
public class LeagueRestController {

	@Autowired private LeagueDao leagueDao;
	@Autowired private MoimDao moimDao;
	@Autowired private ChatDao chatDao;	
	
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
	public List<MoimDto> checkMoim(@RequestParam int leagueNo, HttpSession session){
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		String memberEmail = (String)session.getAttribute("name");
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
		LeagueTeamDto leagueTeamDto = leagueDao.selectOneLeagueTeam(leagueTeamNo);
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueTeamDto.getLeagueNo());
		String originStatus = leagueTeamDto.getLeagueTeamStatus();
		String status;
		String moimJang = moimDao.findMoimJang(leagueTeamDto.getMoimNo()).getMemberEmail();
		int chatRoomNo = leagueDto.getChatRoomNo();
		if(originStatus.equals("N")) {
			status = "Y";
			chatDao.addChatMember(leagueDto.getChatRoomNo(), moimJang);
		}
		else {
			status = "N";
			chatDao.deleteChatMember(chatRoomNo, moimJang);
		}
		return leagueDao.updateLeagueTeamStatus(leagueTeamNo, status); 
	}
	
	@PostMapping("/loadLeagueTeamList")
	public List<LeagueTeamDto> loadLeagueTeamList(@RequestParam int leagueNo){
		return leagueDao.listLeagueTeamByLeague(leagueNo);
	}
	
	@PostMapping("/autoMatchInsert")
	public void autoMatchInsert(@RequestParam int leagueNo, @RequestParam boolean isDouble) {
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
	
	
	@PostMapping("/findLeagueMatchVO")
	public LeagueMatchListVO findLeagueMatchVO(@RequestParam int leagueMatchNo){
		return leagueDao.selectOneLeagueMatchListVO(leagueMatchNo);
	}
	
	@PostMapping("/isTeamRegistered")
	public String isTeamRegistered(@RequestParam int leagueNo, @RequestParam int moimNo) {
		List<LeagueTeamDto> findDto = leagueDao.isTeamRegistered(leagueNo, moimNo);
		return findDto.size()==0 ? "legal" : "illegal"; 
	}
	
	@PostMapping("/listLeagueByMoimNo")
	public List<LeagueDto> listLeagueByMoimNo(@RequestParam int moimNo){
		return leagueDao.listLeagueBymoimNo(moimNo);
	}
}
