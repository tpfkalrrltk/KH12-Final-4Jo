package com.kh.EveryFit.rest;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MemberLikeDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;
import com.kh.EveryFit.vo.JungmoDetailVO;
import com.kh.EveryFit.vo.MemberLikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/moim")
public class MoimRestController {
	
	@Autowired private JungmoDao jungmoDao;
	@Autowired private MoimDao moimDao;
	@Autowired private ChatDao chatDao;
	@Autowired private AttachDao attachDao;
	@Autowired private MemberDao memberDao;
	
	//모임프로필사진 등록/삭제
	//정모프로필사진 등록/삭제
	//모임수정
	
	//정모 목록
//	@PostMapping("/list")
//	public List<JungmoListByMoimNoVO> list(@RequestParam int moimNo) {
//		return jungmoDao.selectList(moimNo);
//	}
	//정모회원리스트
//	@PostMapping("/memberList")
//	public List<JungmoMemberListVO> memberList(@RequestParam int jungmoNo) {
//		return jungmoDao.selectListByJungmoNo(jungmoNo);
//	}

	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	@PostMapping("/infoChange")
	public String infoChange(@ModelAttribute MoimDto moimDto) {
	    int moimNo = Integer.parseInt(String.valueOf(moimDto.getMoimNo()));
	    int locationNo = Integer.parseInt(String.valueOf(moimDto.getLocationNo()));
	    int eventNo = Integer.parseInt(String.valueOf(moimDto.getEventNo()));

	    moimDto.setMoimNo(moimNo);
	    moimDto.setLocationNo(locationNo);
	    moimDto.setEventNo(eventNo);

		moimDao.updateMoimInfo(moimDto);
		return "success";
	}
	
	//모임 좋아요 기능
	@RequestMapping("/likeCheck")
	public MemberLikeVO likeCheck(@ModelAttribute MemberLikeDto memberLikeDto,
						HttpSession session) {
		String memberEmail = (String) session.getAttribute("name");
		memberLikeDto.setMemberEmail(memberEmail);
		
		boolean isCheck = moimDao.memberLikeCheck(memberLikeDto);
		int count = moimDao.memberLikeCount(memberLikeDto.getMoimNo());
		
		MemberLikeVO vo = new MemberLikeVO();
		vo.setCheck(isCheck);
		vo.setCount(count);

		
		return vo;
	}
	
	@RequestMapping("/likeAction")
	public MemberLikeVO likeAction(@ModelAttribute MemberLikeDto memberLikeDto,
									HttpSession session) {
		String memberEmail = (String)session.getAttribute("name");
		memberLikeDto.setMemberEmail(memberEmail);

		boolean isCheck = moimDao.memberLikeCheck(memberLikeDto);
		log.debug("isCheck = {}", isCheck);
		if (!isCheck) { // 체크되어있지 않다면
		    moimDao.memberLikeInsert(memberLikeDto); // 체크설정
		    log.debug("memberLikeDto = {}", memberLikeDto);
		} else { // 이미 체크되어 있다면
		    moimDao.memberLikeDelete(memberLikeDto); // 체크해제
		}


		int count = moimDao.memberLikeCount(memberLikeDto.getMoimNo());
		
		MemberLikeVO vo = new MemberLikeVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		
		return vo;
	}
	
	//정모등록
	@PostMapping("/jungmo/create")
	public String create(
			@ModelAttribute JungmoDto jungmoDto, 
			@RequestParam MultipartFile attach,
			@RequestParam("jungmoDto.jungmoScheduleStr") String jungmoScheduleStr,
			HttpSession session) throws IllegalStateException, IOException {

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
		
		//채팅방번호를 시퀀스로 만들어서 일단 채팅방 하나 만들고(chat 테이블에 insert!) 그 번호를 
		int chatRoomNo = chatDao.sequence();
		log.debug("chatRoomNo");
		
		String memberEmail = (String)session.getAttribute("name");
		chatDao.insertChatRoom(chatRoomNo);
		jungmoDto.setChatRoomNo(chatRoomNo);
		jungmoDao.insert(jungmoDto);

		//채팅참가자 추가
		chatDao.addChatMember(chatRoomNo, memberEmail);
				
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
		return "success";
	}
	
	@RequestMapping("/jungmo/check")
	public JungmoDetailVO jungmoCheck(@RequestParam int jungmoNo) {
		//정모번호로 정모정보조회
		JungmoDto jungmoDto = jungmoDao.selectOneByJungmoNo(jungmoNo);
		//정모번호로 프로필사진 조회
		int attachNo = moimDao.findJungmoProfile(jungmoNo);
		
		JungmoDetailVO vo = new JungmoDetailVO();
		vo.setJungmoDto(jungmoDto);
		vo.setAttachNo(attachNo);
		return vo;
	}
	
	//정모 수정
	@PostMapping("/jungmo/edit")
	public void edit(@ModelAttribute JungmoDto jungmoDto,
			@RequestParam MultipartFile attach,
			@RequestParam("jungmoDto.jungmoScheduleStr") String jungmoScheduleStr) throws IllegalStateException, IOException {

		String subStrJungmoSchedule = jungmoScheduleStr.substring(0, 10);
			
		try {
	        // 문자열을 LocalDateTime으로 파싱
	        LocalDateTime localDateTime = LocalDateTime.parse(jungmoScheduleStr, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));

	        // LocalDateTime을 java.sql.Timestamp으로 변환
	        java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(localDateTime);

	        jungmoDto.setJungmoSchedule(timestamp);
	    } catch (DateTimeParseException e) {
	        // 예외 처리 로직 추가
	    }
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
			moimDao.deleteJungmoProfile(jungmoDto.getJungmoNo());
			moimDao.insertJungmoProfile(jungmoDto.getJungmoNo(), attachNo);
		}
		
		jungmoDao.edit(jungmoDto);
	}
	
	//여성모임 확인
	@PostMapping("/checkGender")
	public String genderCheck(@RequestParam String memberEmail) {
		MemberDto memberDto = memberDao.selectOne(memberEmail);
		if(memberDto.getMemberGender().equals("F")) {
			return "female";
		}
		else {
			return "male";
		}
	}
	
