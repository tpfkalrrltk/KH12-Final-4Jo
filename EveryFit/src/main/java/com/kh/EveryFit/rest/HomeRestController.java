package com.kh.EveryFit.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;

@RestController
@RequestMapping("/rest")
public class HomeRestController {
	@Autowired
	AdminDao adminDao;
	@Autowired
	MoimDao moimDao;
	@Autowired
	private FileUploadProperties props;

	private File dir;

	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> image(@RequestParam int moimNo) throws IOException {

		AttachDto attachDto = adminDao.findImage(moimNo);

		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);

		ByteArrayResource resource = new ByteArrayResource(data);
		System.out.println(attachDto.getAttachName());

		return ResponseEntity.ok()

				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
						.filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	
		//모임 인원 확인
		@PostMapping("/memberCount")
		public Integer memberCount(@RequestParam int moimNo) {
			 
				return adminDao.moimMemberCount(moimNo);
		
		}
	
	
}
