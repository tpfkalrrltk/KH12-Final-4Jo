package com.kh.EveryFit.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dto.ChatDto;
import com.kh.EveryFit.service.ChannelService;
import com.kh.EveryFit.vo.ChatRoomVO;
import com.kh.EveryFit.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatWebsocketServer extends TextWebSocketHandler {
	
	private ChatRoomVO waitingRoom = new ChatRoomVO();
	Set<ClientVO> members = new CopyOnWriteArraySet<>();
	
	@Autowired private ChannelService channelService;
	@Autowired private ObjectMapper mapper = new ObjectMapper(); 
	@Autowired private ChatDao chatDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		waitingRoom.enter(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		waitingRoom.exit(session);
		ClientVO client = new ClientVO(session);
		members.remove(client);
		log.debug("나감!");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//받은 메시지를 해석
		Map<String, Object> params = mapper.readValue(message.getPayload(), Map.class);
		//jsp onopen 이벤트에서 받은 chatRoomNo를 꺼내서 int로 변환 
		
		String chatRoomNoString = (String) params.get("chatRoomNo");
		Integer chatRoomNo = Integer.parseInt(chatRoomNoString);
		
		log.debug("chatRoomNo={}", chatRoomNo);
//		if(chatRoomNo == null) {
//			Integer newRoomNo = chatDao.sequence();
//			channelService.createRoom(newRoomNo);						
//		}
		
		ClientVO client = new ClientVO(session);
		
		boolean isJoin = params.get("type").equals("join");
		log.debug("isjoin? = {}", isJoin);
		if(isJoin) { //입장이면!
			
			//같은아이디면 차단
			
			members.add(client);
			log.debug("방에 입장");
			
			//memberEmail님이 입장하였습니다. 라는 문구를 띄우고싶음
		}
		log.debug("members = {}", members);			
		
		boolean isMessage = params.get("type").equals("message"); //메시지면
		log.debug("isMessage = {}", isMessage);
		
		
		if(isMessage) {
			Map<String, Object> map = new HashMap<>();
			map.put("memberEmail", client.getMemberEmail());
			map.put("content", params.get("content"));
			String messageJson = mapper.writeValueAsString(map);
			TextMessage tm = new TextMessage(messageJson);
			for(ClientVO c : members) {
				c.send(tm);
			}
			
		chatDao.insert(ChatDto.builder()
				.chatContent((String)params.get("content"))
				.chatRoomNo(chatRoomNo)
				.memberEmail(client.getMemberEmail())
				.build());
		}
		
		/*
		사용자가 보낸 메세지에 type이나 roomNo같은게 있어야 어떠한 처리가 가능하다
		if(type == 방입장) {
			channelService.enterUser(session, 방번호);
		}
		else if(type == 방퇴장) {
			channelService.exitUser(session, 방번호);
		}
		else if(type == 채팅) {
			channelService.sendMessage(session, 방번호, 메세지);
		}
		else if(type == DM) {
		
		}
		else if(type == 공지사항) {
		
		}
		else if(type == 파일) {
		
		}
		...
		 */
		
	}
	
}