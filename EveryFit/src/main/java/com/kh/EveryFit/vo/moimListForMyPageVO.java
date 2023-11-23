package com.kh.EveryFit.vo;

import java.sql.Date;

import com.kh.EveryFit.dto.MoimDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class moimListForMyPageVO {
    private int moimNo;
    private int locationNo;
    private int eventNo;
    private String moimTitle;
    private String moimContent;
    private Date moimTime;
    private String moimUpgrade;
    private String moimState;
    private int moimMemberCount;
    private String moimGenderCheck;
    private int chatRoomNo;
    private String moimMemberLevel;
    private String moimMemberStatus;
    private Date moimMemberJoin;
    
    private boolean image;
}
