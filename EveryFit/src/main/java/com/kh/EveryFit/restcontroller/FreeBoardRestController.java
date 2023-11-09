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

import com.kh.EveryFit.dao.FreeBoardDao;
import com.kh.EveryFit.dto.FreeBoardDto;

import lombok.extern.slf4j.Slf4j;

@RestController
@CrossOrigin
@RequestMapping("/freeBoard")
@Slf4j
public class FreeBoardRestController {

	@Autowired
	FreeBoardDao freeBoardDao;

	@GetMapping("/")
	List<FreeBoardDto> list() {
		return freeBoardDao.list();
	}

	@PostMapping("/")
	public void add(@RequestBody FreeBoardDto freeBoardDto) {
		freeBoardDto.setFreeBoardNo(freeBoardDao.sequence());
		freeBoardDao.add(freeBoardDto);

	}

	@PutMapping("/{freeBoardNo}")
	public void edit(@PathVariable int freeBoardNo, @RequestBody FreeBoardDto freeBoardDto) {
		freeBoardDao.edit(freeBoardDto, freeBoardNo);
	}

	@DeleteMapping("/{freeBoardNo}")
	public void delete(@PathVariable int freeBoardNo) {
		freeBoardDao.delete(freeBoardNo);
	}
	@GetMapping("/{freeBoardNo}")
	public FreeBoardDto selectOne(@PathVariable int freeBoardNo) {
		return freeBoardDao.selectOne(freeBoardNo);
	}
}
