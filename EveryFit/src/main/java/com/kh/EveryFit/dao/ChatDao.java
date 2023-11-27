package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.ChatDto;

public interface ChatDao {

	//채팅메시지 저장
	void insert(ChatDto dto);
	//채팅 목록
	List<ChatDto> list(int chatRoomNo, String memberEmail);
	//방번호시퀀스
	int sequence();
	//채팅방만들기
	void insertChatRoom(int chatRoomNo);
	//채팅참가자 추가
	void addChatMember(Integer chatRoomNo, String memberEmail);
	//채팅참가자 삭제
	boolean deleteChatMember(Integer chatRoomNo, String memberEmail);
	//채팅방정보조회
	List<Integer> selectChatRoomNoList(String memberEmail);
	
}