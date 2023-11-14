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
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request) throws URISyntaxException;
	KakaoPayReadyResponseVO periodReady(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO periodApprove(KakaoPayApproveRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO period2Approve(KakaoPayApproveRequestInPeriodVO request) throws URISyntaxException;
	
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request) throws URISyntaxException;
	KakaoPayCancelResponseInPeriodVO periodCancel(KakaoPayCancelRequestInPeriodVO request) throws URISyntaxException;
	
}
