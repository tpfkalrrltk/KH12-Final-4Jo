package com.kh.EveryFit.vo;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

// 웹소켓 통신에서 사용자를 조금 더 편하게 관리하기 위한 클래스
@Data
@EqualsAndHashCode(of = "session") //session필드가 동일하면 같은 객체라고 생각해라!
@ToString(of = {"memberEmail", "memberLevel", "memberNick", "attachNo"}) // 출력할 때 작성한 항목만 출력해라!
public class ClientVO {

	@Autowired
	
//	private transient WebSocketSession session;//입출력에서 이 필드는 제외한다 
	@JsonIgnore //Json으로 변환하는 과정에서 이 필드는 제외한다
	private WebSocketSession session; 
	private String memberEmail;
	private String memberLevel;
	private String memberNick;
	private Integer attachNo;
	
	public ClientVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.memberEmail = (String) attr.get("name");
		this.memberLevel = (String) attr.get("level");	
	}
	
	
	public boolean isMember() {
		return memberEmail != null;
	}
	
	public void send(TextMessage message) throws IOException {
		session.sendMessage(message);
	}
}
