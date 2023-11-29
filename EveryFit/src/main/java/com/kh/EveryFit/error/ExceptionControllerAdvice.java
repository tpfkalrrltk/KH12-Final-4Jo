package com.kh.EveryFit.error;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;



import lombok.extern.slf4j.Slf4j;


@RestControllerAdvice(basePackages = {"com.kh.EveryFit.restcontroller"})
//@RestControllerAdvice(annotations = {RestController.class})
public class ExceptionControllerAdvice {
	
	//[1] NoTargetException이 발생하면 사용자에게 404를 반환
	@ExceptionHandler(NoTargetException.class)
	public ResponseEntity<?> error404(Exception e) {

		return ResponseEntity.notFound().build();
	}
	
	//[2] 그 외 예외가 발생하면 사용자에게 500을 반환
	@ExceptionHandler(Exception.class)
	public ResponseEntity<String> error500(Exception e) {

		return ResponseEntity.internalServerError().body("server error");
	}
	
	@ExceptionHandler(AuthorityException.class)
	public String authority(AuthorityException e) {
		e.printStackTrace();
		return "/error/MemberBlockException";
	}
	
}