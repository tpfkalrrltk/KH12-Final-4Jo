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

import com.kh.EveryFit.dao.FaqDao;
import com.kh.EveryFit.dto.FaqDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/faq")
@Slf4j
public class FaqController {

	@Autowired
	FaqDao faqDao;

	@RequestMapping("/list")
	public String list(Model model) {
		List<FaqDto> faqList = faqDao.list();
		model.addAttribute("faqList", faqList);
		return "faq/list";
	}

	@GetMapping("/add")
	public String add(HttpSession session) {
		return "faq/add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute FaqDto faqDto, HttpSession session) {
		int faqNo = faqDao.sequence();
		faqDto.setFaqNo(faqNo);
		String memberEmail =  (String) session.getAttribute("name");
		faqDto.setMemberEmail(memberEmail);
		log.debug("faqDto={}",faqDto);
		faqDao.add(faqDto);
		
		return "redirect:list";
	}

	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int faqNo) {
		FaqDto faqDto = faqDao.selectOne(faqNo);
		model.addAttribute("faqDto", faqDto);
		return "/faq/detail";
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam int faqNo) {
		faqDao.delete(faqNo);
		return "redirect:list";
	}

	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int faqNo) {
		FaqDto faqDto = faqDao.selectOne(faqNo);
		model.addAttribute("faqDto", faqDto);
		return "/faq/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute FaqDto faqDto) {
		boolean result = faqDao.edit(faqDto);
		if (result) {
			return "redirect:/faq/detail?";
		} else {
			return "redirect:error";
		}
	}

}
