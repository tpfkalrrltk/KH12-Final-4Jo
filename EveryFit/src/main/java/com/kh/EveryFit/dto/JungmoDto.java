package com.kh.EveryFit.dto;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

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
    private Timestamp jungmoSchedule;
    private String jungmoStatus;
    private int chatRoomNo;
    private String memberNick;
    
    public void setJungmoSchedule(java.sql.Timestamp timestamp) {
        this.jungmoSchedule = timestamp;
    }
    
    
}
