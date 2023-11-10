package com.kh.EveryFit.controller;

import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
//	//main
//	@GetMapping("/")
//	public String home() {
//		return "/home";
//	}
	
	
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/member/join";
	}
		
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "/member/login";
	}
	
	@RequestMapping("/joinFinsh")
	public String joinFinish() {
		return "/member/jponFinish";
	}
	
	
//	@RequestMapping("joinFinish")
//	public
	
//	로그인
	@GetMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	@PostMapping("/login")
	   public String login(@ModelAttribute MemberDto inputDto, 
	                              HttpSession session) {
	      
	      //[1] 사용자가 입력한 아이디로 데이터베이스에서 정보를 조회
	      MemberDto findDto = memberDao.slelctOne(inputDto.getMemberEmail());
	      //[2] 1번에서 정보가 있다면 비밀번호를 검사(없으면 차단)
	      if(findDto == null) {
	         return "redirect:login?error";//redirect는 무조건 GetMapping으로 간다
	      }
	      
	      
	      boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
	      
	      //[3] 비밀번호가 일치하면 메인페이지로 이동
	      if(isCorrectPw) {

	    	  session.setAttribute("name",inputDto.getMemberEmail());
	    		//로그인시간 갱신
//				memberDao.updateMemberLogin(inputDto.getMemberEmail());

	         //메인페이지로 이동
	         return "redirect:/";
	      }
	      //[4] 비밀번호가 일치하지 않으면 로그인페이지로 이동
	      else {
	         return "redirect:login?error";
	      }
	   }
	
	//마이페이지 
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		//세션에서 사용자의 아이디를 꺼낸다 
		// - 세션은 값을 Object로 저장한다 
		String memberEmail = (String) session.getAttribute("name");
		// 가져온 아이디로 회원정보를 조회한다 
		MemberDto memberDto = memberDao.selectOne(memberEmail);
		// 조회한 정보를 모델에 첨부한다 
		model.addAttribute("memberDto",memberDto);
		return "/member/mypage";
	}
		
	
	//회원 로그아웃 페이지
		@RequestMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("name;");
//			session.removeAttribute("level");//확인받아야
			return "redirect:/";
		}
		//modal
		@RequestMapping("/modal")
		public String modal(HttpSession session) {
			return "/member/modal";
		}
		
		
		//개인정보 변경 
		@GetMapping("/change")
		public String change (HttpSession session, Model model) {
			String memberEmail = (String)session.getAttribute("name");//아이디를 꺼내오는 
//			Date memberBirth = (Date)session.getAttribute("memberBirth");
			MemberDto memberDto = memberDao.selectOne(memberEmail);//로그인한 현재 회원정보
			model.addAttribute("memberDto",memberDto);//로그인된 회원 정보를 model에 넘긴다
			return "/member/change";
		}
		
		@PostMapping("/change")
		public String change (@ModelAttribute MemberDto inputDto,
								HttpSession session) {
		String memberemail = (String)session.getAttribute("name");
		
		//비밀번호 검사 후 변경 처리 요청 
		MemberDto findDto = memberDao.selectOne(memberemail);
		log.debug("find={}",findDto);
		log.debug("input{}",inputDto);
		if(inputDto.getMemberPw().equals(findDto.getMemberPw())) {//비밀번호 일치 
			inputDto.setMemberEmail(memberemail);//아이디를 설정하고
//			memberDao.change(inputDto);//정보 변경 처리
			return "redirect:/member/mypage";
		}
		else {//비밀번호가 일치하지 않는다면 다시 입력하도록 되돌려 보냄 
			return "redirect:/member/change";
		}
		
		}
		
	}
	
