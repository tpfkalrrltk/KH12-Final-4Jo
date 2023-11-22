package com.kh.EveryFit.component;

import java.util.ArrayList;
import java.util.List;

public class LeagueMatchMaker {

	public static List<Integer> addTeamList(List<Integer> teamList){
		List<Integer> resultList = new ArrayList<>();
		for(int i=0;i<teamList.size();i++) {
			resultList.add(teamList.get(i));
		}
		return resultList;
	}
	
	public static List<List<Integer>> makeMatch(List<Integer>resultList, boolean isDouble){
		List<List<Integer>> matchList = new ArrayList<>();
		for(int i=0;i<resultList.size();i++) {
			for(int j=i+1;j<resultList.size();j++) {
				List<Integer> match = new ArrayList<>();
				match.add(resultList.get(i));
				match.add(resultList.get(j));
				matchList.add(match);
				
				if(isDouble)
				for(int k=0;k<1;k++) {
					List<Integer> match2 = new ArrayList<>();
					match2.add(resultList.get(j));
					match2.add(resultList.get(i));
					matchList.add(match2);
				}
			}
		}
		return matchList;
	}
}
