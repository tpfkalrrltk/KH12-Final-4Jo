package com.kh.EveryFit.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.service.EmailService;

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private EmailService emailService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	 private BCryptPasswordEncoder encoder;


	
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/member/join";
	}
		
	@PostMapping("/join")
	public String join(
			@ModelAttribute MemberDto dto) throws MessagingException, IOException {
		memberDao.insert(dto);
		emailService.sendCelebration(dto.getMemberEmail());
		return "redirect:joinFinish";
	}
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/member/joinFinish";
	}
	
	
//	로그인
	@GetMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String login(
	    @ModelAttribute MemberDto inputDto,
	    @RequestParam String memberEmail,
	    @RequestParam String memberPw,
	    @RequestParam(required = false) String autoLogin,
	    HttpServletResponse response,
	    HttpSession session) {

	    //[1] 사용자가 입력한 아이디로 데이터베이스에서 정보를 조회
	    MemberDto findDto = memberDao.selectOne(inputDto.getMemberEmail());

	    //[2] 1번에서 정보가 있다면 비밀번호를 검사(없으면 차단)
	    if (findDto == null) {
	        return "redirect:login?error";
	    }

//	    boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
	    boolean isCorrectPw = encoder.matches(inputDto.getMemberPw(), findDto.getMemberPw());


	    
	  //[3] 비밀번호가 일치하면 메인페이지로 이동
	      if(isCorrectPw ) {
	         //세션에 아이디+등급 저장
	         session.setAttribute("name", findDto.getMemberEmail());
	         session.setAttribute("level", findDto.getMemberLevel());
	         session.setAttribute("nickName", findDto.getMemberNick());

	        // 아이디 저장하기를 체크했다면 쿠키 생성
	        if (autoLogin != null) {
	            Cookie cookie = new Cookie("saveId", memberEmail);
	            cookie.setMaxAge(4 * 7 * 24 * 60 * 60); // 4주
	            response.addCookie(cookie);
	        } else {
	            // 아이디 저장하기를 체크하지 않았다면 쿠키 삭제
	            Cookie cookie = new Cookie("saveId", memberEmail);
	            cookie.setMaxAge(0); // 발행 즉시 삭제
	            response.addCookie(cookie);
	        }

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
		// 프로필 이미지 번호를 첨부한다
		model.addAttribute("profile",memberDao.findProfile(memberEmail));
		
		return "/member/mypage";
		
		 
		
	}
		
	
	//회원 로그아웃 페이지
		@RequestMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("name");
			session.removeAttribute("nickName");
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
		log.debug("input={}",inputDto);
		//if(inputDto.getMemberPw().equals(findDto.getMemberPw())) {//비밀번호 일치 
			inputDto.setMemberEmail(memberemail);//아이디를 설정하고
			memberDao.changeMemberInfo(inputDto);// 정보 변경 처리

            return "redirect:/member/mypage";
        //} else {// 비밀번호가 일치하지 않는다면 다시 입력하도록 되돌려 보냄 
        //    return "redirect:/member/change";
        //}
//    } catch (Exception e) {
//        // 예외 처리 (예: 로그 남기기, 오류 페이지로 리다이렉트 등)
//        return "redirect:/error";
//    }
}

		
		//비밀번호 변경 
		@GetMapping("/changePw")
			public String changePw(HttpSession session, Model model){
//			String memberEmail = (String) session.getAttribute("name");//아이디 꺼내오는 
//			MemberDto memberDto = memberDao.selectOne(memberEmail);//로그인한 현재회원 정보 
//			model.addAttribute("memberDto",memberDto);//로그인된 회원정보를 model에 넘긴다 
			return "/member/changePw";
		}
		@PostMapping("/changePw")
		public String changePw(HttpSession session,
		                        @RequestParam String originPw,
		                        @RequestParam String changePw,
		                        Model model) {
		    String memberEmail = (String) session.getAttribute("name");
		    MemberDto findDto = memberDao.selectOne(memberEmail);

		    // 암호화된 입력 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
		    if (encoder.matches(originPw, findDto.getMemberPw())) {
		        // 새로운 비밀번호를 암호화
		        String encryptedNewPassword = encoder.encode(changePw);

		        // 암호화된 비밀번호를 DTO에 설정
		        findDto.setMemberPw(encryptedNewPassword);

		        // customerDao.edit 메소드가 새로운 비밀번호를 업데이트할 수 있도록 수정 필요
		        memberDao.edit(memberEmail, changePw);

		        // 비밀번호 변경 완료 후 세션 무효화 및 로그아웃
		        session.invalidate();

		        return "/member/login";
		    } else {
		        model.addAttribute("error", "비밀번호 변경에 실패했습니다. 입력한 비밀번호를 확인하세요.");
		        return "redirect:memberchangePw?error";
		    }
		}
			
		
		@GetMapping("/memberChangePw")
		public String memberChangePw(HttpSession session, Model model){
			String memberEmail = (String) session.getAttribute("name");//아이디 꺼내오는 
			MemberDto memberDto = memberDao.selectOne(memberEmail);//로그인한 현재회원 정보 
			model.addAttribute("memberDto",memberDto);//로그인된 회원정보를 model에 넘긴다 
			return "/member/memberChangePw";
	}
		
		
		@PostMapping("/memberChangePw")
		public String memberChangePw(HttpSession session,
					                @RequestParam String originPw,
					                @RequestParam String changePw,
					                Model model) {
			String memberEmail = (String) session.getAttribute("name");
			MemberDto findDto = memberDao.selectOne(memberEmail);
			
			// 암호화된 입력 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
			if (encoder.matches(originPw, findDto.getMemberPw())) {
			// 새로운 비밀번호를 암호화
			String encryptedNewPassword = encoder.encode(changePw);
			
			// 암호화된 비밀번호를 DTO에 설정
			findDto.setMemberPw(encryptedNewPassword);
			
			// customerDao.edit 메소드가 새로운 비밀번호를 업데이트할 수 있도록 수정 필요
			memberDao.changeMemberInfo(findDto);
			
			// 비밀번호 변경 완료 후 세션 무효화 및 로그아웃
			session.invalidate();
			
			return "/member/login";
			} else {
			model.addAttribute("error", "비밀번호 변경에 실패했습니다. 입력한 비밀번호를 확인하세요.");
			return "redirect:memberchangePw?error";
			}
		}
		
		@GetMapping("/exit")
		public String exit() {
			return "/member/exit";
		}

		@PostMapping("/exit")
			public String exit(HttpSession session, @RequestParam String memberPw) {
				String memberEmail = (String)session.getAttribute("name");
				MemberDto memberDto = memberDao.selectOne(memberEmail);
				boolean isCorrectPw = encoder.matches(memberPw,memberDto.getMemberPw());
				if(isCorrectPw){//비밀번호 확인
					
				memberDao.delete(memberEmail);
				
				//로그아웃 
				session.removeAttribute("name");//세션에서 name의 값을 삭제 
				return "redirect:/";
				}
				else {//비밀번호 불일치 
					return "redirect:exit";
				}
			}
