package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AdminDao;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.ReportDto;

@Controller
@RequestMapping("/report")
public class ReportController {

	@Autowired
	AdminDao adminDao;
	@Autowired
	AttachDao attachDao;

	@Autowired
	private FileUploadProperties props;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(props.getHome(), "report");
		dir.mkdirs();

	}

	@GetMapping("/apply")
	public String apply() {
		return "report/apply";
	}

	@PostMapping("/apply")
	public String apply(@ModelAttribute ReportDto reportDto, @RequestParam MultipartFile attach,
			HttpSession session) throws IllegalStateException, IOException {
		String memberEmail = (String) session.getAttribute("name");
		reportDto.setMemberEmail(memberEmail);
		int reportNo = adminDao.sequence();
		reportDto.setReportNo(reportNo);
		adminDao.reportApply(reportDto);
		
		// 첨부파일등록(파일있을때)
				if (!attach.isEmpty()) {
					// 첨부파일등록(파일이 있을때만)
					int attachNo = attachDao.sequence();

					File target = new File(dir, String.valueOf(attachNo)); // 저장할 파일
					attach.transferTo(target);

					AttachDto attachDto = new AttachDto();
					attachDto.setAttachNo(attachNo);
					attachDto.setAttachName(attach.getOriginalFilename());
					attachDto.setAttachSize(attach.getSize());
					attachDto.setAttachType(attach.getContentType());
					attachDao.insert(attachDto);

					// 연결(파일이 있을때만)
					adminDao.insertReportImage(reportNo, attachNo);

				}
		
		

		return "redirect:/report/apply";
	}

}
