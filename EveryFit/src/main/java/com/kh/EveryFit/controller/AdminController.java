package com.kh.EveryFit.controller;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminDao adminDao;
	@Autowired
	MemberDao memberDao;


	@Autowired
	private FileUploadProperties props;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(props.getHome(), "report");
		dir.mkdirs();
	}

	@RequestMapping("/member")
	public String member(Model model, @ModelAttribute("adminMemberSearchVO") AdminMemberSearchVO adminMemberSearchVO) {
		model.addAttribute("adminMemberList", adminDao.adminMemberSearch(adminMemberSearchVO));
		return "admin/memberList";
	}

	@RequestMapping("/member/mypage")
	public String memberMypage(String memberEmail, Model model) {
		MemberDto memberDto = adminDao.adminMemberTarget(memberEmail);
		model.addAttribute("adminMemberTarget", memberDto);
		model.addAttribute("profile", memberDao.findProfile(memberEmail));
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

	@RequestMapping("/member/block")
	public String memberBlock(@RequestParam String memberEmail) {
		adminDao.insertBlock(memberEmail);
		return "redirect:/admin/member";
	}

	@RequestMapping("/member/cancel")
	public String memberCancel(@RequestParam String memberEmail) {
		adminDao.deleteBlock(memberEmail);
		return "redirect:/admin/member";
	}

	@RequestMapping("/report/detail")
	public String reportDetail(Model model, @RequestParam int reportNo) {
		model.addAttribute("reportDto", adminDao.reportDetail(reportNo));

		Integer reportImage = adminDao.findReportImage(reportNo);

		model.addAttribute("reportImage", reportImage);

		return "report/detail";
	}
	


}
