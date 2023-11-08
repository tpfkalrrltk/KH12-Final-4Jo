package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dto.LeagueDto;

@RestController
@CrossOrigin
@RequestMapping("/league")
public class LeagueRestController {

	@GetMapping("/")
	public List<LeagueDto> list(){
		return null;
	}
}
