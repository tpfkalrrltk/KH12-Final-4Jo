package com.kh.EveryFit.vo;

import com.kh.EveryFit.dto.JungmoDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class JungmoDetailVO {
	private JungmoDto jungmoDto;
    //프로필번호 추가
    private int attachNo;
    
}
