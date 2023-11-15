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

import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dao.FreeBoardReplyDao;
import com.kh.EveryFit.dto.FreeBoardReplyDto;
import com.kh.EveryFit.vo.BoardVO;

@RestController
@CrossOrigin
@RequestMapping("/rest/freeBoardReply")
public class FreeBoardReplyRestController {

	@Autowired
	FreeBoardReplyDao freeBoardReplyDao;

	@Autowired
	FreeBoardDao freeBoardDao;

	@PostMapping("/add")
	public void add(HttpSession httpSession, @ModelAttribute FreeBoardReplyDto freeBoardReplyDto) {
		int freeBoardReplyNo = freeBoardReplyDao.sequence();
		freeBoardReplyDto.setFreeBoardReplyNo(freeBoardReplyNo);
		String memberEmail = (String) httpSession.getAttribute("name");
		freeBoardReplyDto.setMemberEmail(memberEmail);
		freeBoardReplyDao.add(freeBoardReplyDto);
		freeBoardDao.updateShopAfterReplyCount(freeBoardReplyDto.getFreeBoardNo());
	}

	@PostMapping("/list")
	public List<FreeBoardReplyDto> list(@RequestParam int freeBoardNo,
			@ModelAttribute(name = "freeBoardReplyVO") BoardVO boardVO, Model model) {
		List<FreeBoardReplyDto> list = freeBoardReplyDao.list();
		model.addAttribute("freeBoardReplyDto", list);
		return list;
	}

	@PostMapping("/edit")
	public void edit(@ModelAttribute FreeBoardReplyDto freeBoardReplyDto) {
		freeBoardReplyDao.update(freeBoardReplyDto);
	}

	@PostMapping("/delete")
	public void delete(@RequestParam int freeBoardReplyNo) {
		FreeBoardReplyDto freeBoardReplyDto = freeBoardReplyDao.selectOne(freeBoardReplyNo);
		freeBoardReplyDao.delete(freeBoardReplyNo);
		freeBoardDao.updateShopAfterReplyCount(freeBoardReplyDto.getFreeBoardNo());
	}

}
