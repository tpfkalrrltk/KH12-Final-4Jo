package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.FaqDao;
import com.kh.EveryFit.dto.FaqDto;

@RestController
@CrossOrigin
@RequestMapping("/faq")
public class FaqRestController {

	@Autowired
	FaqDao faqDao;

	@GetMapping("/")
	public List<FaqDto> list() {
		return faqDao.list();
	}

	@PostMapping("/")
	public void add(@RequestBody FaqDto faqDto) {
		int faqNo = faqDao.sequence();
		faqDto.setFaqNo(faqNo);
		faqDao.add(faqDto);
	}

	@PutMapping("/{faqNo}")
	public void edit(@RequestBody FaqDto faqDto, @PathVariable int faqNo) {
		faqDao.edit(faqNo, faqDto);
	}

	@DeleteMapping("/{faqNo}")
	public void delete(@PathVariable int faqNo) {
		faqDao.delete(faqNo);
	}
	@GetMapping("/{faqNo}")
	public FaqDto selectOne(@PathVariable int faqNo) {
		 return faqDao.selectOne(faqNo);
	}
}
