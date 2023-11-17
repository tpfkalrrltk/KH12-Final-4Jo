package com.kh.EveryFit.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MoimTitleForPaymentVO {
	private String memberEmail;
    private String moimNo;
    private String moimMemberLevel;
    private String moimMemberStatus;
    private String moimTitle;
}
