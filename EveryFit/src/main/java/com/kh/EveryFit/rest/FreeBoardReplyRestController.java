package com.kh.EveryFit.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dao.FreeBoardReplyDao;
import com.kh.EveryFit.dto.FreeBoardReplyDto;

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

}
