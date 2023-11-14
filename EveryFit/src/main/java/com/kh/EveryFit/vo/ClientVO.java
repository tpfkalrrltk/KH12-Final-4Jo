package com.kh.EveryFit.vo;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

// 웹소켓 통신에서 사용자를 조금 더 편하게 관리하기 위한 클래스
@Data
@EqualsAndHashCode(of = "session") //session필드가 동일하면 같은 객체라고 생각해라!
@ToString(of = {"memberEmail", "chatRoomNoList"}) // 출력할 때 작성한 항목만 출력해라!
public class ClientVO {
	
//	private transient WebSocketSession session;//입출력에서 이 필드는 제외한다 
	@JsonIgnore //Json으로 변환하는 과정에서 이 필드는 제외한다
	private WebSocketSession session; 
	private String memberEmail;
	private int chatRoomNo;
	//일단 세션에 저장해서...써보자!(아직 테이블 추가 안했음)

	public ClientVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.memberEmail = (String) attr.get("name");
	        
	        // chatRoomNoList에서 원하는 값을 꺼내 사용
//	        if (chatRoomNoList != null && !chatRoomNoList.isEmpty()) {
//	            this.chatRoomNo = chatRoomNoList.get(0);
//	        }
	}
	
	
	public boolean isMember() {
		return memberEmail != null;
	}
	
//	public boolean isChatMember() {
//		//번호가 있으면?
//		return chatRoomNo > 0;
//	}
	
	public void send(TextMessage message) throws IOException {
		session.sendMessage(message);
	}
}
