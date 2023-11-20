package com.kh.EveryFit.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LeagueScheduler {

	@Autowired private LeagueDao leagueDao;
	
	//@Scheduled(cron = "0/30 * * * * ?")
	private void leagueStatusUpdate() {
		List<LeagueDto> leagueList = leagueDao.selectLeagueDtoList();
		LocalDateTime currentDate = LocalDateTime.now();
		
		for(LeagueDto leagueDto:leagueList) {
			int leagueNo = leagueDto.getLeagueNo();
			LeagueApplicationDto applicationDto = leagueDao.selectOneLeagueApplication(leagueNo);
			if(applicationDto==null) continue;
			LocalDateTime applicationStart = 
					LocalDateTime.parse(applicationDto.getLeagueApplicationStart(), 
							DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			LocalDateTime applicationEnd = 
					LocalDateTime.parse(applicationDto.getLeagueApplicationEnd(), 
							DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			String status;
			if(currentDate.isBefore(applicationEnd) && currentDate.isAfter(applicationStart)) {
				status="접수중";
			}
			else if(currentDate.isAfter(applicationEnd)) {
				status = "접수마감";
			}
			else {
				status="대기상태";
			}
			log.debug("status = {}", status);
			if(!leagueDto.getLeagueStatus().equals(status)) {
				leagueDto.setLeagueStatus(status);
				log.debug("leagueDto = {}", leagueDto);
				leagueDao.updateLeague(leagueNo, leagueDto);
			}
		}
	}

}
