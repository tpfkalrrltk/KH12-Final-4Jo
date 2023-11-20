package com.kh.EveryFit.vo;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JungmoListVO {
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
    private Integer jungmoImageAttachNo;
    private Integer memberCount;

    private long dday; // D-day를 저장할 필드

    public long getDday() {
        return dday;
    }

    public void calculateDday() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime jungmoDateTime = jungmoSchedule.toLocalDateTime();

        // 현재 날짜와 정모 일정 날짜 사이의 일 수 계산
        dday = ChronoUnit.DAYS.between(now, jungmoDateTime);
    }

}
