package com.kh.EveryFit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dto.ReportDto;

@Controller
@RequestMapping("/report")
public class ReportController {

	@Autowired
	AdminDao adminDao;

	@GetMapping("/apply")
	public String apply() {
		return "report/apply";
	}

	@PostMapping("/apply")
	public String apply(@ModelAttribute ReportDto reportDto) {
		int reportNo = adminDao.sequence();
		reportDto.setReportNo(reportNo);
		adminDao.reportApply(reportDto);

		return "redirect:/";
	}

}
