package com.kh.EveryFit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.LeagueListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/league")
public class LeagueController {

	@Autowired private LeagueDao leagueDao;
	@Autowired private MemberDao memberDao;
	@Autowired private MoimDao moimDao;
	
	@RequestMapping("/leagueList")
	public String leagueList(Model model,@ModelAttribute(name="vo") LeagueListVO vo) {
		List<LeagueListDto> list = leagueDao.selectLeagueListSearch(vo);
		List<EventDto> eventList = memberDao.selectEventList();
		List<LocationDto> locationList = memberDao.selectLocationList();
		model.addAttribute("list", list);
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueList";
	}
	
	@GetMapping("/leagueInsert")
	public String leagueInsert(Model model) {
		List<EventDto> eventList = memberDao.selectEventList();
		List<LocationDto> locationList = memberDao.selectLocationList();
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueInsert";
	}
	
	@PostMapping("/leagueInsert")
	public String leagueInsert(@ModelAttribute LeagueDto leagueDto, HttpSession session) {
		//String leagueManager = (String)session.getAttribute("name");
		String leagueManager = "leaguetest1";
		int leagueNo = leagueDao.leagueSequence();
		
		leagueDto.setLeagueManager(leagueManager);
		leagueDto.setLeagueNo(leagueNo);
		leagueDto.setChatRoomNo(1);
		leagueDao.insertLeague(leagueDto);
		return "redirect:leagueGuide?leagueNo="+leagueNo;
	}
	
	@RequestMapping("leagueGuide")
	public String leagueGuide(@RequestParam int leagueNo, Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		model.addAttribute("leagueDto",leagueDto);
		return "league/leagueGuide";
	}
	
	@GetMapping("/leagueEdit")
	public String leagueEdit(@RequestParam int leagueNo, Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		EventDto eventDto = memberDao.selectOneByEventNo(leagueDto.getEventNo());
		LocationDto locationDto = memberDao.selectOneByLocationNo(leagueDto.getLocationNo());
		List<LocationDto> locationList = memberDao.selectLocationList();
		List<EventDto> eventList = memberDao.selectEventList();
		model.addAttribute("leagueDto", leagueDto);
		model.addAttribute("eventDto", eventDto);
		model.addAttribute("locationDto", locationDto);
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueEdit";
	}
	
	@PostMapping("/leagueEdit")
	public String leagueEdit(@ModelAttribute LeagueDto leagueDto, @RequestParam int leagueNo) {
		leagueDao.updateLeague(leagueNo, leagueDto);
		return "redirect:leagueGuide?leagueNo="+leagueNo;
	}
	
	@RequestMapping("/leagueDelete")
	public String leagueDelete(@RequestParam int leagueNo) {
		leagueDao.deleteLeague(leagueNo);
		return "redirect:leagueList";
	}
	
	@GetMapping("/leagueTeamInsert")
	public String leagueTeamInsert(@RequestParam int leagueNo, 
									@RequestParam int moimNo,
									Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		model.addAttribute("memberList", moimDao.selectAllMoimMembers(moimNo));
		model.addAttribute("leagueDto", leagueDto);
		return "league/leagueTeamInsert";
	}
	
	@PostMapping("/leagueTeamInsert")
	public String leagueTeamInsert(@RequestParam String[] memberEmail, 
									@RequestParam int leagueNo,
									@RequestParam int moimNo) {
		int leagueTeamNo = leagueDao.leagueTeamSequence();
		leagueDao.insertLeagueTeam(LeagueTeamDto.builder()
									.leagueTeamNo(leagueTeamNo)
									.leagueNo(leagueNo)
									.moimNo(moimNo)
									.build());
		
		for(String email : memberEmail) {
			leagueDao.insertLeagueTeamRoaster(LeagueTeamRoasterDto.builder()
						.leagueTeamRoasterNo(leagueDao.leagueTeamRoasterSequence())
						.leagueNo(leagueNo)
						.leagueTeamNo(leagueTeamNo)
						.memberEmail(email)
						.build());
		}
		return "redirect:leagueTeamDetail?leagueTeamNo="+leagueTeamNo;
	}
	
	@RequestMapping("/leagueTeamDetail")
	public String leagueTeamDetail(@RequestParam int leagueTeamNo, Model model) {
		LeagueTeamDto leagueTeamDto = leagueDao.selectOneLeagueTeam(leagueTeamNo);
		MoimDto moimDto = moimDao.selectOne(leagueTeamDto.getMoimNo());
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueTeamDto.getLeagueNo());
		model.addAttribute("leagueTeamDto", leagueTeamDto);
		model.addAttribute("moimDto", moimDto);
		model.addAttribute("leagueDto", leagueDto);
		return "/league/leagueTeamDetail";
	}
}
