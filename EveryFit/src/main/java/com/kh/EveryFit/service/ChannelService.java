package com.kh.EveryFit.service;

import java.io.IOException;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.kh.EveryFit.vo.ChatRoomVO;

public interface ChannelService {

	ChatRoomVO createRoom(Integer chatRoomNo);
	void deleteRoom(Integer chatRoomNo);
	ChatRoomVO findRoom(Integer chatRoomNo);
	void enterUser(WebSocketSession session, Integer chatRoomNo);
	void exitUser(WebSocketSession session, Integer chatRoomNo);
	void sendMessage(WebSocketSession session, Integer chatRoomNo, TextMessage message) throws IOException;
	
}
