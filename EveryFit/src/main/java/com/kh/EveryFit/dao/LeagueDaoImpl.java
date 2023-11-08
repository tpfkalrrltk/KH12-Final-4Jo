package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.LeagueDto;

@Repository
public class LeagueDaoImpl implements LeagueDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int leagueSequence() {
		return sqlSession.selectOne("league.seqLegue");
	}
	
	@Override
	public List<LeagueDto> selectLeagueList() {
		return sqlSession.selectList("league.listLeague");
	}
	
	@Override
	public void insertLeague(LeagueDto leagueDto) {
		sqlSession.insert("league.insertLeague", leagueDto);
	}
}
