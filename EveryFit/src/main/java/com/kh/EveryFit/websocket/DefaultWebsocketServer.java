package com.kh.EveryFit.websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
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
import com.kh.EveryFit.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 스프링에서 웹소켓 연결을 처리하는 도구(서버)
 * - 상속을 통해 구현
 * - 등록하여 사용
 */

@Slf4j
@Service
public class DefaultWebsocketServer extends TextWebSocketHandler {
	//사용자를 저장할 수 있는 저장소	
	//private Set<WebSocketSession> clients = new HashSet<>();//동기화 처리가 안되어 있음
	//private Set<WebSocketSession> clients = new CopyOnWriteArraySet<>();//동기화 처리 됨
	//	private Set<WebSocketSession> clients = Collections.synchronizedSet(new HashSet<>());
	private Set<ClientVO> clients = new CopyOnWriteArraySet<>();
	private Set<ClientVO> members = new CopyOnWriteArraySet<>(); //로그인한 회원
	//동기화된 저장소가 필요한데 이제 같은방 사람들을..다넣어주는코드...흠..
//	private Set<ClientVO> chatMembers  = new CopyOnWriteArraySet<>(); //같은방 회원
	private Map<String, Object> chatMembers = Collections.synchronizedMap(new HashMap<>());
	
	//JSON 변환기
	private ObjectMapper mapper = new ObjectMapper(); 
	
	@Autowired
	private ChatDao chatDao;
	
	//접속자 명단을 모든 접속자에게 전송하는 메소드
	public void sendClientList() throws IOException {
		//1. clients를 전송 가능한 형태(JSON 문자열)로 변환한다
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> data = new HashMap<>();
		data.put("clients", clients);
		String clientJson = mapper.writeValueAsString(data);
		
		//2. 모든 사용자에게 전송
		TextMessage message = new TextMessage(clientJson);
		for(ClientVO client : members) {
			client.send(message);
		}
	}
	
