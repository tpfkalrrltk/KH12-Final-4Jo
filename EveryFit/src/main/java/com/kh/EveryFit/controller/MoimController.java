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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.MoimMemberStatusVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/moim")
public class MoimController {

	@Autowired private MoimDao moimDao;
	@Autowired private MemberDao memberDao;
	@Autowired private JungmoDao jungmoDao;
	@Autowired private AttachDao attachDao;	
	@Autowired private ChatDao chatDao;
	
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
			@RequestParam MultipartFile attach, HttpSession session) throws IllegalStateException, IOException {
		int moimNo = moimDao.sequence();
		moimDto.setMoimNo(moimNo);
		
		
		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
		int chatRoomNo = chatDao.sequence();
		log.debug("chatRoomNo");
		
		String memberEmail = (String)session.getAttribute("name");
		chatDao.insertChatRoom(chatRoomNo);
		//moimDto.setChatRoomNo에 넣기
		moimDto.setChatRoomNo(chatRoomNo);

		moimDao.insert(moimDto);
		//채팅참가자 추가
		chatDao.addChatMember(chatRoomNo, memberEmail);
		//모임등록한 사람의 아이디를 moim_member 테이블에 insert 하기!
		moimDao.addMoimJang(moimNo, memberEmail);
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
//		//정모 목록
//		model.addAttribute("jungmoList", jungmoDao.selectList(moimNo));		
		//정모목록
		model.addAttribute("jungmoTotalList", jungmoDao.selectTotalList(moimNo));
		
		return "moim/detail";
		
	}
	
	@RequestMapping("/edit")
	public String edit(Model model, @RequestParam int moimNo) {
		MoimDto moimDto = moimDao.selectOne(moimNo);
		model.addAttribute("moimDto", moimDto);
		Integer profile = moimDao.findMoimProfile(moimNo);
		model.addAttribute("profile", profile);
		List<LocationDto> locationList = memberDao.selectLocationList(); //지역조회
		model.addAttribute("locationList", locationList);
		List<EventDto> eventList = memberDao.selectEventList(); //종목조회
		model.addAttribute("eventList", eventList);
		return "moim/create";
	}
	
	//모임멤버차단
	@RequestMapping("/memberBlock")
	public String memberBlock(@RequestParam String memberEmail,
							@RequestParam int moimNo, RedirectAttributes redirectAttributes) {
		MoimMemberStatusVO vo = new MoimMemberStatusVO();
		vo.setMemberBlock("memberBlock");
		vo.setMemberEmail(memberEmail);
		vo.setMoimNo(moimNo);
		moimDao.updateMoimMember(vo);
		redirectAttributes.addAttribute("block", true);
		return "redirect:detail?moimNo="+moimNo;
	}
	
	//모임멤버레벨확인
	@RequestMapping("/memberApproval")
	public String memberApproval(@RequestParam String memberEmail,
					@RequestParam int moimNo, RedirectAttributes redirectAttributes) {
		MoimMemberStatusVO vo = new MoimMemberStatusVO();
		vo.setMemberApproval("memberApproval");
		vo.setMemberEmail(memberEmail);
		vo.setMoimNo(moimNo);
		moimDao.updateMoimMember(vo);
		redirectAttributes.addAttribute("approval", true);
		return "redirect:detail?moimNo="+moimNo;
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
	
	//정모 참가
	@RequestMapping("/jungmo/join")
	public String jungmoJoin(@RequestParam String memberEmail,
				@RequestParam int jungmoNo, RedirectAttributes redirectAttributes) {
		//insert 하기 전에 해야 할 일
		//[1] 이미 참가한 회원인지 검색
		//[2] 정원이 가득 찼는지 검색
		//정모 조회
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		//해당정모의 정모멤버 카운트와 정모Dto의 정원 수 비교
		int count = jungmoDao.selectOneJungmoMemberCount(jungmoNo);
		//만약 등록된 회원 수가 정원보다 같거나 많으면
		if(count >= jungmoDto.getJungmoCapacity()) {
			redirectAttributes.addAttribute("errorFlag", true);
	        return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
		}
		
		String memberCheck = jungmoDao.selectMemberEmail(memberEmail, jungmoNo);
		if(memberCheck == null) {
			jungmoDao.memberJoin(memberEmail, jungmoNo);			
		}
		else {
			redirectAttributes.addAttribute("errorFlag", true);
	        return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
		}
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	
	//정모참가취소
	@RequestMapping("/jungmo/exit")
	public String jungmoDelete(@RequestParam String memberEmail,
			@RequestParam int jungmoNo) {
		jungmoDao.deleteJungmoMember(memberEmail, jungmoNo);
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	
	//정모수정
	@RequestMapping("/jungmo/edit")
	public String jungmoEdit(@RequestParam int jungmoNo, Model model) {
		model.addAttribute("jungmoDto", jungmoDao.selectOneByJungmoNo(jungmoNo));
		return "/moim/jungmoCreate";
	}
	
	//정모취소(일정취소)
	@RequestMapping("/jungmo/cancel")
	public String jungmoCancel(@RequestParam int jungmoNo) {
		jungmoDao.cancel(jungmoNo);
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	

	
}
