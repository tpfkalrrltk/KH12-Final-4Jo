package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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
import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/moim")
public class MoimController {

	@Autowired private MoimDao moimDao;
	@Autowired private MemberDao memberDao;
	@Autowired private JungmoDao jungmoDao;
	@Autowired private AttachDao attachDao;	
	
	@GetMapping("/create")
	public String create(Model model) {
		List<LocationDto> locationList = memberDao.selectLocationList(); //지역조회
		model.addAttribute("locationList", locationList);
		List<EventDto> eventList = memberDao.selectEventList(); //종목조회
		model.addAttribute("eventList", eventList);
		return "moim/create";
	}
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	@PostMapping("/create")
	public String create(@ModelAttribute MoimDto moimDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int moimNo = moimDao.sequence();
		moimDto.setMoimNo(moimNo);
		moimDao.insert(moimDto);
		
		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
		//moimDto.setChatRoomNo에 넣기
		//모임등록한 사람의 아이디를 moim_member 테이블에 insert 하기!
		//모임등록한사람의 등급은 모임장으로 하자
		
		//첨부파일등록(파일있을때)
		if(!attach.isEmpty()) {
			//첨부파일등록(파일이 있을때만)
			int attachNo = attachDao.sequence();

			File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
			attach.transferTo(target);
			

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			//연결(파일이 있을때만)
			moimDao.insertMoimProfile(moimNo, attachNo);			
		}
		
		return "redirect:detail?moimNo="+moimNo;
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int moimNo,
			HttpSession session) {
		//모임상세
		MoimDto moimDto = moimDao.selectOne(moimNo);
		model.addAttribute("moimDto", moimDto);
		//회원목록(moim_member)
		model.addAttribute("memberList", moimDao.selectAllMoimMembers(moimNo));
		//모임지역
		LocationDto locationDto = memberDao.selectOneByLocationNo(moimDto.getLocationNo());
		model.addAttribute("locationDto", locationDto);
		//모임종목
		EventDto eventDto = memberDao.selectOneByEventNo(moimDto.getEventNo());
		model.addAttribute("eventDto", eventDto);
		//모임이미지
		Integer profile = moimDao.findMoimProfile(moimNo);
		model.addAttribute("profile", profile);
		log.debug("profile={}", profile);
		
		
		return "moim/detail";
		
	}
	
	@GetMapping("/jungmo/create")
	public String jungmoCreate(@RequestParam int moimNo) {
		return "moim/jungmoCreate";
	}
	
	@PostMapping("/jungmo/create")
	public String jungmoCreate(
			@ModelAttribute JungmoDto jungmoDto, 
			@RequestParam MultipartFile attach,
			@RequestParam("jungmoDto.jungmoScheduleStr") String jungmoScheduleStr) throws IllegalStateException, IOException {

		String subStrJungmoSchedule = jungmoScheduleStr.substring(0, 10);
		
		int jungmoNo = jungmoDao.sequence();
		jungmoDto.setJungmoNo(jungmoNo);
		
		
		try {
	        // 문자열을 LocalDateTime으로 파싱
	        LocalDateTime localDateTime = LocalDateTime.parse(jungmoScheduleStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));

	        // LocalDateTime을 java.sql.Timestamp으로 변환
	        java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(localDateTime);

	        jungmoDto.setJungmoSchedule(timestamp);
	    } catch (DateTimeParseException e) {
	        // 예외 처리 로직 추가
	    }
		
		jungmoDao.insert(jungmoDto);
		
		//첨부파일등록(파일있을때)
		if(!attach.isEmpty()) {
			//첨부파일등록(파일이 있을때만)
			int attachNo = attachDao.sequence();

			File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
			attach.transferTo(target);
			

			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			//연결(파일이 있을때만)
			moimDao.insertJungmoProfile(jungmoNo, attachNo);
		}
		
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	
	
	
}
