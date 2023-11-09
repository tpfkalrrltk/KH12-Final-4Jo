package com.kh.EveryFit.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AttachDto {
    private int attachNo;
    private String attachName;
    private long attachSize;
    private String attachType;
    private String attachTime;
}
