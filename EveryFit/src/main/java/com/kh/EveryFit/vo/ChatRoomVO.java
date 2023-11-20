package com.kh.EveryFit.vo;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data @NoArgsConstructor @AllArgsConstructor @Builder
//@ToString(of = {"chatRoomNo", "clientList"}) // 출력할 때 작성한 항목만 출력해라!
public class ChatRoomVO {
	
    private Integer chatRoomNo;
    @Builder.Default
    private Set<ClientVO> members = new CopyOnWriteArraySet<>();

    //수정 전
//    public void enter(WebSocketSession session) {
//    	ClientVO client = new ClientVO(session);
//    	members.add(client);
//	}
    public void enter(ClientVO client) {
    	members.add(client);
    }
	public void exit(WebSocketSession session) {
		members.remove(session);
	}
	public void send(TextMessage message) throws IOException {
		for(ClientVO member : members) {
			member.send(message);
		}
	}
}
