package com.kh.EveryFit.vo;

import java.sql.Timestamp;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
//@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
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
