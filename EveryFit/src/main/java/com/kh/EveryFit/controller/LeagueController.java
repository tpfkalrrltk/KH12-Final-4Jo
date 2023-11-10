package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.vo.LeagueListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/league")
public class LeagueController {

	@Autowired private LeagueDao leagueDao;
	@Autowired private MemberDao memberDao;
	
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
}
