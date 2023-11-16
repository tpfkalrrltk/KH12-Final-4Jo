package com.kh.EveryFit.service;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Repository;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.kh.EveryFit.vo.ChatRoomVO;

@Repository
public class ChannelServiceImpl implements ChannelService{
	private List<ChatRoomVO> roomList = new CopyOnWriteArrayList<>();
	
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
	
	@Override
	public void enterUser(WebSocketSession session, Integer chatRoomNo) {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) {//없으면
			room = createRoom(chatRoomNo); //만들고
		}
		room.enter(session);
	}
	@Override
	public void exitUser(WebSocketSession session, Integer chatRoomNo) {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) return;
		
		room.exit(session);
	}
	
	@Override
	public void sendMessage(WebSocketSession session, Integer chatRoomNo, TextMessage message) throws IOException {
		ChatRoomVO room = findRoom(chatRoomNo);
		if(room == null) return;
		
		room.send(message);
	}

}

