package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.FaqDto;

@Repository
public class FaqDaoImpl implements FaqDao {

	@Autowired
	SqlSession sqlSession;

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
		return sqlSession.delete("FAQ.delete", faqNo)>0;

	}

	@Override
	public void add(FaqDto faqDto) {
		sqlSession.insert("FAQ.add",faqDto);
		
	}

	@Override
	public FaqDto selectOne(int faqNo) {
	
		return sqlSession.selectOne("FAQ.selectOne",faqNo);
	}

	@Override
	public boolean edit(FaqDto faqDto) {
	return sqlSession.update("FAQ.edit",faqDto)>0;
	}
}
