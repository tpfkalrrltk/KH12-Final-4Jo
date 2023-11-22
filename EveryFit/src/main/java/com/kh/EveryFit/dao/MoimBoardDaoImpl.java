package com.kh.EveryFit.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.MoimBoardDto;
import com.kh.EveryFit.vo.BoardVO;

@Repository
public class MoimBoardDaoImpl implements MoimBoardDao {

	@Autowired
	SqlSession sqlSession;
	@Autowired
	JdbcTemplate tem;

	@Override
	public List<MoimBoardDto> list() {

		return sqlSession.selectList("MoimBoard.list");
	}

	@Override
	public void add(MoimBoardDto moimBoardDto) {
		sqlSession.insert("MoimBoard.add", moimBoardDto);

	}

	@Override
	public boolean delete(int moimBoardNo) {
		return sqlSession.delete("MoimBoard.delete", moimBoardNo) > 0;

	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("MoimBoard.sequence");
	}

	@Override
	public MoimBoardDto selelctOne(int moimBoardNo) {
		return sqlSession.selectOne("MoimBoard.selectOne", moimBoardNo);
	}

	@Override
	public List<MoimBoardDto> listByMoimNo(int moimNo) {
		return sqlSession.selectList("MoimBoard.listByMoimNo", moimNo);
	}

	@Override
	public boolean edit(MoimBoardDto moimBoardDto) {
		return sqlSession.update("MoimBoard.edit", moimBoardDto) > 0;
	}

	@Override
	public List<MoimBoardDto> listByMoimCategory(MoimBoardDto moimBoardDto) {
		return sqlSession.selectList("MoimBoard.listByMoimCategory", moimBoardDto);
	}

	@Override
	public List<MoimBoardDto> listByMoimNoSortedByCategory(int moimNo, String category) {
		return sqlSession.selectList("MoimBoard.listByMoimNoSortedByCategory",
				Map.of("moimNo", moimNo, "category", category));
	}

	@Override
	public boolean updateMoimBoardReplyCount(int moimBoardNo) {
		return sqlSession.update("MoimBoard.replyCount", moimBoardNo) > 0;

	}

	@Override
	public int countList(BoardVO boardVO, int moimNo) {
		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			String sql = "select count(*) from moim_board where instr(" + boardVO.getType() + ", ?) > 0 and moim_no = ?";
			Object[] ob = { boardVO.getKeyword() ,moimNo};
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from moim_board where moim_no = ?";
			Object[] ob = {  moimNo };
			return tem.queryForObject(sql, int.class, ob);
		}
	}

	@Override
	public void connect(int moimBoardNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("moimBoardNo", moimBoardNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("MoimBoard.connect", params);

	}

	@Override
	public boolean deleteMoimBoardImage(int moimBoardNo) {
		return sqlSession.delete("MoimBoard.deleteMoimBoardImage", moimBoardNo) > 0;
	}

	@Override
	public void insertMoimBoardImage(int moimBoardNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("moimBoardNo", moimBoardNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("MoimBoard.insertMoimBoardImage", params);

	}

	@Override
	public Integer findImage(Integer moimBoardNo) {
		try {
			return sqlSession.selectOne("MoimBoard.findImage", moimBoardNo);
		} catch (Exception e) {
			return null;
		}
	}

	
	
	
	@Override
	public int countList() {
		String sql = "select count(*) from moim_board";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from moim_board where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}

	
	
	@Override
	public List<MoimBoardDto> selectList(String type, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("keyword", keyword);
		return sqlSession.selectList("MoimBoard.selectList", params);
	}

	@Override
	public List<MoimBoardDto> selectListByPage(String type, String keyword, int page, int moimNo) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Object> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		params.put("type", type);
		params.put("keyword", keyword);
		params.put("moimNo", moimNo);
		return sqlSession.selectList("MoimBoard.selectListBySearchPage", params);
	}

	@Override
	public List<MoimBoardDto> selectListByPage(int page  ,int moimNo) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Integer> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		params.put("moimNo", moimNo);
		return sqlSession.selectList("MoimBoard.selectListByPage", params);
	}

	@Override
	public List<MoimBoardDto> selectListByPage(BoardVO boardVO ,int moimNo) {
		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			return selectListByPage(boardVO.getType(), boardVO.getKeyword(), boardVO.getPage(), moimNo);

		} else {
			return selectListByPage(boardVO.getPage(), moimNo);
		}
	}

	@Override
	public Date sysdate() {
		return sqlSession.selectOne("MoimBoard.sysdate");
	}
	
	

}
