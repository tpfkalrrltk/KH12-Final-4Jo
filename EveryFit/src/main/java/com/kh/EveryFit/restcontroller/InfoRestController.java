package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name="메인 테이블외에 컨트롤러", description = "리액트에서 써야하는 부가 컨트롤러들")
@CrossOrigin
@RestController
@RequestMapping("/info")
public class InfoRestController {

	@Autowired private MemberDao memberDao;
	
	@GetMapping("/event")
	public List<EventDto> eventList(){
		return memberDao.selectEventList();
	}
	
	@GetMapping("/location")
	public List<LocationDto> locationList(){
		return memberDao.selectLocationList();
	}
}
