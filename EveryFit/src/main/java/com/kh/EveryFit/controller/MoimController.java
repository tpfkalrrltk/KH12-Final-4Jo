package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;
import com.kh.EveryFit.dto.MoimStateDto;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.JungmoMemberListVO;
import com.kh.EveryFit.vo.JungmoStatusVO;
import com.kh.EveryFit.vo.JungmoWithMembersVO;
import com.kh.EveryFit.vo.MoimMemberStatusVO;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/moim")
public class MoimController {

	@Autowired private MoimDao moimDao;
	@Autowired private MemberDao memberDao;
	@Autowired private JungmoDao jungmoDao;
	@Autowired private AttachDao attachDao;	
	@Autowired private ChatDao chatDao;
	@Autowired private LeagueDao leagueDao;
	
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
			@RequestParam MultipartFile attach, HttpSession session,
			RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {	
		
		String memberEmail = (String)session.getAttribute("name");
		//회원이 모임장인 모임 개수 조회(하나임)
//		if(moimDao.selectAllMoimNo(memberEmail) != null) {
//			redirectAttributes.addAttribute("full", true);
//			return "redirect:/";
//		}
		
		int moimNo = moimDao.sequence();
		moimDto.setMoimNo(moimNo);

		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
		int chatRoomNo = chatDao.sequence();
		
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
		//회원목록(모임장이 보는 회원목록)
		model.addAttribute("memberListForMoimJang", moimDao.selectAllMoimMembersForMoimJang(moimNo));
		//모임지역
		LocationDto locationDto = memberDao.selectOneByLocationNo(moimDto.getLocationNo());
		model.addAttribute("locationDto", locationDto);
		//모임종목
		EventDto eventDto = memberDao.selectOneByEventNo(moimDto.getEventNo());
		model.addAttribute("eventDto", eventDto);
		//모임이미지
		Integer profile = moimDao.findMoimProfile(moimNo);
		model.addAttribute("profile", profile);
		//모임회원수
		Integer memberCount = moimDao.findMoimMemberCount(moimNo);
		model.addAttribute("memberCount", memberCount);
		
		//참여중인 리그
		List<LeagueDto> leagueList = leagueDao.listLeagueBymoimNo(moimNo);
		if(leagueList.size()>0) model.addAttribute("leagueList", leagueList);
		
		
//		//정모 목록
//		model.addAttribute("jungmoList", jungmoDao.selectList(moimNo));		
		//정모목록
		List<JungmoWithMembersVO> jungmoTotalList = jungmoDao.selectTotalList(moimNo);
	    for (JungmoWithMembersVO jungmoWithMembersVO : jungmoTotalList) {
	        jungmoWithMembersVO.calculateDdays();
	    }
	    model.addAttribute("jungmoTotalList", jungmoTotalList);
		return "moim/detail";
		
	}
	
//	@RequestMapping("/edit")
//	public String edit(Model model, @RequestParam int moimNo) {
//		MoimDto moimDto = moimDao.selectOne(moimNo);
//		model.addAttribute("moimDto", moimDto);
//		Integer profile = moimDao.findMoimProfile(moimNo);
//		model.addAttribute("profile", profile);
//		List<LocationDto> locationList = memberDao.selectLocationList(); //지역조회
//		model.addAttribute("locationList", locationList);
//		List<EventDto> eventList = memberDao.selectEventList(); //종목조회
//		model.addAttribute("eventList", eventList);
//		return "moim/create";
//	}
	
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
	
	//모임장 권한 넘기기
	@RequestMapping("/memberTransfer")
	public String memberTransfer(@RequestParam String memberEmail, HttpSession session,
				@RequestParam int moimNo, RedirectAttributes redirectAttributes) {
	
		String moimJangMemberEmail = (String) session.getAttribute("name");
		
		Integer moimJangCount = moimDao.findMoimJangCount(moimNo);
		//모임장이 한명이면 
		if(moimJangCount == 1) {
			MoimMemberStatusVO vo = new MoimMemberStatusVO();
			vo.setMemberTransfer("memberTransfer");
			vo.setMemberEmail(memberEmail);
			vo.setMoimNo(moimNo);
			moimDao.updateMoimMember(vo);
			redirectAttributes.addAttribute("transfer", true);			
			
			MoimMemberStatusVO vo2 = new MoimMemberStatusVO();
			vo2.setMemberTransferManager("memberTransferManager");
			vo2.setMemberEmail(moimJangMemberEmail);
			vo2.setMoimNo(moimNo);
			moimDao.updateMoimMember(vo2);
		}			
		return "redirect:detail?moimNo="+moimNo;
	}

