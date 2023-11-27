package com.kh.EveryFit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.AdminMoimMemberCountVO;
import com.kh.EveryFit.dto.AttachDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/")
@Slf4j
public class HomeController {
	@Autowired
	AdminDao adminDao;
	@Autowired
	MoimDao moimDao;

	@Autowired
	private FileUploadProperties props;

	private File dir;

	@GetMapping("/")
	public String home(Model model, @ModelAttribute AdminMoimMemberCountVO adminMoimMemberCountVO) {
		model.addAttribute("NewMoimList", adminDao.NewMoimList());
		model.addAttribute("moimProfileList", adminDao.moimProfileList());
		model.addAttribute("PremiumMoimList", adminDao.PremiumMoimList());
		model.addAttribute("GenderCheckMoimList", adminDao.GenderCheckMoimList());
		model.addAttribute("memberCount", adminDao.memberCount());

		return "/home";
	}
	
	@GetMapping("/home/moimSerach")
	public String homeMoimSerach(Model model,@RequestParam(name = "moimTitle") String moimTitle) {
		model.addAttribute("homeMoimSearchList", adminDao.homeMoimSearchList(moimTitle));
		model.addAttribute("memberCount", adminDao.memberCount());

		return "/homeMoimSerach";
	}

	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> image(@RequestParam int moimNo) throws IOException {

		AttachDto attachDto = adminDao.findImage(moimNo);
		// if(attachDto == null) {
		// return ResponseEntity.notFound().build();
		// }
		MoimDto moimDto = moimDao.selectOne(moimNo);
		moimDto.setImage(true);
		String home = "C:/upload/kh12fd";
		File dir = new File(home);
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);

		ByteArrayResource resource = new ByteArrayResource(data);
		// System.out.println(attachDto.getAttachName());

		return ResponseEntity.ok()

				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
						.filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}

}
