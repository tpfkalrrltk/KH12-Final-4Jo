package com.kh.EveryFit.vo;

import java.sql.Timestamp;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

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

}
