package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MoimMemberDto {
    private String memberEmail;
    private String moimNo;
    private String moimMemberLevel;
    private String moimMemberStatus;
}
