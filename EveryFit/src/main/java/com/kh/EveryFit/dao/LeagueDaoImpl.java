package com.kh.EveryFit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.LeagueDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class LeagueDaoImpl implements LeagueDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int leagueSequence() {
		return sqlSession.selectOne("league.seqLeague");
	}
	
	@Override
	public List<LeagueDto> selectLeagueList() {
		return sqlSession.selectList("league.listLeague");
	}
	
	@Override
	public void insertLeague(LeagueDto leagueDto) {
		sqlSession.insert("league.insertLeague", leagueDto);
	}
	
	@Override
	public void updateLeague(int leagueNo, LeagueDto leagueDto) {
		Map<String, Object> param = Map.of("leagueNo", leagueNo, "leagueDto", leagueDto);
		int result = sqlSession.update("league.updateLeague", param);
//		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public LeagueDto selectOneLeague(int leagueNo) {
		LeagueDto leagueDto = sqlSession.selectOne("league.findLeague", leagueNo);
//		if(leagueDto==null) throw new NoTargetException();
		return leagueDto;
	}
	
	@Override
	public void deleteLeague(int leagueNo) {
		int result = sqlSession.delete("league.deleteLeague", leagueNo);
//		if(result == 0) throw new NoTargetException();
	}
	
}
