package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.annotation.PostConstruct;
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
import com.kh.EveryFit.dao.MoimBoardDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.MoimBoardDto;
import com.kh.EveryFit.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/moim/board")
public class MoimBoradController {

	@Autowired
	private MoimBoardDao moimBoardDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileUploadProperties props;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(props.getHome(), "moimBoard");
		dir.mkdirs();

	}
	
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(name = "moimNo") int moimNo,
			@RequestParam(name = "sortByCategory", required = false) String category,
			@ModelAttribute(name = "boardVO") BoardVO boardVO,
			HttpSession session) {

		int count = moimBoardDao.countList(boardVO, moimNo);
		boardVO.setCount(count);
		
		List<MoimBoardDto> boardList;	      

		if (category != null && !category.isEmpty()) {
	        // 카테고리에 따라 정렬된 목록을 가져오는 로직 추가	
	        boardList = moimBoardDao.listByMoimNoSortedByCategory(moimNo, category);

	    } else {
	        // 정렬 없이 전체 목록을 가져오는 로직
	        boardList = moimBoardDao.selectListByPage(boardVO,moimNo);

	    }

	    model.addAttribute("boardList", boardList);
	    return "moimBoard/list";

	}
	
	@RequestMapping("/photoList")
	public String photoList(Model model, @RequestParam(name = "moimNo") int moimNo,
			@RequestParam(name = "sortByCategory", required = false) String category,
			@ModelAttribute(name = "boardVO") BoardVO boardVO,
			HttpSession session) {

		int count = moimBoardDao.countList(boardVO, moimNo);
		boardVO.setCount(count);
		
		List<MoimBoardDto> boardList;	      

		if (category != null && !category.isEmpty()) {
	        // 카테고리에 따라 정렬된 목록을 가져오는 로직 추가	
	        boardList = moimBoardDao.listByMoimNoSortedByCategory(moimNo, category);

	    } else {
	        // 정렬 없이 전체 목록을 가져오는 로직
	        boardList = moimBoardDao.selectListByPage(boardVO,moimNo);

	    }

	    model.addAttribute("boardList", boardList);
	    return "moimBoard/photoList";

	}
	
	@GetMapping("/add")
	public String add(Model model, @RequestParam int moimNo, HttpSession session) {
		return "moimBoard/add";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute MoimBoardDto moimBoardDto, HttpSession session,
			@RequestParam(required = false) MultipartFile attach) throws IllegalStateException, IOException {
		int moimBoardNo = moimBoardDao.sequence();
		String memberEmail = (String) session.getAttribute("name");
		moimBoardDto.setMoimBoardNo(moimBoardNo);
		moimBoardDto.setMemberEmail(memberEmail);
		String memberNick = (String) session.getAttribute("nickName");
		moimBoardDto.setMemberNick(memberNick);

	
		moimBoardDao.add(moimBoardDto);

		
		if (attach != null&&!attach.isEmpty()) {
			int attachNo = attachDao.sequence();

			String home = "C:/upload/kh12fd";
			File dir = new File(home, "moimBoard");
			dir.mkdirs();
			File target = new File(dir, String.valueOf(attachNo));
			attach.transferTo(target);

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			moimBoardDao.connect(moimBoardNo, attachNo);

		}
		
		
		return "redirect:list?moimNo="+moimBoardDto.getMoimNo();
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int moimBoardNo) {
		MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
		model.addAttribute("moimBoardDto", moimBoardDto);
		Integer moimBoardImage = moimBoardDao.findImage(moimBoardNo);
		model.addAttribute("moimBoardImage", moimBoardImage);
		
		return "moimBoard/detail";
	}
	
	@GetMapping("/edit")
		public String edit(Model model, @RequestParam int moimBoardNo) {
			MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
			model.addAttribute("moimBoardDto",moimBoardDto);
			return "moimBoard/edit";
		}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MoimBoardDto moimBoardDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		boolean result = moimBoardDao.edit(moimBoardDto);
		
		
		if (!attach.isEmpty()) { // 파일이 있으면
			// 파일 삭제
			Integer findImageNo = moimBoardDao.findImage(moimBoardDto.getMoimBoardNo());
			
			String home = "C:/upload/kh12fd";
			File dir = new File(home, "moimBoard");
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

			moimBoardDao.connect(moimBoardDto.getMoimBoardNo(), attachNo);// 상품 번호 + 파일 연결
		}
		
		
		if(result) {
			return "redirect:detail?moimBoardNo="+moimBoardDto.getMoimBoardNo();
		}
		else {
			return "redirect:error";
		}
	}
	
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int moimBoardNo) {
		MoimBoardDto moimBoardDto = moimBoardDao.selelctOne(moimBoardNo);
		moimBoardDao.delete(moimBoardDto.getMoimBoardNo());
		return "redirect:list?moimNo="+moimBoardDto.getMoimNo();
	}
}






