package com.kh.EveryFit.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.EveryFit.websocket.ChatWebsocketServer;

//이 클래스는 생성한 웹소켓 서버를 어떤 주소에 할당하도록 설정하는 역할을 한다
@Configuration
@EnableWebSocket
public class WebsocketServerConfiguration implements WebSocketConfigurer {

	@Autowired
	private ChatWebsocketServer chatWebSocketServer;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		//등록할 때는 주소와 도구를 연결해야 한다(필요하다면 추가 옵션 설정)
		//(주의) 절대로 화면의 주소와 겹치면 안된다
		//아래와 같이 등록하면 HttpSession의 정보를 WebSocketSession으로 옮겨준다
		//SockJS를 사용하는 웹소켓 서버는 뒤에 추가적인 설정을 해야 한다.
		//- 클라이언트도 이 웹소켓 서버에 연결하려면 SockJS를 사용해야 한다
		registry.addHandler(chatWebSocketServer, "/ws/default")
					.addInterceptors(new HttpSessionHandshakeInterceptor())
					.withSockJS();
//		.setAllowedOrigins("*")
	}

}
