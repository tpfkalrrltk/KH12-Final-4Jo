package com.kh.EveryFit.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;
import com.kh.EveryFit.error.NoTargetException;
import com.kh.EveryFit.vo.LeagueListVO;
import com.kh.EveryFit.vo.LeagueMatchListVO;
import com.kh.EveryFit.vo.LeagueTeamRankListVO;

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
	public List<LeagueListDto> selectLeagueList() {
		return sqlSession.selectList("league.listLeague");
	}
	
	@Override
	public List<LeagueListDto> selectLeagueListSearch(LeagueListVO vo) {
		log.debug("vo={}", vo);
		return sqlSession.selectList("league.listLeagueSearch", vo);
	}
	
	@Override
	public void insertLeague(LeagueDto leagueDto) {
		sqlSession.insert("league.insertLeague", leagueDto);
	}
	
	@Override
	public void updateLeague(int leagueNo, LeagueDto leagueDto) {
		Map<String, Object> param = Map.of("leagueNo", leagueNo, "leagueDto", leagueDto);
		int result = sqlSession.update("league.updateLeague", param);
		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public LeagueDto selectOneLeague(int leagueNo) {
		LeagueDto leagueDto = sqlSession.selectOne("league.findLeague", leagueNo);
		if(leagueDto==null) throw new NoTargetException();
		return leagueDto;
	}
	
	@Override
	public void deleteLeague(int leagueNo) {
		int result = sqlSession.delete("league.deleteLeague", leagueNo);
		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public List<LeagueTeamDto> selectLeagueTeamList() {
		return sqlSession.selectList("league.listLeagueTeam");
	}
	
	@Override
	public int leagueTeamSequence() {
		return sqlSession.selectOne("league.seqLeagueTeam");
	}
	
	@Override
	public void insertLeagueTeam(LeagueTeamDto leagueTeamDto) {
		sqlSession.insert("league.insertLeagueTeam", leagueTeamDto);
	}
	
	@Override
	public LeagueTeamDto selectOneLeagueTeam(int leagueTeamNo) {
		LeagueTeamDto leagueTeamDto = sqlSession.selectOne("league.findLeagueTeam", leagueTeamNo);
		if(leagueTeamDto==null) throw new NoTargetException();
		return leagueTeamDto;
	}
	
	@Override
	public void updateLeagueTeam(LeagueTeamDto leagueTeamDto, int leagueTeamNo) {
		Map<String, Object> param = Map.of("leagueTeamDto", leagueTeamDto, "leagueTeamNo", leagueTeamNo);
		int result = sqlSession.update("league.updateLeagueTeam", param);
		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public void deleteLeagueTeam(int leagueTeamNo) {
		int result = sqlSession.delete("league.deleteLeagueTeam", leagueTeamNo);
		if(result == 0) throw new NoTargetException();
	}
	
	@Override
	public List<LeagueApplicationDto> selectLeagueApplcationList() {
		return sqlSession.selectList("league.listLeagueApplication");
	}
	
	@Override
	public int leagueApplicationSeqeunce() {
		return sqlSession.selectOne("league.seqLeagueApplication");
	}
	
	@Override
	public void insertLeagueApplication(LeagueApplicationDto leagueApplicationDto) {
		sqlSession.insert("league.insertLeagueApplication", leagueApplicationDto);
	}
	
	@Override
	public LeagueApplicationDto selectOneLeagueApplication(int leagueNo) {
		LeagueApplicationDto leagueApplicationDto = sqlSession.selectOne("league.findLeagueApplication", leagueNo);
		//if(leagueApplicationDto==null) throw new NoTargetException();
		return leagueApplicationDto;
	}
	
	@Override
	public void updateLeagueApplication(int leagueApplicationNo, LeagueApplicationDto leagueApplicationDto) {
		Map<String, Object> param = Map.of("leagueApplicationNo", leagueApplicationNo,"leagueApplicationDto", leagueApplicationDto);
		int result = sqlSession.update("league.updateLeagueApplication", param);
		//if(result==0) throw new NoTargetException();
	}
	
	@Override
	public void deleteLeagueApplication(int leagueApplicationNo) {
		int result = sqlSession.delete("league.deleteLeagueApplication", leagueApplicationNo);
		if(result==0) throw new NoTargetException();
	}
	
	@Override
	public int leagueTeamRoasterSequence() {
		return sqlSession.selectOne("league.seqLeagueTeamRoaster");
	}
	
	@Override
	public List<LeagueTeamRoasterDto> selectLeagueTeamRoasterList() {		
		return sqlSession.selectList("league.listLeagueRoaster");
	}
	
	@Override
	public void insertLeagueTeamRoaster(LeagueTeamRoasterDto LeagueTeamRoasterDto) {
		sqlSession.insert("league.insertLeagueRoaster", LeagueTeamRoasterDto);
	}
	
	@Override
	public LeagueTeamRoasterDto selectOneLeagueTeamRoaster(int leagueTeamRoasterNo) {
		LeagueTeamRoasterDto leagueTeamRoasterDto = sqlSession.selectOne("league.findLeagueRoaster", leagueTeamRoasterNo);
		if(leagueTeamRoasterDto==null) throw new NoTargetException();
		return leagueTeamRoasterDto;
	}
	
	@Override
	public void updateLeagueTeamRoaster(int leagueTeamRoasterNo, LeagueTeamRoasterDto leagueTeamRoasterDto) {
		Map<String, Object> param = Map.of("leagueTeamRoasterNo", leagueTeamRoasterNo,"leagueTeamRoasterDto", leagueTeamRoasterDto);
		int result = sqlSession.update("league.updateLeagueRoaster", param);
		if(result==0) throw new NoTargetException();
	}
	
	@Override
	public void deleteLeagueTeamRoaster(int leagueTeamRoasterNo) {
		int result = sqlSession.delete("league.deleteLeagueRoaster", leagueTeamRoasterNo);
		if(result==0) throw new NoTargetException();
	}
	
	@Override
	public int leagueMatchSequence() {
		return sqlSession.selectOne("league.seqLeagueMatch");
	}
	
	@Override
	public void insertLeagueMatch(LeagueMatchDto leagueMatchDto) {
		sqlSession.insert("league.insertLeagueMatch", leagueMatchDto);
	}
	
	@Override
	public LeagueMatchDto selectOneLeagueMatch(int leagueMatchNo) {
		LeagueMatchDto leagueMatchDto = sqlSession.selectOne("league.findLeagueMatch", leagueMatchNo);
		if(leagueMatchDto==null) throw new NoTargetException();
		return leagueMatchDto;
	}
	
	@Override
	public void updateLeagueMatch(int leagueMatchNo, LeagueMatchDto leagueMatchDto) {
		Map<String, Object> param = Map.of("leagueMatchNo", leagueMatchNo,"leagueMatchDto", leagueMatchDto);
		int result = sqlSession.update("league.updateLeagueMatch", param);
		if(result==0) throw new NoTargetException();
	}
	
	@Override
	public void deleteLeagueMatch(int leagueMatchNo) {
		int result = sqlSession.delete("league.deleteLeagueMatch", leagueMatchNo);
		if(result==0) throw new NoTargetException();
	}
	
	@Override
	public List<LeagueTeamDto> listLeagueTeamNonApprove(int leagueNo) {
		return sqlSession.selectList("league.listLeagueTeamNonApprove", leagueNo);
	}
	
	@Override
	public List<LeagueTeamRankListVO> leagueTeamRank(int leagueNo) {
		return sqlSession.selectList("league.listLeagueTeamRank", leagueNo);
	}
	
	@Override
	public boolean updateLeagueTeamStatus(int leagueTeamNo, String status) {
		Map<String, Object> param = Map.of("leagueTeamNo", leagueTeamNo, "status", status);
		sqlSession.update("league.updateLeagueTeamStatus", param);
		return false;
	}
	
	@Override
	public List<LeagueTeamDto> listLeagueTeamByLeague(int leagueNo) {
		return sqlSession.selectList("league.listLeagueTeamByLeague", leagueNo);
	}
	
	@Override
	public List<LeagueMatchDto> selectLeagueMatchList(int leagueNo) {
		return sqlSession.selectList("league.listLeagueMatch", leagueNo);
	}
	
	@Override
	public void leagueTeamCalculate(int leagueTeamNo) {
		sqlSession.update("league.leagueTeamCalculate", leagueTeamNo);
	}
	
	@Override
	public void insertLeagueImage(int leagueNo, int attachNo) {
		Map<String, Object> param = Map.of("leagueNo", leagueNo, "attachNo", attachNo);
		sqlSession.insert("league.insertLeagueImage", param);
	}
	
	@Override
	public List<LeagueDto> selectLeagueDtoList() {
		return sqlSession.selectList("league.listLeagueDto");
	}
	
	@Override
	public List<LeagueMatchListVO> selectLeagueMatchVOList(int leagueNo) {
		return sqlSession.selectList("league.listLeagueMatchListVO", leagueNo);
	}
	
	@Override
	public List<LeagueTeamDto> lsitLeagueTeamApprove(int leagueNo) {
		return sqlSession.selectList("league.listLeagueTeamApprove", leagueNo);
	}
}
