package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.FaqDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.FaqDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/faq")
@Slf4j
public class FaqController {

	@Autowired
	FaqDao faqDao;
	
	@Autowired
	AttachDao attachDao;

	@Autowired
	private FileUploadProperties props;

	private File dir;
	

	@RequestMapping("/list")
	public String list(Model model,
			@ModelAttribute(name = "boardVO") BoardVO boardVO) {
		int count = faqDao.countList(boardVO);
		boardVO.setCount(count);
		
		List<FaqDto> faqList = faqDao.selectListByPage(boardVO);
		model.addAttribute("faqList", faqList);
		return "faq/list";
	}

	@GetMapping("/add")
	public String add(HttpSession session) {
		return "faq/add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute FaqDto faqDto, HttpSession session,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int faqNo = faqDao.sequence();
		faqDto.setFaqNo(faqNo);
		String memberEmail =  (String) session.getAttribute("name");
		faqDto.setMemberEmail(memberEmail);

		faqDao.add(faqDto);
		
		if (!attach.isEmpty()) {
			int attachNo = attachDao.sequence();

			String home = "C:/upload/kh12fd";
			File dir = new File(home, "FAQ");
			dir.mkdirs();
			File target = new File(dir, String.valueOf(attachNo));
			attach.transferTo(target);

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			faqDao.connect(faqNo, attachNo);

		}
		
		
		return "redirect:list";
	}

	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int faqNo) {
		FaqDto faqDto = faqDao.selectOne(faqNo);
		model.addAttribute("faqDto", faqDto);
		
		Integer faqImage = faqDao.findImage(faqNo);
		model.addAttribute("faqImage", faqImage);
		
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
	public String edit(@ModelAttribute FaqDto faqDto,
			@ModelAttribute MultipartFile attach) throws IllegalStateException, IOException {
		boolean result = faqDao.edit(faqDto);
		
		if (!attach.isEmpty()) { // 파일이 있으면
			// 파일 삭제
			Integer findImageNo = faqDao.findImage(faqDto.getFaqNo());
			String home = "C:/upload/kh12fd";
			File dir = new File(home, "FAQ");
			dir.mkdirs();
			if (findImageNo != null) {
				attachDao.delete(findImageNo);

				File target = new File(dir, String.valueOf(findImageNo));
				target.delete();
			}

			// 파일 추가 및 연결
			int attachNo = attachDao.sequence();

			File insertTarget = new File(dir, String.valueOf(attachNo));
			attach.transferTo(insertTarget);

			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(attach.getOriginalFilename());
			insertDto.setAttachSize(attach.getSize());
			insertDto.setAttachType(attach.getContentType());
			attachDao.insert(insertDto);

			faqDao.connect(faqDto.getFaqNo(), attachNo);
		}
		
		
		
		if (result) {
			return "redirect:/faq/detail?faqNo="+faqDto.getFaqNo();
		} else {
			return "redirect:error";
		}
	}

}
