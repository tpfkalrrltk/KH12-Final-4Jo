package com.kh.EveryFit.dao;

import java.sql.Date;
import java.util.List;

import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.dto.MoimBoardDto;
import com.kh.EveryFit.vo.BoardVO;

public interface MoimBoardDao {

	List<MoimBoardDto> list();

	void add(MoimBoardDto moimBoardDto);

	boolean delete(int moimBoardNo);

	int sequence();
	
	Date sysdate();

	MoimBoardDto selelctOne(int moimBoardNo);

	List<MoimBoardDto> listByMoimNo(int moimNo);

	List<MoimBoardDto> listByMoimCategory(MoimBoardDto moimBoardDto);

	boolean edit(MoimBoardDto moimBoardDto);

	List<MoimBoardDto> listByMoimNoSortedByCategory(int moimNo, String category);

	boolean updateMoimBoardReplyCount(int moimBoardNo);
	
	
	
	public int countList();

	public int countList(String type, String keyword);
	

	
	public List<MoimBoardDto> selectList(String type,String keyword, int moimNo);


	public List<MoimBoardDto> selectListByPage(String type, String keyword, int page, int moimNo);

	public List<MoimBoardDto> selectListByPage(int page, int moimNo);

	public List<MoimBoardDto> selectListByPage(BoardVO boardVO, int moimNo);
	
	
	
	
	

	public int countList(BoardVO boardVO, int moimNo);

	void connect(int moimBoardNo, int attachNo);

	boolean deleteMoimBoardImage(int moimBoardNo);

	void insertMoimBoardImage(int moimBoardNo, int attachNo);

	Integer findImage(Integer moimBoardNo);

}
