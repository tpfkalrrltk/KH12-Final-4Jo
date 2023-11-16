package com.kh.EveryFit.service;

import java.net.URISyntaxException;

import com.kh.EveryFit.vo.KakaoPayApproveRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayApproveRequestVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.KakaoPayCancelRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayCancelRequestVO;
import com.kh.EveryFit.vo.KakaoPayCancelResponseInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayCancelResponseVO;
import com.kh.EveryFit.vo.KakaoPayReadyRequestVO;
import com.kh.EveryFit.vo.KakaoPayReadyResponseVO;


public interface KakaoPayService {
	//단건결제
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request) throws URISyntaxException;
	//정기결제
	KakaoPayReadyResponseVO periodReady(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO periodApprove(KakaoPayApproveRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO period2Approve(KakaoPayApproveRequestInPeriodVO request) throws URISyntaxException;
	
	//취소//비활성화
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request) throws URISyntaxException;
	KakaoPayCancelResponseInPeriodVO periodCancel(KakaoPayCancelRequestInPeriodVO request) throws URISyntaxException;
	
}
