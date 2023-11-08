package com.kh.EveryFit.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class JungmoDto {
    private int jungmoNo;
    private int moimNo;
    private String jungmoTitle;
    private String jungmoAddr;
    private String jungmoAddrLink;
    private int jungmoCapacity;
    private int jungmoPrice;
    private Date jungmoSchedule;
    private String jungmoStatus;
    private int chatRoomNo;
}
