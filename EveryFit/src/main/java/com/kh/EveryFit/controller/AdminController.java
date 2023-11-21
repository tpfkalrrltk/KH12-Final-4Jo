package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

	@Autowired
	AdminDao adminDao;

	@RequestMapping("/member")
	public String member(Model model, @ModelAttribute("adminMemberSearchVO") AdminMemberSearchVO adminMemberSearchVO) {
		model.addAttribute("adminMemberList", adminDao.adminMemberSearch(adminMemberSearchVO));
		return "admin/memberList";
	}

	@RequestMapping("/member/mypage")
	public String memberMypage(String memberEmail, Model model) {
		MemberDto memberDto = adminDao.adminMemberTarget(memberEmail);
		model.addAttribute("adminMemberTarget", memberDto);
		return "admin/mypage";
	}

	@RequestMapping("/moim")
	public String moim(Model model, @ModelAttribute("adminMoimSearchVO") AdminMoimSearchVO adminMoimSearchVO) {

		// model.addAttribute("adminMoimList", adminDao.adminMoimList());
		model.addAttribute("adminMoimList", adminDao.adminMoimSearch(adminMoimSearchVO));
		return "admin/moimList";
	}

	@RequestMapping("/jungmo")
	public String jungmo(Model model, @ModelAttribute("adminJungmoSearchVO") AdminJungmoSearchVO adminJungmoSearchVO) {

		// model.addAttribute("adminJungmoList", adminDao.adminJungmoList());
		model.addAttribute("adminJungmoList", adminDao.adminJungmoSearch(adminJungmoSearchVO));
		return "admin/jungmoList";
	}

	@RequestMapping("/report")
	public String report(Model model, @ModelAttribute("adminReportSearchVO") AdminReportSearchVO adminReportSearchVO) {
		model.addAttribute("adminReportList", adminDao.adminReportSearch(adminReportSearchVO));
		return "admin/reportList";
	}

}
