package com.kh.EveryFit.rest;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/member")

public class MemberRestController {

	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	
	
	@PostMapping("/emailCheck")
	public String emailCheck(@RequestParam String memberEmail) {
		MemberDto memberDto = memberDao.selectOne(memberEmail);
		if(memberDto == null) {//아이디가 없으면
			return "Y";
		}
		else {//아이디가 있으면
			return "N";
		}
	}
	    
	@PostMapping("/nickCheck")
	public String nickCheck(@RequestParam String memberNick) {
		MemberDto memberDto = 
			memberDao.selectOneByMemberNick(memberNick);
		if(memberDto == null) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	@PostMapping("/memberChangePw")
	public String memberChangePw(HttpSession session, @RequestParam String originPw, @RequestParam String changePw,
			Model model) {
		String memberEmail = (String) session.getAttribute("name");
		MemberDto findDto = memberDao.selectOne(memberEmail);

// 암호화된 입력 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
		if (encoder.matches(originPw, findDto.getMemberPw())) {
// 새로운 비밀번호를 암호화
			String encryptedNewPassword = encoder.encode(changePw);

// 암호화된 비밀번호를 DTO에 설정
			findDto.setMemberPw(encryptedNewPassword);

// memberDao.edit 메소드가 새로운 비밀번호를 업데이트할 수 있도록 수정 필요
			memberDao.changeMemberInfo(findDto);

// 세션 무효화
			session.invalidate();

// 로그인 페이지로 이동
			return "/member/login";
		} else {
			model.addAttribute("error", "비밀번호 변경에 실패했습니다. 입력한 비밀번호를 확인하세요.");
			return "redirect:memberchangePw?error";
		}
	}

//	@PostMapping("/changePw")
//	public String changePw(HttpSession session,
//	                        @RequestParam String changePw,
//	                        Model model) {
//	    String memberEmail = (String) session.getAttribute("name");
//	    MemberDto findDto = memberDao.selectOne(memberEmail);

	    // 암호화된 입력 비밀번호와 DB에 저장된 암호화된 비밀번호 비교
//	    if (encoder.matches(originPw, findDto.getMemberPw())) {
	        // 새로운 비밀번호를 암호화
//	        String encryptedNewPassword = encoder.encode(changePw);

	        // 암호화된 비밀번호를 DTO에 설정
//	        memberDao.setMemberEmail(memberEmail);
//	        findDto.setMemberPw(encryptedNewPassword);

	        // customerDao.edit 메소드가 새로운 비밀번호를 업데이트할 수 있도록 수정 필요
//	        memberDao.edit(memberEmail, findDto);
	        
	        // 비밀번호 변경 완료 후 세션 무효화 및 로그아웃
//	        session.invalidate();

//	        return "/";
//	    } else {
//	        model.addAttribute("error", "비밀번호 변경에 실패했습니다. 입력한 비밀번호를 확인하세요.");
//	        return "redirect:memberchangePw?error";
//	    }
//	}
	
//	마이페이지 자기소개
	
	
	
//	프로필 업로드&다운로드 기능
		@Autowired
		private AttachDao attachDao;
		
		//초기 디렉터리 설정
		@Autowired
		private FileUploadProperties props;
		
		private File dir;
		
		@PostConstruct
		public void init() {
//			dir = new File(props.getHome());
			dir = new File(props.getHome());
			dir.mkdirs();
			log.debug("생성 - " +dir.getAbsolutePath());
		}
		
//		//비동기통신에서는 화면에서 다음 작업이 가능하도록 파일번호 등을 전달
		@PostMapping("/upload")
		public Map<String, Object> upload(HttpSession session,
				@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//			//절대규칙 - 파일은 하드디스크에, 정보는 DB에!
//			
			log.debug("업로드 시작");
//			//[1] 시퀀스 번호를 생성한다
			int attachNo = attachDao.sequence();
			
//			//[2] 시퀀스 번호를 파일명으로 하여 실제 파일을 저장한다
//			- 같은 이름에 대한 충돌을 방지하기 위해
			dir.mkdirs();
			File target = new File(dir, String.valueOf(attachNo));//저장할파일
			attach.transferTo(target);//저장
			
//			//[3] DB에 저장한 파일의 정보를 모아서 INSERT
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
//			//파일 업로드가 완료되면 아이디와 파일번호를 연결
			String memberEmail = (String)session.getAttribute("name");
			memberDao.deleteProfile(memberEmail);//기존이미지를 제거
			memberDao.insertProfile(memberEmail, attachNo);//신규이미지를 추가
			log.debug("{}, {}", memberEmail, attachNo);
			
			//화면에서 사용할 수 있도록 파일번호 또는 다운주소를 반환
//			return 객체 or Map;
			return Map.of("attachNo", attachNo);
		}
		
		//다운로드는 비동기나 동기나 똑같음(파일번호만 알면 됨)
		@RequestMapping("/download")
		public ResponseEntity<ByteArrayResource> 
							download(@RequestParam int attachNo) throws IOException {
			AttachDto attachDto = attachDao.selectOne(attachNo);
			
			if(attachDto == null) {
				//throw new NoTargetException("파일 없음");//내가만든 예외로 통합
				return ResponseEntity.notFound().build();//404 반환
			}
			
			String home = "Users/seungseok/upload";
//			File dir = new File(home,"mebmerProfile");
//			dir.mkdirs();
			File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
			
			byte[] data = FileUtils.readFileToByteArray(target);//실제파일정보 불러오기
			ByteArrayResource resource = new ByteArrayResource(data);
			
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
					.contentLength(attachDto.getAttachSize())
					.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
					.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
						.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
						.build().toString()
					)
				.body(resource);
		}
		
		@PostMapping("/delete")
		public void delete(HttpSession session) {
			String memberEmail = (String)session.getAttribute("name");
			memberDao.deleteProfile(memberEmail);
		}
}	
//		//회원 등급별 인원 수 데이터 반환 매핑
//		@GetMapping("/stat/count")
//		public List<StatDto> statCount() {
//			return memberDao.selectGroupByMemberLevel();
//		}
//		
//		@GetMapping("/stat/year")
//		public List<StatDto> statYear() {
//			return memberDao.selectGroupByYear();
//		}
//		
//		@GetMapping("/stat/month")
//		public List<StatDto> statMonth() {
//			return memberDao.selectGroupByMonth();
//		}
//		
//		@GetMapping("/stat/date")
//		public List<StatDto> statDate() {
//			return memberDao.selectGroupByDate();
//		}
	
	
