package com.kh.EveryFit.rest;

import java.util.List;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;

@CrossOrigin
@RestController
@RequestMapping("/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;
	
	
	@GetMapping("/")
	public List<MemberDto> list(){
		return memberDao.selectList();
	}
	
	@GetMapping("/memberEmail/{memberEmail}")
	public MemberDto find(@PathVariable String memberEmail) {
		return memberDao.slelctOne(memberEmail);
	}
	
	@GetMapping("/membeNick/{memberNick}")
	public List<MemberDto> search(@PathVariable String memberNick){
		return memberDao.searchList(memberNick);
	}
	
	@PostMapping("/")
	public void insert(@RequestBody MemberDto memberDto) {
		memberDao.insert(memberDto);
	}
	
	@PutMapping("/{memberEmail}")
	public void update(@RequestBody MemberDto memberDto, @PathVariable String memberEmail) {
		memberDao.edit(memberEmail,memberDto);
	}
	
	@PatchMapping("{memberEmail}")
	public void update2(@RequestBody MemberDto memberDto, @PathVariable String memberEmail) {
		memberDao.edit(memberEmail, memberDto);
	}
	
	@DeleteMapping("/{memberEmail}")
	public void delete(@PathVariable String memberEmail) {
		memberDao.delete(memberEmail);
	}
	
	//프론트에서 페이지번호, 데이터개수를 보낼 경우의 조회 매핑 
	@GetMapping("page/{page}/size/{size}")
	public List<MemberDto> listByPage(@PathVariable int page, @PathVariable int size){
		return memberDao.selectListByPage(page,size);
	}
}
