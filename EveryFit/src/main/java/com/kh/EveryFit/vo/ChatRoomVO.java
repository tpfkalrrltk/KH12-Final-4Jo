package com.kh.EveryFit.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data @NoArgsConstructor @AllArgsConstructor @Builder
//@ToString(of = {"chatRoomNo", "clientList"}) // 출력할 때 작성한 항목만 출력해라!
public class ChatRoomVO {
	
	int chatRoomNo;
	List<ClientVO> clientList;
	
}
