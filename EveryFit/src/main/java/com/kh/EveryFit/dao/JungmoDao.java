package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.vo.JungmoListByMoimNoVO;

public interface JungmoDao {

	int sequence();

	//정모등록
	void insert(JungmoDto jungmoDto);
	void edit(JungmoDto jungmoDto);
	List<JungmoListByMoimNoVO> selectList(int moimNo);

	
}
