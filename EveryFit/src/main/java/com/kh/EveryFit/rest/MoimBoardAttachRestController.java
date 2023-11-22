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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.MoimBoardDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("moimBoard/rest/attach")
public class MoimBoardAttachRestController {
	
	
	@Autowired
	private AttachDao attachDao;
	
	//미리 작성해둔 커스텀 속성을 불러와서 디렉터리 객체까지 생성
	@Autowired
	private FileUploadProperties props;

	@Autowired
	private MoimBoardDao moimBoardDao;
	
	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(props.getHome(),"moimBoard");
		dir.mkdirs();
	}
	
	@PostMapping("/upload")
	public Map<String, Object> upload(HttpSession session, @RequestParam int moimBoardNo,
				@RequestParam MultipartFile attach)throws IllegalStateException, IOException {
		
		int attachNo = attachDao.sequence();
		
		File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
		attach.transferTo(target);
		
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		
		attachDao.insert(attachDto);
		
		moimBoardDao.deleteMoimBoardImage(moimBoardNo);
		moimBoardDao.insertMoimBoardImage(moimBoardNo, attachDto.getAttachNo());
		
		log.debug("moimBoadNo = {}", moimBoardNo);
		
		return Map.of("attachNo", attachNo);
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> 
							download(@RequestParam int attachNo) throws IOException {
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			return ResponseEntity.notFound().build(); //404반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
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
	public void delete(HttpSession session, @RequestParam int moimBoardNo) {
		moimBoardDao.deleteMoimBoardImage(moimBoardNo);
	}
	

	



	

	
	
	


}