package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.EveryFit.dao.ChatDao;

@Controller
@RequestMapping("/")
public class WebsocketViewController {
	
	@Autowired private ChatDao chatDao;
	
	@RequestMapping("/default/{chatRoomNo}")
	public String defaultServer(@PathVariable int chatRoomNo, Model model) {
		return "ws/default";
	}

}
