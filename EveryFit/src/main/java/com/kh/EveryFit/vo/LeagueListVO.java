package com.kh.EveryFit.vo;

import org.springframework.util.StringUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class LeagueListVO {
	private Integer leagueNo;
	private String leagueManager;
	private String leagueTitle;
	private int leagueEntryFee;
	private String leagueStatus;
	private String eventName;
	private String locationDepth1;
	private String locationDepth2;
	
	@Builder.Default
	private int page = 1;//현재페이지
	@Builder.Default
	private int size = 10;//개수
	private int count;
	@Builder.Default
	private int navigatorSize = 5;//네비게이터 개수
	
	public int getBegin() {
		return (page-1) / navigatorSize * navigatorSize + 1;
	}
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end); 
	}
	public boolean isFirst() {
		return getBegin() == 1;
	}
	
	public int getPageCount() {
		return (count-1) / size + 1;
	}
	
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
	
	
	public String generateQueryString() {
        StringBuilder queryString = new StringBuilder();

        if (StringUtils.hasText(eventName)) {
            queryString.append("&eventName=").append(eventName);
        }

        if (StringUtils.hasText(leagueStatus)) {
            queryString.append("&leagueStatus=").append(leagueStatus);
        }

        if (StringUtils.hasText(locationDepth1)) {
            queryString.append("&locationDepth1=").append(locationDepth1);
        }

        if (StringUtils.hasText(locationDepth2)) {
            queryString.append("&locationDepth2=").append(locationDepth2);
        }

        if (StringUtils.hasText(leagueTitle)) {
            queryString.append("&leagueTitle=").append(leagueTitle);
        }

        return queryString.toString();
    }
}
