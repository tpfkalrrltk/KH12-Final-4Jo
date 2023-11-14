package com.kh.EveryFit.vo;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KakaoPayCancelResponseInPeriodVO {
    private String cid; // 가맹점 코드, 20자
    private String sid; // 정기 결제 고유 번호, 10자
    private String status; // 결제 상태
    private Date createdAt; // SID 발급 시각
    private Date lastApprovedAt; // 마지막 결제승인 시각
    private Date inactivatedAt; // 정기 결제 비활성화 시각
}
