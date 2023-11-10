package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;

@Controller
@RequestMapping("/moim")
public class MoimController {

	@Autowired
	private MoimDao moimDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/create")
	public String create(Model model) {
		List<LocationDto> locationList = memberDao.selectLocationList(); //지역조회
		model.addAttribute("locationList", locationList);
		List<EventDto> eventList = memberDao.selectEventList(); //종목조회
		model.addAttribute("eventList", eventList);
		return "moim/create";
	}
	@PostMapping("/create")
	public String create(@ModelAttribute MoimDto moimDto) {
		int moimNo = moimDao.sequence();
		moimDto.setMoimNo(moimNo);
		moimDao.insert(moimDto);
		
		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
		//moimDto.setChatRoomNo에 넣기
		//모임등록한 사람의 아이디를 moim_member 테이블에 insert 하기!
		//모임등록한사람의 등급은 모임장으로 하자
		return "redirect:detail?moimNo="+moimNo;
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int moimNo) {
		//모임상세
		MoimDto moimDto = moimDao.selectOne(moimNo);
		model.addAttribute("moimDto", moimDto);
		//회원목록(moim_member)
		model.addAttribute("memberList", moimDao.selectAllMoimMembers(moimNo));
		//모임지역
		LocationDto locationDto = memberDao.selectOneByLocationNo(moimDto.getLocationNo());
		model.addAttribute("locationDto", locationDto);
		//모임종목
		EventDto eventDto = memberDao.selectOneByEventNo(moimDto.getEventNo());
		model.addAttribute("eventDto", eventDto);
		return "moim/detail";
		
	}
	
	
}
