package com.kh.EveryFit.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MoimBoardDao;
import com.kh.EveryFit.dto.MoimBoardDto;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@CrossOrigin
@RequestMapping("/moimBoard")
public class moimBoardRestController {

	@Autowired
	private MoimBoardDao moimBoardDao;

	@GetMapping("/")
	public List<MoimBoardDto> list() {
		return moimBoardDao.list();
	}

	@PostMapping("/")
	public void add(@RequestBody MoimBoardDto moimBoardDto) {
		moimBoardDao.add(moimBoardDto);
	}

	@PutMapping("/{moimBoardNo}")
	public void edit(@PathVariable int moimBoardNo, @RequestBody MoimBoardDto moimBoardDto) {
		moimBoardDao.edit(moimBoardDto, moimBoardNo);
	}
	@DeleteMapping("/{moimBoardNo}")
	public void delete(@PathVariable int moimBoardNo) {
		moimBoardDao.delete(moimBoardNo);
	}
}
