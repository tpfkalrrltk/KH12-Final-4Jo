package com.kh.EveryFit.service;

import java.sql.Date;
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
	
	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	
	//@Scheduled(cron = "0/30 * * * * ?")
	private void leagueStatusUpdate() {
		List<LeagueDto> leagueList = leagueDao.selectLeagueDtoList();
		LocalDateTime currentDate = LocalDateTime.now();
		Date currentDateSql = Date.valueOf(currentDate.toLocalDate());
		
		for(LeagueDto leagueDto:leagueList) {
			int leagueNo = leagueDto.getLeagueNo();
			LeagueApplicationDto applicationDto = leagueDao.selectOneLeagueApplication(leagueNo);
			if(applicationDto==null) continue;
			LocalDateTime applicationStart = 
					LocalDateTime.parse(applicationDto.getLeagueApplicationStart(), formatter);
			LocalDateTime applicationEnd = 
					LocalDateTime.parse(applicationDto.getLeagueApplicationEnd(), formatter);
			
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
			if(currentDateSql.before(leagueDto.getLeagueEnd()) 
					&& currentDateSql.after(leagueDto.getLeagueStart())) {
				status = "진행중";
			}
			else if(currentDateSql.after(leagueDto.getLeagueEnd())) {
				status = "종료됨";
			}
			
			if(!leagueDto.getLeagueStatus().equals(status)) {
				leagueDto.setLeagueStatus(status);
				leagueDao.updateLeague(leagueNo, leagueDto);
			}
		}
	}
}