//		비밀번호 찾기 
		@GetMapping("/findPw")
		public String findPw() {
			return "/member/findPw";
		}
		
		@PostMapping("/findPw")
		public String findPw(@ModelAttribute MemberDto memberDto) {
//			[1] 이메일로 모든 정보를 불러오기 
			MemberDto findDto = 
					memberDao.selectOne(memberDto.getMemberEmail());
		//[2] 이메일 일치하는지 확인
		boolean isValid = findDto != null 
				&& findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(isValid) {//이메일이 같다면 
			//이메일 발송 코드 
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(findDto.getMemberEmail());
			message.setSubject("[Every Fit] 임시비밀번호 안내");
			message.setText(findDto.getMemberPw());
			sender.send(message);
			
			return "redirect:findPwFinish";
		}
		else {//이메일이 다르다면 
			return "redirect:findPw?error";
		}
}


@RequestMapping("findPwFinish")
public String findPwFinish() {
	return"/member/findPwFinish";
	}

// 자동 로그인 쿠키 
//@PostMapping("/login")
//public String login(
//		HttpServletResponse response,
//		@RequestParam String memberEmail,
//		@RequestParam String memberPw,
//		@RequestParam(required = false) String autoLogin// 미체크시 null
//		) {
//	
//	if(autoLogin != null ) {//아디 저장을 체크했다면 
//		Cookie cookie = new Cookie("saveId",memberEmail);//쿠키 생성 
//		cookie.setMaxAge(4*7*24*60*60);//4주
//		response.addCookie(cookie);//쿠키 발행
//	}
//	else {// 안했다면 
//		Cookie cookie = new Cookie("saveId",memberEmail);
//		cookie.setMaxAge(0);//발행 즉시삭제
//		response.addCookie(cookie);//쿠키 발행
//	}
//	return "redirect:/";
//}




}