//	@PostMapping("/member/join")
//	public String memberJoin(HttpSession session, @RequestParam int moimNo) {
//        String memberEmail = (String) session.getAttribute("name");
//
//        MemberDto memberDto = memberDao.selectOne(memberEmail);
//        MoimDto moimDto = moimDao.selectOne(moimNo);
//        MoimMemberDto moimMemberDto = new MoimMemberDto();
//		
//        // 해당 회원의 moimCount보다 가입되어있는 모임의 개수가 많으면 return
//        Integer myMoim = moimDao.findMyMoim(memberEmail);
//        Integer myMoimCount = memberDto.getMemberMoimCount();
//        
//        if (myMoim >= myMoimCount) {
//            return "over";
//        }
//        
//        if (myMoim > 0) {
//            MyMoimListVO vo = moimDao.findMoimNoByMemberEmail(memberEmail);
//            
//            if (vo != null && vo.getMoimNoList().contains(moimNo)) {
//            	
//            	if (Objects.equals(moimDto.getMoimGenderCheck(), "Y")) { // 여성전용모임
//                    if (Objects.equals(memberDto.getMemberGender(), "F")) { // 여성회원인지 검사
//                        moimMemberDto.setMemberEmail(memberEmail);
//                        moimMemberDto.setMoimNo(moimNo);
//                        moimMemberDto.setMoimMemberStatus("미승인");
//                        moimDao.addMoimMember(moimMemberDto);
//                        return "join";
//                    } else {
//                        // 여성회원만 가입 가능하다는 응답
//                        return "genderCheck";
//                    }
//                } else {
//                    moimMemberDto.setMemberEmail(memberEmail);
//                    moimMemberDto.setMoimNo(moimNo);
//                    moimDao.addMoimMember(moimMemberDto);
//                }
//            	
//                return "join";
//            }
//        }
//	}
	
	@PostMapping("/member/join")
	public String memberJoin(HttpSession session, @RequestParam int moimNo) {
	    String memberEmail = (String) session.getAttribute("name");

	    if (memberEmail == null) {
	        // 로그인되어 있지 않은 경우
	        return "notLoggedIn";
	    }

	    MemberDto memberDto = memberDao.selectOne(memberEmail);
	    
	    if (memberDto == null) {
	        // 회원 정보를 찾을 수 없는 경우
	        return "memberNotFound";
	    }

	    MoimDto moimDto = moimDao.selectOne(moimNo);

	    if (moimDto == null) {
	        // 모임 정보를 찾을 수 없는 경우
	        return "moimNotFound";
	    }

	    MoimMemberDto moimMemberDto = new MoimMemberDto();

	    // 해당 회원의 moimCount보다 가입되어있는 모임의 개수가 많으면 return
	    Integer myMoim = moimDao.findMyMoim(memberEmail);
	    Integer myMoimCount = memberDto.getMemberMoimCount();
	    
	    if (myMoim != null && myMoim >= myMoimCount) {
	        return "over";
	    }
	    
	    List<Integer> list = moimDao.findMoimNoByMemberEmail(memberEmail);
//	    List<Integer> list = new ArrayList<>(moimDao.findMoimNoByMemberEmail(memberEmail));
	    log.debug("list={}", list);

	    if (myMoim != null) {
	    	
	        if (list != null && list.contains(moimNo)) {
	        	//이미 가입 되었음
	        	return "joined";
	        }	
	        
	        if (Objects.equals(moimDto.getMoimGenderCheck(), "Y")) { // 여성전용모임
                
            	if (Objects.equals(memberDto.getMemberGender(), "F")) { // 여성회원인지 검사
                    moimMemberDto.setMemberEmail(memberEmail);
                    moimMemberDto.setMoimNo(moimNo);
                    moimMemberDto.setMoimMemberStatus("미승인");
                    moimDao.addMoimMember(moimMemberDto);
                    return "join";
                } 
                // 여성회원만 가입 가능하다는 응답
                return "genderCheck";                    
            } 
                moimMemberDto.setMemberEmail(memberEmail);
                moimMemberDto.setMoimNo(moimNo);
                moimDao.addMoimMember(moimMemberDto);
                return "join";

	    }
	    //myMoim이 null일경우
	    moimMemberDto.setMemberEmail(memberEmail);
	    moimMemberDto.setMoimNo(moimNo);
	    moimDao.addMoimMember(moimMemberDto);
	    return "join";
	}

	@RequestMapping("/member/info")
	public MoimMemberDto memberInfo(@RequestParam String memberEmail, Integer moimNo) {

		MoimMemberDto moimMemberDto = moimDao.findMoimMemberInfo(memberEmail, moimNo);
		
		if(moimMemberDto == null) {
			return null;
		}
		
		return moimMemberDto;
	}
	
	//모임회원차단
//	@PostMapping("/memberBlock")
//	public String memberBlock(@RequestParam String memberEmail) {
//		moimDao.updateMoimMember(memberEmail);
//		return "Y";
//	}

}
