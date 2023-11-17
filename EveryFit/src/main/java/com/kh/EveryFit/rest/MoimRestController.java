package com.kh.EveryFit.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.JungmoDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.MemberLikeDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.MemberLikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/moim")
public class MoimRestController {
	
	@Autowired private JungmoDao jungmoDao;
	@Autowired private MoimDao moimDao;
	
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
//	@PostMapping("/edit")
//	public void edit(@ModelAttribute JungmoDto jungmoDto) {
//		jungmoDao.edit(jungmoDto);
//	}
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
	
//	@PostMapping("/genderCheck")
//	public String genderCheck(@ModelAttribute genderCheckVO vo) {
//		moimDao.updateMoimInfo(vo);
//	}
	
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
	
	//모임회원차단
//	@PostMapping("/memberBlock")
//	public String memberBlock(@RequestParam String memberEmail) {
//		moimDao.updateMoimMember(memberEmail);
//		return "Y";
//	}

}
