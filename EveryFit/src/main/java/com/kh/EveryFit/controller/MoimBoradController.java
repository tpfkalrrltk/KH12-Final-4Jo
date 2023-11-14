package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String list(Model model, @RequestParam int moimNo) {
		log.debug("moimNo={}", moimNo);
		List<MoimBoardDto> boardList = moimBoardDao.listByMoimNo(moimNo);
		model.addAttribute("boardList", boardList);
		return "moimBoard/list";
	}
}