	//접속한 사용자에게 메세지 이력을 전송하는 메소드
	public void sendMessageList(ClientVO client) throws IOException {
		int chatRoomNo = 1;
		List<ChatDto> list = chatDao.list(chatRoomNo);
		
		for(ChatDto dto : list) {
			//dto의 내용을 메세지 형식으로 만들어서 전송
			//- dto에 chatReceiver가 있으면 DM, 없으면 DM이 아님
			//- 시간은 FE 미구현으로 첨부하지 않음
			
			Map<String, Object> map = new HashMap<>();
			if(dto.getChatMentionTarget() == null) {//전체채팅인경우
				map.put("content", dto.getChatContent());
				map.put("memberEmail", dto.getMemberEmail());
				String messageJson = mapper.writeValueAsString(map);
				TextMessage message = new TextMessage(messageJson);
				client.send(message);
			}
			else {//DM이라면
				if(client.isMember() == false) continue; //비회원 커트
				if(client.getMemberEmail().equals(dto.getMemberEmail()) == false &&
						client.getMemberEmail().equals(dto.getChatMentionTarget()) == false )
					continue;//작성자가 수신자가 아니면 커트
				if(client.getMemberEmail().equals(dto.getMemberEmail())) {//접속한 사람이 보낸 메세지라면
					map.put("content", dto.getChatContent());
					map.put("memberEmail", dto.getMemberEmail());
					map.put("dm", true);
					map.put("target", dto.getChatMentionTarget());
					String messageJson = mapper.writeValueAsString(map);
					TextMessage message = new TextMessage(messageJson);
					client.send(message);
				}
				else {//접속한 사람이 받은 메세지라면
					map.put("content", dto.getChatContent());
					map.put("memberEmail", dto.getMemberEmail());
					map.put("dm", true);
					String messageJson = mapper.writeValueAsString(map);
					TextMessage message = new TextMessage(messageJson);
					client.send(message);
				}
			}
						
			
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//사용자를 저장소에 추가하는 코드
		//clients.add(session);
		//접속한 사용자에게 현재시각을 전달
//		TextMessage message = new TextMessage(LocalDateTime.now().toString());
//		session.sendMessage(message);		
		ClientVO client = new ClientVO(session);
		clients.add(client);
		
		if(client.isMember()) {
			members.add(client);
//			if(client.isChatMember()) {
//				chatMembers.add(client);
//			}
//		    for (ClientVO otherClient : clients) { //반복문으로 지금  해당 client랑 다른 client들의 chatroomno를 비교해서 번호가 같으면 추가!
//		        if (client != otherClient && client.isInSameChatRoom(otherClient.getChatRoomNo())) {
//		            chatMembers.add(otherClient);
//		        }
//		    }
		}
		
		//모든 접속자에게 접속자 명단을 전송
		sendClientList();
		sendMessageList(client);
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//사용자를 저장소에서 제거하는 코드
		ClientVO client = new ClientVO(session);
		clients.remove(session);
		
		if(client.isMember()) {
			members.remove(client);
//			if(client.isChatMember()) {
//				chatMembers.remove(client);
//			}
		}	
		sendClientList();
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		사용자가 보낸 메세지를 처리하는 메소드
//		- 접속한 모든 사용자에게 메세지를 전달(브로드캐스트. broadcast)
		ClientVO client = new ClientVO(session);
		if(client.isMember() == false) return;
//		- (+추가) 사용자는 메세지를 JSON 형태로 보내므로 이를 해석해야 한다(ObjectMapper)
		Map params = mapper.readValue(message.getPayload(), Map.class);
		
		//DM일 경우와 아닐 경우 구분하여 처리
		boolean isDM = params.get("target") != null;
		if(isDM) {
			Map<String, Object> map = new HashMap<>();
			map.put("dm", true);
			map.put("memberEmail", client.getMemberEmail());
			map.put("content", params.get("content"));
			
			String messageJson = mapper.writeValueAsString(map);
			//메세지를 생성하여 변환된 내용을 담아 모든 사용자에게 전송
			TextMessage tm = new TextMessage(messageJson);
			for(ClientVO c : members) {
				if(c.getMemberEmail().equals(params.get("target"))) { //내가 찾던 사람이라면
					c.send(tm);//대상에게 메세지 전송			
				}
			}
			
			//수신자에게 target 항목을 추가하여 다시 메세지 전송
			map.put("target", params.get("target"));
			messageJson = mapper.writeValueAsString(map);
			tm = new TextMessage(messageJson);
			
			client.send(tm); //작성자에게 메세지 전송
			
			//DB insert (DM 경우 내용, 발신자, 발신자등급, 수신자를 저장)
			chatDao.insert(ChatDto.builder()
					.chatContent((String)params.get("content"))
					.chatRoomNo(1)
					.memberEmail(client.getMemberEmail())
					.chatMentionTarget((String)params.get("target"))
					.build());
		}
		else {//전체 채팅일 경우
			//메세지 전송 시 여러 정보를 JSON 문자열 형태로 변환하여 전송
			//자바에서 JSON을 생성하는 방법은 여러가지가 있다(Jackson, Gson, ...)
			//- 스프링 부트에 기본 탑재된 jackson-databind의 도구를 사용하여 처리 (ObjectMapper)
			//FE에게 보낼 메세지 객체를 생성
			Map<String, Object> map = new HashMap<>();
			map.put("memberEmail", client.getMemberEmail());
			map.put("content", params.get("content"));
			//시간추가등
			//도구를 만들어 JSON으로 변환
			
			String messageJson = mapper.writeValueAsString(map);
			//메세지를 생성하여 변환된 내용을 담아 모든 사용자에게 전송
			TextMessage tm = new TextMessage(messageJson);
			for(ClientVO c : members) {
				c.send(tm);
			}
			//DB insert (전체메세지일 경우 내용, 발신자, 발신자등급을 저장)
			chatDao.insert(ChatDto.builder()
					.chatContent((String)params.get("content"))
					.chatRoomNo(1)
					.memberEmail(client.getMemberEmail())
					.build());
		}

	}

}
