package com.kh.EveryFit.controller;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.AppealDao;
import com.kh.EveryFit.dto.AppealDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.vo.AdminAppealSearchVO;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/appeal")

public class AppealController {

	@Autowired
	AppealDao appealDao;

	@Autowired
	private FileUploadProperties props;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(props.getHome(), "appeal");
		dir.mkdirs();
	}

	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute("AdminAppealSearchVO") AdminAppealSearchVO adminAppealSearchVO) {
		model.addAttribute("adminAppealList", appealDao.adminAppealSearch(adminAppealSearchVO));

		return "appeal/list";
	}

	@RequestMapping("/detail")
	public String Detail(Model model, @RequestParam int appealNo) {
		model.addAttribute("appealDto", appealDao.Detail(appealNo));

		return "appeal/detail";
	}

	@GetMapping("/add")
	public String add() {

		return "appeal/add";
	}

	@PostMapping("/add")
	public String add(Model model, AppealDto appealDto, HttpSession session) {

		String memberEmail = (String) session.getAttribute("name");
		appealDto.setMemberEmail(memberEmail);
		int appealNo = appealDao.sequence();
		appealDto.setAppealNo(appealNo);
		appealDao.appealApply(appealDto);

		return "redirect:/";
	}

}