	@RequestMapping("/memberManager")
	public String memberManager(@RequestParam String memberEmail,
			@RequestParam int moimNo, RedirectAttributes redirectAttributes) {
		MoimMemberStatusVO vo = new MoimMemberStatusVO();
		vo.setMemberTransferManager("memberTransferManager");
		vo.setMemberEmail(memberEmail);
		vo.setMoimNo(moimNo);
		moimDao.updateMoimMember(vo);
		redirectAttributes.addAttribute("manager", true);
		return "redirect:detail?moimNo="+moimNo;
	}

	
	@RequestMapping("/member/exit")
	public String memberExit(@RequestParam int moimNo,
			HttpSession session, RedirectAttributes redirectAttributes) {
		String memberEmail = (String)session.getAttribute("name");
		
		MoimMemberDto findMemberDto = moimDao.findMoimMemberInfo(memberEmail, moimNo);
		Integer moimMemberCount = moimDao.findMoimJangCount(moimNo);
		//만약 모임장이면 
		//회원수 카운트세서 상태변경
		int count = moimDao.findMoimMemberCount(moimNo);
		if(findMemberDto.getMoimMemberLevel().equals("모임장") && count != 1) {
			redirectAttributes.addAttribute("exitError", true);	
			return "redirect:/moim/detail?moimNo="+moimNo;				
		}
		
		MoimMemberDto moimMemberDto = new MoimMemberDto();
		moimMemberDto.setMoimNo(moimNo);
		moimMemberDto.setMemberEmail(memberEmail);
		
		moimDao.deleteMoimMember(moimMemberDto);
		//채팅방에서도 내쫓기
		MoimDto moimDto = moimDao.selectOne(moimNo);
		chatDao.deleteChatMember(moimDto.getChatRoomNo(), memberEmail);
    	
		MoimStateDto moimStateDto = new MoimStateDto();
	    if(moimDto.getMoimMemberCount() == count) {
		    moimStateDto.setOver(true);
	    }
	    else if(count == 0) {
	    	moimStateDto.setZero(true);
	    }
	    else {
	    	moimStateDto.setOver(false);
	    }
	    moimStateDto.setMoimNo(moimNo);
	    moimDao.updateMoimState(moimStateDto);	    	
	    
		return "redirect:/";
	}
	
	@GetMapping("/jungmo/create")
	public String jungmoCreate(@RequestParam int moimNo, Model model) {
	    model.addAttribute("keepModalAndReturn", true);
	    model.addAttribute("redirectUrl", "/moim/detail?moimNo=" + moimNo);
		return "redirect:detail?moimNo="+moimNo;
	}
	
//	@RequestMapping(value = "/jungmo/create", method = RequestMethod.POST)
//	public String jungmoCreate(
//			@ModelAttribute JungmoDto jungmoDto, 
//			@RequestParam MultipartFile attach,
//			@RequestParam("jungmoDto.jungmoScheduleStr") String jungmoScheduleStr,
//			HttpSession session) throws IllegalStateException, IOException {
//
//		String subStrJungmoSchedule = jungmoScheduleStr.substring(0, 10);
//		
//		int jungmoNo = jungmoDao.sequence();
//		jungmoDto.setJungmoNo(jungmoNo);
//		
//		try {
//	        // 문자열을 LocalDateTime으로 파싱
//	        LocalDateTime localDateTime = LocalDateTime.parse(jungmoScheduleStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
//
//	        // LocalDateTime을 java.sql.Timestamp으로 변환
//	        java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(localDateTime);
//
//	        jungmoDto.setJungmoSchedule(timestamp);
//	    } catch (DateTimeParseException e) {
//	        // 예외 처리 로직 추가
//	    }
//		
//		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
//		int chatRoomNo = chatDao.sequence();
//		log.debug("chatRoomNo");
//		
//		String memberEmail = (String)session.getAttribute("name");
//		chatDao.insertChatRoom(chatRoomNo);
//		jungmoDto.setChatRoomNo(chatRoomNo);
//		jungmoDao.insert(jungmoDto);
//
//		//채팅참가자 추가(추가할필요가없음)
////		chatDao.addChatMember(chatRoomNo, memberEmail);
//				
//		//첨부파일등록(파일있을때)
//		if(!attach.isEmpty()) {
//			//첨부파일등록(파일이 있을때만)
//			int attachNo = attachDao.sequence();
//
//			File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
//			attach.transferTo(target);
//			
//
//			AttachDto attachDto = new AttachDto();
//			attachDto.setAttachNo(attachNo);
//			attachDto.setAttachName(attach.getOriginalFilename());
//			attachDto.setAttachSize(attach.getSize());
//			attachDto.setAttachType(attach.getContentType());
//			attachDao.insert(attachDto);
//
//			//연결(파일이 있을때만)
//			moimDao.insertJungmoProfile(jungmoNo, attachNo);
//		}
//		
//		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
//	}
	
