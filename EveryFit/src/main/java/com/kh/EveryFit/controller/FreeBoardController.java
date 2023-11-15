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
import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/freeBoard")
@Slf4j
public class FreeBoardController {

	@Autowired
	FreeBoardDao freeBoardDao;

	@Autowired
	AttachDao attachDao;

	@Autowired
	private FileUploadProperties props;

	private File dir;

	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute(name = "boardVO") BoardVO boardVO) {

		int count = freeBoardDao.countList(boardVO);
		boardVO.setCount(count);

		List<FreeBoardDto> list = freeBoardDao.selectListByPage(boardVO);
		model.addAttribute("FreeBoardList", list);
		return "/freeBoard/list";
	}

	@GetMapping("/edit")
	public String edit(@RequestParam int freeBoardNo, Model model) {
		FreeBoardDto freeBoardDto = freeBoardDao.selectOne(freeBoardNo);
		model.addAttribute("freeBoardDto", freeBoardDto);
		return "/freeBoard/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute FreeBoardDto freeBoardDto, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException {
		boolean result = freeBoardDao.edit(freeBoardDto);

		if (!attach.isEmpty()) {
			AttachDto attachDto = freeBoardDao.findImage(freeBoardDto.getFreeBoardNo());

			if (attachDto != null) {
				attachDao.delete(attachDto.getAttachNo());
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
			}

		}

		int attachNo = attachDao.sequence();
		File target = new File(dir, String.valueOf(attachNo));
		attach.transferTo(target);

		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		attachDao.insert(attachDto);

		freeBoardDao.connect(freeBoardDto.getFreeBoardNo(), attachNo);

		if (result) {
			return "redirect:/freeBoard/detail?freeBoardNo=" + freeBoardDto.getFreeBoardNo();
		} else {
			return "redirect:error";
		}
	}

	@GetMapping("/add")
	public String add() {
		return "/freeBoard/add";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute FreeBoardDto freeBoardDto, HttpSession session,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int freeBoardNo = freeBoardDao.sequence();
		freeBoardDto.setFreeBoardNo(freeBoardNo);
		String memberNickName = (String) session.getAttribute("nickName");
		freeBoardDto.setMemberNick(memberNickName);
		freeBoardDao.add(freeBoardDto);

		if (!attach.isEmpty()) {
			int attachNo = attachDao.sequence();
			File target = new File(dir, String.valueOf(attachNo));
			attach.transferTo(target);

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			freeBoardDao.connect(freeBoardNo, attachNo);

		}

		return "redirect:detail?freeBoardNo=" + freeBoardNo;
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam int freeBoardNo) {
		freeBoardDao.delete(freeBoardNo);
		return "redirect:list";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int freeBoardNo, Model model) {
		FreeBoardDto freeBoardDto = freeBoardDao.selectOne(freeBoardNo);
		model.addAttribute("freeBoardDto", freeBoardDto);
		return "freeBoard/detail";
	}
}
