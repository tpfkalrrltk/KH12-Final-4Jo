package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;


public interface FreeBoardDao {

	List<FreeBoardDto> list();

	void add(FreeBoardDto freeBoardDto);

	void edit(FreeBoardDto freeBoardDto, int freeBoardNo);

	void edit(int freeBoardNo);

	boolean edit(FreeBoardDto freeBoardDto);

	boolean delete(int freeBoardNo);

	int sequence();

	FreeBoardDto selectOne(int freeBoardNo);
	
	List<FreeBoardDto> list(BoardVO boardVO);
	
	
	
	
	public boolean updateShopAfterReplyCount(int freeBoardNo);

	public int countList();

	public int countList(String type, String keyword);
	
	public List<FreeBoardDto> selectList(String type,String keyword);


	public List<FreeBoardDto> selectListByPage(String type, String keyword, int page);

	public List<FreeBoardDto> selectListByPage(int page);

	public List<FreeBoardDto> selectListByPage(BoardVO boardVO);

	public int countList(BoardVO boardVO);

	void connect(int freeBoardNo, int attachNo);

	AttachDto findImage(int freeBoardNo);
	
	
	


	
	
}
