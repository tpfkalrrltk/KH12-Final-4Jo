package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.ChatDto;
import com.kh.EveryFit.dto.ChatEntryDto;

@Repository
public class ChatDaoImpl implements ChatDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ChatDto dto) {
		sqlSession.insert("chat.add", dto);
	}
	
	@Override
	public List<ChatDto> list(int chatRoomNo, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("chatRoomNo", chatRoomNo);
		return sqlSession.selectList("chat.list", params);
	}
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("chat.sequence");
	}
	
	@Override
	public void insertChatRoom(int chatRoomNo) {
		sqlSession.insert("chat.createChatRoom", chatRoomNo);
	}
	
	@Override
	public void addChatMember(Integer chatRoomNo, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("chatRoomNo", chatRoomNo);
		sqlSession.insert("chat.addChatMember", params);
	}
	
	@Override
	public List<Integer> selectChatRoomNoList(String memberEmail) {
		return sqlSession.selectList("chat.chatRoomNoByMemberEmail", memberEmail);
	}
	
	@Override
	public boolean deleteChatMember(Integer chatRoomNo, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("chatRoomNo", chatRoomNo);
		return sqlSession.delete("chat.deleteChatMember", params)>0;
	}


	
	@Override
	public ChatEntryDto checkChatEntry(int chatRoomNo, String memberEmail) {
		Map<String, Object>param = Map.of("chatRoomNo", chatRoomNo, "memberEmail", memberEmail);
		return sqlSession.selectOne("chat.checkChatEntry", param);
	}
}

