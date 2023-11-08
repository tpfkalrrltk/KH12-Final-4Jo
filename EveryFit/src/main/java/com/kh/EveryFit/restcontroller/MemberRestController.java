package com.kh.EveryFit.restcontroller;

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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name="회원 관리", description = "회원 정보 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/member")
public class MemberRestController {

//	아래 다섯 개의 매핑을 이용하여 프론트엔드에 대응하는 Rest 기능을 구현 
//	@GetMapping - 조회 
//	@PostMapping - 등록 
//	@PutMapping - 전체 수정 
//	@PatchMapping - 일부 수정 
//	@Delete - 삭제 
	
	@Autowired
	private MemberDao memberDao;
	
	
	@GetMapping("/")
	public List<MemberDto> list(){
		return memberDao.selectList();
	}
	
	//목록 매핑에 대한 설명용 annotation
	@Operation(
			description = "회원 조회",
			responses = {
					@ApiResponse(
						responseCode = "200",
						description = "조회 성공",
						content = {
							@Content(
								mediaType = "application/json",
								array = @ArraySchema(
									schema = @Schema(implementation = MemberDto.class)
									)
								) 
							}
						),
					@ApiResponse(
						responseCode = "500",
						description = "서버 오류",
						content = @Content(
								mediaType = "text/plain",
								schema = @Schema(implementation = String.class),
								examples = @ExampleObject("server error")
						)
					)
				}
			)

	
	@GetMapping("/memberEmail/{memberEmail}")
	public MemberDto find(@PathVariable String memberEmail) {
		return memberDao.slelctOne(memberEmail);
	}
	
	@GetMapping("/membeNick/{memberNick}")
	public List<MemberDto> search(@PathVariable String memberNick){
		return memberDao.searchList(memberNick);
	}
	
	@PostMapping("/")
	public void insert(
			@Parameter(description = "생성할 회원명/타입/객체",
						required = true,
						schema = @Schema(implementation = MemberDto.class)
						)
			@RequestBody MemberDto memberDto) {
		memberDao.insert(memberDto);
	}
	//등록 매핑에 대한 설명용 annotation
		@Operation(
				description = "회원 신규 생성",
				responses = {
					@ApiResponse(
							responseCode = "200",
							description = "회원 생성 완료"
							),
					@ApiResponse(
							responseCode = "400",
							description = "전송한 파라미터가 서버에서 요구하는 값과 다름"
							),
					@ApiResponse(
							responseCode = "500",
							description = "서버 오류 발생"
							),
					}
				)
	
	
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
