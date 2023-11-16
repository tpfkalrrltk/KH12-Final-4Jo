package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.FaqDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

@Repository
public class FaqDaoImpl implements FaqDao {

	@Autowired
	SqlSession sqlSession;
	@Autowired
	JdbcTemplate tem;

	@Override
	public List<FaqDto> list() {

		return sqlSession.selectList("FAQ.list");
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("FAQ.sequence");
	}

	@Override
	public void edit(int faqNo, FaqDto faqDto) {
		Map<String, Object> params = new HashMap<>();
		params.put("no", faqNo);
		params.put("faqDto", faqDto);
		sqlSession.update("FAQ.edit", params);

	}

	@Override
	public boolean delete(int faqNo) {
		return sqlSession.delete("FAQ.delete", faqNo) > 0;

	}

	@Override
	public void add(FaqDto faqDto) {
		sqlSession.insert("FAQ.add", faqDto);

	}

	@Override
	public FaqDto selectOne(int faqNo) {

		return sqlSession.selectOne("FAQ.selectOne", faqNo);
	}

	@Override
	public boolean edit(FaqDto faqDto) {
		return sqlSession.update("FAQ.edit", faqDto) > 0;
	}

	@Override
	public boolean updateShopAfterReplyCount(int freeBoardNo) {

		return sqlSession.update("FAQ.replyCount", freeBoardNo) > 0;
	}

	@Override
	public int countList() {

		String sql = "select count(*) from faq";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from faq where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}

	@Override
	public List<FaqDto> selectList(String type, String keyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("keyword", keyword);
		return sqlSession.selectList("FAQ.selectList", params);
	}

	@Override
	public List<FaqDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Object> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		params.put("type", type);
		params.put("keyword", keyword);

		return sqlSession.selectList("FAQ.selectListBySearchPage", params);
	}

	@Override
	public List<FaqDto> selectListByPage(int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		Map<String, Integer> params = new HashMap<>();
		params.put("begin", begin);
		params.put("end", end);
		return sqlSession.selectList("FAQ.selectListByPage", params);
	}

	@Override
	public List<FaqDto> selectListByPage(BoardVO boardVO) {

		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			return selectListByPage(boardVO.getType(), boardVO.getKeyword(), boardVO.getPage());

		} else {
			return selectListByPage(boardVO.getPage());
		}
	}

	@Override
	public int countList(BoardVO boardVO) {
		if (boardVO.getType() != null && boardVO.getKeyword() != null) {
			String sql = "select count(*) from faq where instr(" + boardVO.getType() + ", ?) > 0";
			Object[] ob = { boardVO.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from faq";
			return tem.queryForObject(sql, int.class);
		}
	}
	
	@Override
	public void connect(int faqNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("faqNo", faqNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("FAQ.connect", params);

	}

	@Override
	public Integer findImage(Integer faqNo) {
		try {
			return sqlSession.selectOne("FAQ.findImage", faqNo);
		} 
		catch (Exception e) {
			return null;
		}
			
	}
	
	
	

	@Override
	public boolean deleteFreeBoardImage(int faqNo) {
		return sqlSession.delete("FAQ.deleteFaqImage", faqNo) > 0;
		
	}

	@Override
	public void insertFreeBoardImage(int faqNo, int attachNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("faqNo", faqNo);
		params.put("attachNo", attachNo);
		sqlSession.insert("FAQ.insertFaqImage", params);
		
	}

}
