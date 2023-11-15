package com.kh.EveryFit.websocket;

import java.io.IOException;
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
//	private Set<ClientVO> clients = new CopyOnWriteArraySet<>();
	private Set<ClientVO> members = new CopyOnWriteArraySet<>(); //로그인한 회원
	private Map<Integer, Set<ClientVO>> roomMembers = new ConcurrentHashMap<>(); // 채팅방 멤버, 채팅방 번호를 키로 사용
	//JSON 변환기
	private ObjectMapper mapper = new ObjectMapper(); 
	
	@Autowired private ChatDao chatDao;
	
	//접속자 명단을 모든 접속자에게 전송하는 메소드
	public void sendClientList() throws IOException {
		//1. clients를 전송 가능한 형태(JSON 문자열)로 변환한다
		ObjectMapper mapper = new ObjectMapper();
//		Map<String, Object> data = new HashMap<>();
		//members가 아니라 ClientVO의 멤버를 넣어야 함...
//		data.put("members", members);
//		String clientJson = mapper.writeValueAsString(data);
		
	    //Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);

//	    if (roomMembers != null) {.
//	        List<String> memberEmails = new ArrayList<>();
//	        for (ClientVO member : roomMembers) {
//	            memberEmails.add(member.getMemberEmail());
//	        }

        Map<String, Object> data = new HashMap<>();
//	        data.put("members", memberEmails);
        String clientJson = mapper.writeValueAsString(data);
		
		
		//2. 모든 사용자에게 전송
		TextMessage message = new TextMessage(clientJson);
		for(ClientVO members : members) {
			members.send(message);
		}
	}
	
	//접속한 사용자에게 메세지 이력을 전송하는 메소드
	public void sendMessageList(ClientVO client) throws IOException {
		
		//방번호를 어떻게아냐
		List<ChatDto> list = chatDao.list(1);
		
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
//		clients.add(session);
		//접속한 사용자에게 현재시각을 전달
//		TextMessage message = new TextMessage(LocalDateTime.now().toString());
//		session.sendMessage(message);		
		ClientVO client = new ClientVO(session);
//		clients.add(client);
		
		//여기에서 session 회원의 기존방정보를 불러 미리 준비함(뭘준비해)
		//session의 방번호 조회
//		String memberEmail = client.getMemberEmail();
//		List<Integer> chatRoomList = chatDao.selectChatRoomNoList(memberEmail);
//		log.debug("chatRoomList = {}", chatRoomList);
//		for (Integer chatRoomNo : chatRoomList) {
	        // roomMembers 맵에서 해당 채팅방 번호에 대한 Set을 가져오거나 없으면 새로 생성
//		Set<ClientVO> roomMembersSet = 
//	        		roomMembers.computeIfAbsent(client.getChatRoomNo(), k -> ConcurrentHashMap.newKeySet());
	        
	        // 클라이언트 정보를 해당 채팅방의 멤버로 추가
//	        roomMembersSet.add(client);
	        // 수정: roomMembers 맵에 저장
//	        roomMembers.put(chatRoomNo, roomMembers);
//		}
		
//		roomMembers.put(client.getChatRoomNo());
//		Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
//	    log.debug("roomMembers for chatRoomNo {}: {}", chatRoomNo, roomMembers);
//		log.debug("roomMemebers={}", roomMembers);
		
//		if(client.isMember()) {
			members.add(client);
//		}
				
//		Integer chatRoomNo = client.getChatRoomNo();
		//여기의 chatRoomNo는 jsp파라미터로 값을 받아와야 함?????
//		addRoomMember(client	, client.getChatRoomNo());
		//모든 접속자에게 접속자 명단을 전송
		sendClientList();
//		sendMessageList(client);
		
	}
	
   // 채팅방 멤버 추가
//   public void addRoomMember(ClientVO client, Integer chatRoomNo) {
//	Set<ClientVO> roomMembers = roomMembersMap.computeIfAbsent(chatRoomNo, k -> new HashSet<>());
//       roomMembers.add(client);
//       log.debug("채팅방 멤버 추가 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
//   }
 
   // 채팅방 멤버 제거
//   public void removeRoomMember(ClientVO client, Integer chatRoomNo) {
//       Set<ClientVO> roomMembers = roomMembersMap.get(chatRoomNo);
//       if (roomMembers != null) {
//           roomMembers.remove(client);
//           log.debug("채팅방 멤버 제거 - 채팅방 번호: {}, 멤버 수: {}", chatRoomNo, roomMembers.size());
//       }
//   }

	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//사용자를 저장소에서 제거하는 코드
		ClientVO client = new ClientVO(session);
