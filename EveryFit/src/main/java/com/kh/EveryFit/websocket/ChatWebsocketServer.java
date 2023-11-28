package com.kh.EveryFit.websocket;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
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
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.ChatDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimMemberDto;
import com.kh.EveryFit.service.ChannelService;
import com.kh.EveryFit.vo.ChatListVO;
import com.kh.EveryFit.vo.ChatRoomVO;
import com.kh.EveryFit.vo.ClientVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatWebsocketServer extends TextWebSocketHandler {
	
	private ChatRoomVO waitingRoom = new ChatRoomVO();
//	private ChatRoomVO room = new ChatRoomVO();
	private Set<ClientVO> members = new CopyOnWriteArraySet<>();
	
	@Autowired private ChannelService channelService;
	@Autowired private ObjectMapper mapper = new ObjectMapper(); 
	@Autowired private ChatDao chatDao;
	@Autowired private MemberDao memberDao;
	@Autowired private MoimDao moimDao;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		ClientVO clientVO = new ClientVO(session);
		waitingRoom.enter(clientVO);
//		MemberDto memberDto = memberDao.selectOne(clientVO.getMemberEmail());
//		if(memberDto != null) {
//			clientVO.setMemberNick(memberDto.getMemberNick());
//		}
////		members.add(clientVO);
//		room.enter(clientVO);
//		sendClientList();
//		TextMessage message = new TextMessage(LocalDateTime.now().toString());	
//		session.sendMessage(message);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		waitingRoom.exit(session);
		ClientVO client = new ClientVO(session);
		members.remove(client);
		log.debug("나감!");
//		sendClientList();
	}
	
	//접속자명단을 모든 접속자에게 전송하는 메소드
//	public void sendClientList() throws IOException {
		//1. clients를 전송 가능한 형태(JSON 문자열)로 변환한다
//		ObjectMapper mapper = new ObjectMapper();
		
		
//		MemberDto memberDto = memberDao.selectOne(client.getMemberEmail());
//		ChatMemberVO chatMemberVO = new ChatMemberVO();
//		chatMemberVO.setMemberNick(memberDto.getMemberNick());
//		Integer attachNo = memberDao.findProfile(client.getMemberEmail());
//		if(memberDto != null) {
//
//		}
//		members.add(client);
//		Map<String, Object> data = new HashMap<>();
//		//data.put("clients", clients);//전체회원명단(null이 문제가됨)
//		data.put("clients", members);//로그인한 회원명단
//		String clientJson = mapper.writeValueAsString(data);
//		log.debug("clientJson = {}", clientJson);
//		
//		//2. 모든 사용자에게 전송
//		TextMessage message = new TextMessage(clientJson);
//		for(ClientVO client : members) {
//			client.send(message);
//		}

		
//	}
	
	//채팅이력을보내줌
//	public void sendMessageList(ClientVO client) throws IOException {
//		
//	}

	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//받은 메시지를 해석
		Map<String, Object> params = mapper.readValue(message.getPayload(), Map.class);
		//jsp onopen 이벤트에서 받은 chatRoomNo를 꺼내서 int로 변환 
		
		String chatRoomNoString = (String) params.get("chatRoomNo");
		Integer chatRoomNo = Integer.parseInt(chatRoomNoString);
		
		log.debug("chatRoomNo={}", chatRoomNo);
		
		ClientVO client = new ClientVO(session);
		
		MemberDto memberDto = memberDao.selectOne(client.getMemberEmail());
//		ChatMemberVO chatMemberVO = new ChatMemberVO();
//		chatMemberVO.setMemberNick(memberDto.getMemberNick());
		Integer attachNo = memberDao.findProfile(client.getMemberEmail());
		if(memberDto != null) {
			client.setMemberNick(memberDto.getMemberNick());
			client.setAttachNo(attachNo);
		}
		
		members.add(client);
//		sendClientList();
//		room.enter(client);
		
		//세션값으로 
		Integer moimNo = chatDao.selectOneMoimNo(chatRoomNo);
			
		ChatListVO vo = new ChatListVO();
		MoimMemberDto moimMemberDto = moimDao.findMoimMemberInfo(client.getMemberEmail(), moimNo);			
        
		if(moimMemberDto == null) {
	        vo.setChatRoomNo(chatRoomNo);
		}
		else {
			Date moimMemberJoin = moimMemberDto.getMoimMemberJoin();		
			
			SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String moimMemberJoinString = dateFormat1.format(moimMemberJoin);
			
			vo.setChatRoomNo(chatRoomNo);
			vo.setMoimMemberJoin(moimMemberJoinString);			
		}
		
        
		boolean isJoin = params.get("type").equals("join");
		log.debug("isjoin? = {}", isJoin);
		
//		channelService.findRoom(chatRoomNo);
		channelService.enterUser(client, chatRoomNo);
		
		if(isJoin) { //입장이면!
			channelService.sendUserList(message, chatRoomNo);
			
			//모임챗방이면~~
//			log.debug("client = {}",client.getMemberEmail());
			List<ChatDto> list = chatDao.list(vo);				
			
			
//			log.debug("list={}", list);
			for(ChatDto dto : list) {
				Map<String, Object> map = new HashMap<>();
				Date chatTime = dto.getChatTime();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String formattedChatTime = dateFormat.format(chatTime);
				map.put("content", dto.getChatContent());
				map.put("memberEmail", dto.getMemberEmail());
				map.put("memberNick", dto.getMemberNick());
				map.put("chatTime", formattedChatTime);
				map.put("attachNo", dto.getAttachNo());
				String messageJson = mapper.writeValueAsString(map);
				TextMessage mss = new TextMessage(messageJson);
				client.send(mss);
			}
			log.debug("방에 입장");
			//아니면~~
			
		}
		
		
		boolean isMessage = params.get("type").equals("message"); //메시지면
		log.debug("isMessage = {}", isMessage);
		
		//메시지면!
		if(isMessage) {
			
			Map<String, Object> map = new HashMap<>();
			    map.put("memberEmail", client.getMemberEmail());
			    map.put("memberNick", client.getMemberNick());
			    map.put("attachNo", client.getAttachNo());
			    map.put("content", params.get("content"));
			    map.put("chatTime", getCurrentTime());  // 현재 시간 추가
			    log.debug("map={}", map);
			    String messageJson = mapper.writeValueAsString(map);
			    TextMessage tm = new TextMessage(messageJson);
//			    for (ClientVO members : ) {
//			    members.send(tm);
//			    }	
			    channelService.sendMessage(chatRoomNo, tm, map);
			
			    chatDao.insert(ChatDto.builder()
				.chatContent((String)params.get("content"))
				.chatRoomNo(chatRoomNo)
				.memberEmail(client.getMemberEmail())
				.build());
		}
//		sendClientList();
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
	private String getCurrentTime() {
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    return LocalDateTime.now().format(formatter);
	}

}