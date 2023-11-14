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
       // 특정 채팅방으로 이동하는 로직을 추가

       // 여기서 chatRoomNo를 사용하여 채팅방 정보를 조회(단일)
		//채팅방 정보를 넣을 일이 없음..! 그냥 전달해주면됨

       // 모델에 채팅방 정보 추가
       model.addAttribute("chatRoomNo", chatRoomNo);
       
       //해당 채팅방의 메세지 이력을 조회
//       List<ChatDto> chatHistory = chatDao.getChatHistory(chatRoomNo);
//       model.addAttribute("chatHistory", chatHistory);

		return "ws/default";
	}

}
