package com.kh.EveryFit.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.vo.JungmoListByMoimNoVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/moim")
public class MoimRestController {
	
	@Autowired
	private JungmoDao jungmoDao;
	
	//모임프로필사진 등록/삭제
	//정모프로필사진 등록/삭제
	//모임수정
	
//	//정모 등록
//	@PostMapping("/create")
//	public void create(@ModelAttribute JungmoDto jungmoDto) {
//		//정모등록
//		
//		int jungmoNo = jungmoDao.sequence();
//		jungmoDto.setJungmoNo(jungmoNo);
//			
//		jungmoDao.insert(jungmoDto);
//	}

	//정모 수정
	@PostMapping("/edit")
	public void edit(@ModelAttribute JungmoDto jungmoDto) {
		jungmoDao.edit(jungmoDto);
	}
	//정모 목록
	@PostMapping("/list")
	public List<JungmoListByMoimNoVO> list(@RequestParam int moimNo) {
		return jungmoDao.selectList(moimNo);
	}
}
