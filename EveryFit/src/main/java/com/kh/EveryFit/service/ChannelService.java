package com.kh.EveryFit.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.kh.EveryFit.vo.ChatRoomVO;
import com.kh.EveryFit.vo.ClientVO;

public interface ChannelService {

	ChatRoomVO createRoom(Integer chatRoomNo);
	void deleteRoom(Integer chatRoomNo);
	ChatRoomVO findRoom(Integer chatRoomNo);
	void enterUser(ClientVO vo, Integer chatRoomNo);
	void exitUser(WebSocketSession session, Integer chatRoomNo);
	void sendMessage(WebSocketSession session, Integer chatRoomNo, TextMessage message,  Map<String, Object> params) throws IOException;
	//해당 채팅방의 대화이력을 전송
	void sendMessageList(Integer chatRoomNo, TextMessage message) throws JsonProcessingException, IOException;
}
