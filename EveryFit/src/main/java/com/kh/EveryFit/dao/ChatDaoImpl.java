package com.kh.EveryFit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.ChatDto;

@Repository
public class ChatDaoImpl implements ChatDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ChatDto dto) {
		sqlSession.insert("chat.add", dto);
	}
	
	@Override
	public List<ChatDto> list(int chatRoomNo) {
		return sqlSession.selectList("chat.list", chatRoomNo);
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
	public void addChatMember(int chatRoomNo, String memberEmail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberEmail", memberEmail);
		params.put("chatRoomNo", chatRoomNo);
		sqlSession.insert("chat.addChatMember", params);
	}
}
