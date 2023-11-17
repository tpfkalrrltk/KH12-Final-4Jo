package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

	@Autowired
	AdminDao adminDao;

	@RequestMapping("/member")
	public String member(Model model) {
		List<MemberDto>  adminMemberList = adminDao.adminMemberList();
		model.addAttribute("adminMemberList", adminMemberList);
		return "admin/memberList";
	}
	@RequestMapping("/member/mypage")
	public String memberMypage(String memberEmail,
			Model model) {
		MemberDto memberDto = adminDao.adminMemberTarget(memberEmail);
		model.addAttribute("adminMemberTarget",memberDto);
		return "admin/mypage";
	}
}
