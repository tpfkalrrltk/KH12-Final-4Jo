package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MoimDto {
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
    private Date moimEndTime;
    
    private boolean image;
}
