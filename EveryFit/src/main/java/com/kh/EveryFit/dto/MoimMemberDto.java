package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MoimMemberDto {
    private String memberEmail;
    private int moimNo;
    private String moimMemberLevel;
    private String moimMemberStatus;
    private int moimMemberCancelCount;
    private String memberNick;
    private String memberBlock;
    private Integer attachNo;
    private Date moimMemberJoin;
}
