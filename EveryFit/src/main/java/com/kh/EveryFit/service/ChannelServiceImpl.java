package com.kh.EveryFit.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dto.ChatDto;
import com.kh.EveryFit.vo.ChatRoomVO;
import com.kh.EveryFit.vo.ClientVO;

@Repository
public class ChannelServiceImpl implements ChannelService{
	private List<ChatRoomVO> roomList = new CopyOnWriteArrayList<>();
	@Autowired private ChatDao chatDao;
	private ObjectMapper mapper = new ObjectMapper(); 
	
	//CRUD를 여기서 구현
	
	//채널을 관리하는 기능을 추가
	//- 방 생성 / 삭제
	//- 방에 사용자 입장 / 제거
	//- 방 검색
	@Override
	public ChatRoomVO createRoom(Integer chatRoomNo) {
		ChatRoomVO room = ChatRoomVO.builder().chatRoomNo(chatRoomNo).build();
		roomList.add(room);
		return room;
	}

	@Override
	public void deleteRoom(Integer chatRoomNo) {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room != null) {
			roomList.remove(room);
		}
	}
	
	@Override
	public ChatRoomVO findRoom(Integer chatRoomNo) {
		for(ChatRoomVO room : roomList) {
			if(room.getChatRoomNo() == chatRoomNo) {
				return room;
			}
		}
		return null;
	}
	//수정 전
//	@Override
//	public void enterUser(WebSocketSession session, Integer chatRoomNo) {
//		ChatRoomVO room = findRoom(chatRoomNo);
//		if(room == null) {//없으면
//			room = createRoom(chatRoomNo); //만들고
//		}
//		room.enter(session);
//	}
	@Override
	public void enterUser(ClientVO client, Integer chatRoomNo) {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) {//없으면
			room = createRoom(chatRoomNo); //만들고
		}
		room.enter(client);
	}
	@Override
	public void exitUser(WebSocketSession session, Integer chatRoomNo) {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) return;
		
		room.exit(session);
	}
	
	@Override
	public void sendMessage(Integer chatRoomNo, TextMessage message, Map<String, Object> params) throws IOException {
		ChatRoomVO room = findRoom(chatRoomNo);
//		ClientVO members = new ClientVO();
//		room.enter(session);
		if(room == null) return;
		
		List<Map<String, Object>> clientInfoList = new ArrayList<>();
		
	    // 각 클라이언트 정보를 리스트에 추가
	    for (ClientVO client : room.getMembers()) {
	        Map<String, Object> clientInfo = new HashMap<>();
	        clientInfo.put("memberEmail", client.getMemberEmail());
	        clientInfo.put("memberNick", client.getMemberNick());
	        clientInfo.put("attachNo", client.getAttachNo());
	        clientInfoList.add(clientInfo);
	    }
	    // 메시지에 클라이언트 정보 추가
	    Map<String, Object> messageData = new HashMap<>();
	    messageData.put("clients", clientInfoList);
	    messageData.put("content", params.get("content"));
	    String messageJson = mapper.writeValueAsString(messageData);
	    TextMessage tm = new TextMessage(messageJson);

	    // 모든 클라이언트에게 메시지 전송
	    for (ClientVO c : room.getMembers()) {
	        c.send(tm);
	    }

//		Map<String, Object> map = new HashMap<>();
//		map.put("memberEmail", room.members.getMemberEmail());
//		map.put("memberNick", client.getMemberNick());
//		map.put("content", params.get("content"));
//		String messageJson = mapper.writeValueAsString(map);
//		TextMessage tm = new TextMessage(messageJson);
//		for(ClientVO c : room.getMembers()) {
//			c.send(tm);
//		}
		
		room.send(message);
	}
	
	//채팅방에 대화이력을 보내는 메소드(구현중)
	@Override
	public void sendMessageList(ClientVO client, Integer chatRoomNo, TextMessage message) throws IOException {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) return;
		
		
	    List<ChatDto> list = chatDao.list(chatRoomNo, client.getMemberEmail());
	    List<Map<String, Object>> chatHistory = new ArrayList<>();

	    for (ChatDto dto : list) {
	        Map<String, Object> chatInfo = new HashMap<>();
	        chatInfo.put("content", dto.getChatContent());
	        chatInfo.put("memberEmail", dto.getMemberEmail());
	        chatHistory.add(chatInfo);
	    }

	    Map<String, Object> messageData = new HashMap<>();
	    messageData.put("chatHistory", chatHistory);
	    String messageJson = mapper.writeValueAsString(messageData);
	    TextMessage tm = new TextMessage(messageJson);

	    // 채팅 방에 대화 이력 전송
	    room.send(tm);
	
//		List<ChatDto> list = chatDao.list(chatRoomNo);
//		for(ChatDto dto : list) {
//			Map<String, Object> map = new HashMap<>();
//			map.put("content", dto.getChatContent());
//			map.put("memberEmail", dto.getMemberEmail());
//			String messageJson = mapper.writeValueAsString(map);
//			TextMessage mss = new TextMessage(messageJson);
//			room.send(mss);
//		}
	}
	
	@Override
	public void sendUserList(TextMessage message, Integer chatRoomNo) throws IOException {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) return;
		List<Map<String, Object>> clientInfoList = new ArrayList<>();
		
	    // 각 클라이언트 정보를 리스트에 추가
	    for (ClientVO client : room.getMembers()) {
	        Map<String, Object> clientInfo = new HashMap<>();
	        clientInfo.put("memberEmail", client.getMemberEmail());
	        clientInfo.put("memberNick", client.getMemberNick());
	        clientInfo.put("attachNo", client.getAttachNo());
	        clientInfoList.add(clientInfo);
	    }
	    // 메시지에 클라이언트 정보 추가
	    Map<String, Object> messageData = new HashMap<>();
	    messageData.put("clients", clientInfoList);
	    String messageJson = mapper.writeValueAsString(messageData);
	    TextMessage tm = new TextMessage(messageJson);

	    // 모든 클라이언트에게 메시지 전송
	    for (ClientVO c : room.getMembers()) {
	        c.send(tm);
	    }
		room.send(message);
	}

}

