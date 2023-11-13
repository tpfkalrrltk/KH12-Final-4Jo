package com.kh.EveryFit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class WebsocketViewController {
	
	@RequestMapping("/default")
	public String defaultServer() {
		return "ws/default";
	}
	
}
