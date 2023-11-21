package com.kh.EveryFit.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MoimBoardDao;
import com.kh.EveryFit.dao.MoimBoardReplyDao;
import com.kh.EveryFit.dto.MoimBoardReplyDto;
import com.kh.EveryFit.vo.BoardVO;

@RestController
@CrossOrigin
@RequestMapping("/rest/moimBoardReply")
public class MoimBoardReplyRestController {

	@Autowired
	MoimBoardReplyDao moimBoardReplyDao;

	@Autowired
	MoimBoardDao moimBoardDao;

	@PostMapping("/add")
	public void add(HttpSession httpSession, @ModelAttribute MoimBoardReplyDto moimBoardReplyDto) {
		int moimBoardReplyNo = moimBoardReplyDao.sequence();
		moimBoardReplyDto.setMoimBoardReplyNo(moimBoardReplyNo);
		String memberEmail = (String) httpSession.getAttribute("name");
		moimBoardReplyDto.setMemberEmail(memberEmail);
		moimBoardReplyDao.add(moimBoardReplyDto);
		moimBoardDao.updateMoimBoardReplyCount(moimBoardReplyDto.getMoimBoardNo());
	}

	@PostMapping("/list")
	public List<MoimBoardReplyDto> list(@RequestParam int moimBoardNo,
			@ModelAttribute(name = "moimBoardReplyVO") BoardVO boardVO, Model model) {
		List<MoimBoardReplyDto> list = moimBoardReplyDao.list(moimBoardNo);
		model.addAttribute("moimBoardReplyDto", list);
		return list;
	}

	@PostMapping("/edit")
	public void edit(@ModelAttribute MoimBoardReplyDto moimBoardReplyDto) {
		moimBoardReplyDao.update(moimBoardReplyDto);
	}

	@PostMapping("/delete")
	public void delete(@RequestParam int moimBoardReplyNo) {
		MoimBoardReplyDto freeBoardReplyDto = moimBoardReplyDao.selectOne(moimBoardReplyNo);
		moimBoardReplyDao.delete(moimBoardReplyNo);
		moimBoardDao.updateMoimBoardReplyCount(freeBoardReplyDto.getMoimBoardNo());
	}

}
