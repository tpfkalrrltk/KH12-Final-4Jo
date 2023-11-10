package com.kh.EveryFit.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.LocationDto;

@RestController
@RequestMapping("/rest/location")
public class LocationRestController {

	@Autowired private MemberDao memberDao;
	
	@PostMapping("/depth2List")
	public List<LocationDto> depth2list(@RequestParam String locationDepth1){
		return memberDao.selectLocationListByDepth1(locationDepth1);
	}
	
}