//		clients.remove(session);
//		members.remove(session);
		log.debug("종료!");
		sendClientList();
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		사용자가 보낸 메세지를 처리하는 메소드
//		- 접속한 모든 사용자에게 메세지를 전달(브로드캐스트. broadcast)
		ClientVO client = new ClientVO(session);
//		if(client.isMember() == false) return;
//		- (+추가) 사용자는 메세지를 JSON 형태로 보내므로 이를 해석해야 한다(ObjectMapper)
		Map<String, Object> params = mapper.readValue(message.getPayload(), Map.class);
		log.debug("메시지={}", message.getPayload());
		log.debug("맵={}", params);
		//jsp onopen 이벤트에서 받은 chatRoomNo를 꺼내서 int로 변환 
		String chatRoomNoString = (String) params.get("chatRoomNo");
		Integer chatRoomNo = Integer.parseInt(chatRoomNoString);
//		if (chatRoomNoString != null) {
//		    try {
////		    	client.setChatRoomNo(chatRoomNo);
//		        log.debug("방번호 = {}", chatRoomNo);
//		    } catch (NumberFormatException e) {
//		        log.error("방번호를 정수로 변환할 수 없습니다.");
//		    }
//		} else {
//		    log.error("방번호가 null입니다.");
//		}
		
//		chatDao.addChatMember(chatRoomNo, client.getMemberEmail());
		
		//message 에서 type:join일 경우 입장메시지 보내기!
		//DM일 경우와 아닐 경우 구분하여 처리
//		boolean isDM = params.get("target") != null;
		
//		if(isDM) {
//			Map<String, Object> map = new HashMap<>();
//			map.put("dm", true);
//			map.put("memberEmail", client.getMemberEmail());
//			map.put("content", params.get("content"));
//			
//			String messageJson = mapper.writeValueAsString(map);
//			//메세지를 생성하여 변환된 내용을 담아 모든 사용자에게 전송
//			TextMessage tm = new TextMessage(messageJson);
//			for(ClientVO c : members) {
//				if(c.getMemberEmail().equals(params.get("target"))) { //내가 찾던 사람이라면
//					c.send(tm);//대상에게 메세지 전송			
//				}
//			}
//			
//			//수신자에게 target 항목을 추가하여 다시 메세지 전송
//			map.put("target", params.get("target"));
//			messageJson = mapper.writeValueAsString(map);
//			tm = new TextMessage(messageJson);
//			
//			client.send(tm); //작성자에게 메세지 전송
//			
//			//DB insert (DM 경우 내용, 발신자, 발신자등급, 수신자를 저장)
//			chatDao.insert(ChatDto.builder()
//					.chatContent((String)params.get("content"))
//					.chatRoomNo(chatRoomNo)
//					.memberEmail(client.getMemberEmail())
//					.chatMentionTarget((String)params.get("target"))
//					.build());
//		}
//		else {//전체 채팅일 경우
			//메세지 전송 시 여러 정보를 JSON 문자열 형태로 변환하여 전송
			//자바에서 JSON을 생성하는 방법은 여러가지가 있다(Jackson, Gson, ...)
			//- 스프링 부트에 기본 탑재된 jackson-databind의 도구를 사용하여 처리 (ObjectMapper)
			//FE에게 보낼 메세지 객체를 생성
			//message에 있는 chatRoomNo...로 방 입장 처리를 해야함...!!!!!!
			//여기에서 이제 map에다가 회원정보랑 방번호를 넣는건가??? 만약에 session에 있는 아!..!이해함....이제 위에서 입장처리 메소드에서
			
		//해당 session 아이디의 방번호를 조회해서 그 방번호들이 만약 지금 chatRoomNo랑 맞다면 메시지를 같이 보내줌?
//		String memberEmail = client.getMemberEmail();
		//이메일로 챗룸번호조회 그리고 리스트에 룸번호를 넣고 반복문으로 지금 챗룸넘버랑 같은 번호가 있는지 조회
		//그리고 같은번호가 있으면
		//clientList에 추가함
		
		members.add(client);
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberEmail", client.getMemberEmail());
		map.put("content", params.get("content"));
		//시간추가등
		//도구를 만들어 JSON으로 변환
			
			
		String messageJson = mapper.writeValueAsString(map);
		//메세지를 생성하여 변환된 내용을 담아 모든 사용자에게 전송
//			Set<ClientVO> roomMembers = roomMembersMap.get(client.getChatRoomNo());
		TextMessage tm = new TextMessage(messageJson);
		for(ClientVO c : members) {
			c.send(tm);
		}
		//DB insert (전체메세지일 경우 내용, 발신자, 발신자등급을 저장)
		chatDao.insert(ChatDto.builder()
				.chatContent((String)params.get("content"))
				.chatRoomNo(chatRoomNo)
				.memberEmail(client.getMemberEmail())
				.build());
	}



//	}
	

}
