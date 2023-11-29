package com.kh.EveryFit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dto.ChatEntryDto;

import lombok.extern.slf4j.Slf4j;

@Component
public class WebSocketServerInterceptor implements HandlerInterceptor {
	
	@Autowired private ChatDao chatDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberEmail = (String) session.getAttribute("name");
		
		//채팅방번호랑 Email번호로 해당 방의 참가자인지 조회하기
	    // 채팅방 번호를 추출
	    String requestURI = request.getRequestURI();
	    String[] parts = requestURI.split("/");
	    if (parts.length >= 3 && parts[1].startsWith("default")) {
	    	String chatRoomNumber = parts[2];

	    	    int chatRoomNo = Integer.parseInt(chatRoomNumber);
	    	    // chatRoomNo를 사용할 수 있습니다.
	    	    System.out.println("채팅방 번호 (int): " + chatRoomNo);

	        // 여기에서 chatRoomNumber를 사용할 수 있습니다.
	        System.out.println("채팅방 번호: {} " + chatRoomNo);
	        
	        ChatEntryDto chatEntryDto = chatDao.checkChatEntry(chatRoomNo, memberEmail);
	        if(chatEntryDto != null) {
	        	return true;
	        }
	        response.sendRedirect("/error/AuthorityException");	        
	        return false;
	    }
		
		
	    response.sendRedirect("/error/AuthorityException");
		return false;
	}
}
