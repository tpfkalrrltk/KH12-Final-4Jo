package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.FaqDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

public interface FaqDao {

	List<FaqDto> list();
	int sequence();
	void edit(int faqNo, FaqDto faqDto);
	boolean edit(FaqDto faqDto);
	boolean delete(int faqNo);
	void add(FaqDto faqDto);
	FaqDto selectOne(int faqNo);
	
	public boolean updateShopAfterReplyCount(int freeBoardNo);

	public int countList();

	public int countList(String type, String keyword);
	
	public List<FaqDto> selectList(String type,String keyword);


	public List<FaqDto> selectListByPage(String type, String keyword, int page);

	public List<FaqDto> selectListByPage(int page);

	public List<FaqDto> selectListByPage(BoardVO boardVO);

	public int countList(BoardVO boardVO);
	
	
	
}
