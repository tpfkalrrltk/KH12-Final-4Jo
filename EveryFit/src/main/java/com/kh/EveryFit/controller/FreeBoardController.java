package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.FreeBoardDto;
import com.kh.EveryFit.vo.BoardVO;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
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

	@PostConstruct
	public void init() {
		dir = new File(props.getHome(), "freeBoard");
		dir.mkdirs();

	}

	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute(name = "boardVO") BoardVO boardVO,
			HttpSession session) {

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

		if (!attach.isEmpty()) { // 파일이 있으면
			// 파일 삭제
			Integer findImageNo = freeBoardDao.findImage(freeBoardDto.getFreeBoardNo());

			String home = "C:/upload/kh12fd";
			File dir = new File(home, "freeBoard");
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

			freeBoardDao.connect(freeBoardDto.getFreeBoardNo(), attachNo);// 상품 번호 + 파일 연결
		}

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
		String memberEmail = (String) session.getAttribute("name");
		freeBoardDto.setMemberEmail(memberEmail);
		
		String memberNick = (String) session.getAttribute("nickName");
		freeBoardDto.setMemberNick(memberNick);
		
	
		freeBoardDao.add(freeBoardDto);

		// 첨부파일등록(파일있을때)
		if (!attach.isEmpty()) {
			// 첨부파일등록(파일이 있을때만)
			int attachNo = attachDao.sequence();

			File target = new File(dir, String.valueOf(attachNo)); // 저장할 파일
			attach.transferTo(target);

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			// 연결(파일이 있을때만)
			freeBoardDao.insertFreeBoardImage(freeBoardNo, attachNo);

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

		Integer freeBoardImage = freeBoardDao.findImage(freeBoardNo);
		model.addAttribute("freeBoardImage", freeBoardImage);

		return "freeBoard/detail";
	}

}
