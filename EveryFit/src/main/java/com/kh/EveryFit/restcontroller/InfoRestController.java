package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LocationDto;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	
	@GetMapping("/location/{locationDepth1}")
	public List<LocationDto> locationList(@PathVariable String locationDepth1){
		return memberDao.selectLocationListByDepth1(locationDepth1);
	}
	
	@GetMapping("/location")
	public List<LocationDto> locationListAll(){
		return memberDao.selectLocationList();
	}
	
	@GetMapping("/locationfind/{locationNo}")
	public LocationDto findLocation(@PathVariable int locationNo) {
		return memberDao.selectOneByLocationNo(locationNo);
	}
}