	//정모 참가
	@RequestMapping("/jungmo/join")
	public String jungmoJoin(@RequestParam String memberEmail,
				@RequestParam int jungmoNo, RedirectAttributes redirectAttributes) {
		//insert 하기 전에 해야 할 일
		//[1] 이미 참가한 회원인지 검색
		//[2] 정원이 가득 찼는지 검색
		//정모 조회
		int count = 0;
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		//해당정모의 정모멤버 카운트와 정모Dto의 정원 수 비교
		count = jungmoDao.selectOneJungmoMemberCount(jungmoNo);
		//만약 등록된 회원 수가 정원보다 같거나 많으면
		if(count == jungmoDto.getJungmoCapacity()) {
			redirectAttributes.addAttribute("errorFlag", true);			
	        return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
		}
		
		String memberCheck = jungmoDao.selectMemberEmail(memberEmail, jungmoNo);
		if(memberCheck == null) {
			jungmoDao.memberJoin(memberEmail, jungmoNo);			
			count = jungmoDao.selectOneJungmoMemberCount(jungmoNo);
			//인원마감으로 상태변경!
			if(count == jungmoDto.getJungmoCapacity()) {
			JungmoStatusVO vo = new JungmoStatusVO();	
			vo.setOver(true);
			vo.setJungmoNo(jungmoNo);
			jungmoDao.updateJungmoStatus(vo);
			
			//채팅방에 강제참여
			chatDao.addChatMember(jungmoDto.getChatRoomNo(), memberEmail);
			}
		}
		else {
			redirectAttributes.addAttribute("errorFlag2", true);
	        return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
		}
		
		chatDao.addChatMember(jungmoDto.getChatRoomNo(), memberEmail);
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	
	//정모참가취소
	@RequestMapping("/jungmo/exit")
	public String jungmoDelete(@RequestParam String memberEmail,
			@RequestParam int jungmoNo) {
		jungmoDao.deleteJungmoMember(memberEmail, jungmoNo);
		//채팅방에서 내쫓기
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		chatDao.deleteChatMember(jungmoDto.getChatRoomNo(), memberEmail);
        // 현재 날짜를 가져오기
        LocalDate currentDate = LocalDate.now();

        // Timestamp를 LocalDate로 변환
        Timestamp jungmoScheduleTimestamp = jungmoDto.getJungmoSchedule();
        LocalDateTime jungmoScheduleLocalDateTime = jungmoScheduleTimestamp.toLocalDateTime();
        LocalDate jungmoScheduleLocalDate = jungmoScheduleLocalDateTime.toLocalDate();
		
		if(currentDate.equals(jungmoScheduleLocalDate)) {
			MoimMemberStatusVO vo = new MoimMemberStatusVO();
			vo.setMemberCancel("memberCancel");
			vo.setMemberEmail(memberEmail);
			vo.setMoimNo(jungmoDto.getMoimNo());
			moimDao.updateMoimMember(vo);	
		}
		
		JungmoStatusVO vo = new JungmoStatusVO();
		//정모회원수를센다
		int count = jungmoDao.selectOneJungmoMemberCount(jungmoNo);
		//회원수가 인원마감수보다 적으면 상태변경
		if(count < jungmoDto.getJungmoCapacity()) {
			vo.setOver(false);
			vo.setJungmoNo(jungmoNo);
			jungmoDao.updateJungmoStatus(vo);
		}
		else {
			vo.setOver(true);
			vo.setJungmoNo(jungmoNo);
			jungmoDao.updateJungmoStatus(vo);
			
		}
		
		
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
		
		//채팅참여자들 다 내쫓기
		List<JungmoMemberListVO> list = jungmoDao.selectListByJungmoNo(jungmoNo);
		for (JungmoMemberListVO member : list) {
		    String memberEmail = member.getMemberEmail(); 
		    chatDao.deleteChatMember(jungmoDto.getChatRoomNo(), memberEmail);
		}
		
		return "redirect:/moim/detail?moimNo=" + jungmoDto.getMoimNo();
	}
	
	//모임삭제
	@RequestMapping("/delete") 
	public void delete(@RequestParam int moimNo) {
		
	}
	
	
	@Autowired
	AdminDao adminDao;
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute("adminMoimSearchVO") AdminMoimSearchVO adminMoimSearchVO) {
		model.addAttribute("adminMoimList", adminDao.adminMoimSearch(adminMoimSearchVO));
		return "moim/list";
	}

	
}
