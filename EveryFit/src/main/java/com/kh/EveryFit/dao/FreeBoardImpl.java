package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Repository
public class FreeBoardImpl implements FreeBoardDao {

	@Autowired
	SqlSession sqlSession;

	@Autowired
	JdbcTemplate tem;

	@Override
	public List<FreeBoardDto> list() {

		return sqlSession.selectList("freeBoard.list");
	}

	@Override
	public void add(FreeBoardDto freeBoardDto) {

		sqlSession.insert("freeBoard.add", freeBoardDto);

	}

	@Override
	public void edit(FreeBoardDto freeBoardDto, int freeBoardNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("freeBoardDto", freeBoardDto);
		params.put("no", freeBoardNo);
		sqlSession.update("freeBoard.edit", params);

	}

	@Override
	public boolean delete(int freeBoardNo) {
		return sqlSession.delete("freeBoard.delete", freeBoardNo) > 0;

	}

	@Override
	public int sequence() {

		return sqlSession.selectOne("freeBoard.sequence");
	}

	@Override
	public FreeBoardDto selectOne(int freeBoardNo) {

		return sqlSession.selectOne("freeBoard.selectOne", freeBoardNo);
	}

	@Override
	public void edit(int freeBoardNo) {
		sqlSession.update("freeBoard.edit", freeBoardNo);

	}

	@Override
	public boolean edit(FreeBoardDto freeBoardDto) {
		return sqlSession.update("freeBoard.edit", freeBoardDto) > 0;

	}

	@Override
	public List<FreeBoardDto> list(BoardVO boardVO) {

		return sqlSession.selectList("freeBoard.list");
	}

	@Override
	public boolean updateFreeBoardReplyCount(int freeBoardNo) {

		return sqlSession.update("freeBoard.replyCount", freeBoardNo) > 0;
	}

	@Override
	public int countList() {

		String sql = "select count(*) from free_board";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from free_board where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}

	@Override
	public List<FreeBoardDto> selectList(String type, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("keyword", keyword);
		return sqlSession.selectList("freeBoard.selectList", params);
	}

	@Override
	public List<FreeBoardDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Object> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		params.put("type", type);
		params.put("keyword", keyword);

		return sqlSession.selectList("freeBoard.selectListBySearchPage", params);
	}

	@Override
	public List<FreeBoardDto> selectListByPage(int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Integer> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		return sqlSession.selectList("freeBoard.selectListByPage", params);
	}

	@Override
	public List<FreeBoardDto> selectListByPage(BoardVO boardVO) {

		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			return selectListByPage(boardVO.getType(), boardVO.getKeyword(), boardVO.getPage());

		} else {
			return selectListByPage(boardVO.getPage());
		}
	}

	@Override
	public int countList(BoardVO boardVO) {
		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			String sql = "select count(*) from free_board where instr(" + boardVO.getType() + ", ?) > 0";
			Object[] ob = { boardVO.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from free_board";
			return tem.queryForObject(sql, int.class);
		}
	}

	@Override
	public void connect(int freeBoardNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("freeBoardNo", freeBoardNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("freeBoard.connect", params);

	}

	@Override
	public Integer findImage(Integer freeBoardNo) {
		try {
			return sqlSession.selectOne("freeBoard.findImage", freeBoardNo);
		} 
		catch (Exception e) {
			return null;
		}
			
	}

	@Override
	public boolean deleteFreeBoardImage(int freeBoardNo) {
		return sqlSession.delete("freeBoard.deleteFreeBoardImage", freeBoardNo) > 0;
	}

	@Override
	public void insertFreeBoardImage(int freeBoardNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("freeBoardNo", freeBoardNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("freeBoard.insertFreeBoardImage", params);

	}

}
