package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dto.FreeBoardDto;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {

	@Autowired
	FreeBoardDao freeBoardDao;

	@RequestMapping("/list")
	public String list(Model model) {

		List<FreeBoardDto> list = freeBoardDao.list();
		model.addAttribute("FreeBoardList", list);
		return "/freeBoard/list";
	}

	@GetMapping("edit")
	public String edit(int freeBoardNo, Model model) {
	//	FreeBoardDto freeBoardDto = freeBoardDao.edit(freeBoardNo);
	//	model.addAttribute("freeBoardDto",freeBoardDto );
		return "/freeBoard/edit";
	}

	@PostMapping("edit")
	public String edit() {

		return "redirect:/freeBoard/detail";
	}
}
