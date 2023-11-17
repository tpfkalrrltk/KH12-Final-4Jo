package com.kh.EveryFit.configuration;


import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

//목표 : empty String을 컨트롤러가 null로 해석하도록 설정
@ControllerAdvice
public class EmptyStringControllerAdvice {

	@InitBinder
	public void customBinding(WebDataBinder binder) {
	//	binder.registerCustomEditor(자료형, 처리도구);
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}
}
