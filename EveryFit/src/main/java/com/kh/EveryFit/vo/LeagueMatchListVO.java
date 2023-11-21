package com.kh.EveryFit.vo;

import java.text.ParseException;
import java.util.Date;

import com.kh.EveryFit.component.DateFormatUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueMatchListVO {
	private Integer leagueMatchNo;
    private Integer leagueNo;
    private Integer leagueMatchHome;
    private String homeTeamName;
    private Integer leagueMatchAway;
    private String awayTeamName;
    private String leagueMatchDate;
    private Date parsedLeagueMatchDate;
    private String leagueMatchLocation;
    private Integer leagueMatchHomeScore;
    private Integer leagueMatchAwayScore;

	public String getLeagueMatchDate() {
	    return leagueMatchDate;
	}
	
	public void setLeagueMatchDate(String leagueMatchDate) throws ParseException {
	    this.leagueMatchDate = leagueMatchDate;
	    this.parsedLeagueMatchDate =  DateFormatUtils.parseStringToDate(leagueMatchDate);
	}
	
	public Date getParsedLeagueMatchDate() {
	    return parsedLeagueMatchDate;
	}

}