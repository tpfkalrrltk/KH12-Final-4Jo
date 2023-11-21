package com.kh.EveryFit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.MoimBoardDao;
import com.kh.EveryFit.dto.MoimBoardDto;


import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/moim/board")
public class MoimBoradController {

	@Autowired
	private MoimBoardDao moimBoardDao;
	
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(name = "moimNo") int moimNo,
			@RequestParam(name = "sortByCategory", required = false) String category) {

		List<MoimBoardDto> boardList;
		if (category != null && !category.isEmpty()) {
	        // 카테고리에 따라 정렬된 목록을 가져오는 로직 추가	
	        boardList = moimBoardDao.listByMoimNoSortedByCategory(moimNo, category);
	    } else {
	        // 정렬 없이 전체 목록을 가져오는 로직
	        boardList = moimBoardDao.listByMoimNo(moimNo);
	    }

	    model.addAttribute("boardList", boardList);
	    return "moimBoard/list";
	    //return "moimBoard/boardTable"; // 수정된 부분
		
		//log.debug("moimNo={}", moimNo);
		//List<MoimBoardDto> boardList = moimBoardDao.listByMoimNo(moimNo);
		//model.addAttribute("boardList", boardList);
		//return "moimBoard/list";
	}
	
	@GetMapping("/add")
	public String add(Model model, @RequestParam int moimNo, HttpSession session) {
		return "moimBoard/add";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute MoimBoardDto moimBoardDto, HttpSession session) {
		int moimBoardNo = moimBoardDao.sequence();
		String memberEmail = (String) session.getAttribute("name");
		moimBoardDto.setMoimBoardNo(moimBoardNo);
		moimBoardDto.setMemberEmail(memberEmail);
		//log.debug("moimBoardDto={}", moimBoardDto);
		moimBoardDao.add(moimBoardDto);
		return "redirect:list?moimNo="+moimBoardDto.getMoimNo();
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int moimBoardNo) {
		MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
		model.addAttribute("moimBoardDto", moimBoardDto);
		return "moimBoard/detail";
	}
	
	@GetMapping("/edit")
		public String edit(Model model, @RequestParam int moimBoardNo) {
			MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
			model.addAttribute("moimBoardDto",moimBoardDto);
			return "moimBoard/edit";
		}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MoimBoardDto moimBoardDto) {
		boolean result = moimBoardDao.edit(moimBoardDto);
		if(result) {
			return "redirect:detail?moimBoardNo="+moimBoardDto.getMoimBoardNo();
		}
		else {
			return "redirect:error";
		}
	}
	@RequestMapping("/delete")
	public String delete(@RequestParam int moimBoardNo) {
		MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
		moimBoardDao.delete(moimBoardDto.getMoimBoardNo());
		return "redirect:list?moimNo="+moimBoardDto.getMoimNo();
	}
}






