package com.kh.EveryFit.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Repository;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.EveryFit.configuration.KakaoPayProperties;
import com.kh.EveryFit.configuration.PeriodKakaoPayProperties;
import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.vo.KakaoPayApproveRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayApproveRequestVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.KakaoPayReadyRequestVO;
import com.kh.EveryFit.vo.KakaoPayReadyResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class KakaoPayServiceImpl implements KakaoPayService{

	@Autowired
	private RestTemplate template;
	
	@Autowired
	private KakaoPayProperties properties;
	
	@Autowired
	private PeriodKakaoPayProperties periodProperties;
	
	@Autowired
	private HttpHeaders headers;
	
	@Autowired
	private ProductDao productDao;
	
	@Override
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException {

		//주소설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		//바디 설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", properties.getCid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("item_name", request.getItemName());
		body.add("quantity", "1");
		body.add("total_amount", String.valueOf(request.getItemPrice()));
		body.add("tax_free_amount", "0");
		
		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
		
		body.add("approval_url", path + "/success");
		body.add("cancel_url", path + "/cancel");
		body.add("fail_url", path + "/fail");
		
		//요청 발송
		HttpEntity entity = new HttpEntity(body, headers);
		
		KakaoPayReadyResponseVO response = template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
		
		return response;
	}


	@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request) throws URISyntaxException {
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", properties.getCid());
		body.add("tid", request.getTid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("pg_token", request.getPgToken());
		
		HttpEntity entity = new HttpEntity(body, headers);
		
		KakaoPayApproveResponseVO response = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		log.debug("결제 승인 완료 = {}", response.getTid());
		return response;
	}


	@Override
	public KakaoPayReadyResponseVO periodReady(KakaoPayReadyRequestVO request) throws URISyntaxException {
		//주소설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		//바디 설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", periodProperties.getCid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("item_name", request.getItemName());
		body.add("quantity", "1");
		body.add("total_amount", String.valueOf(request.getItemPrice()));
		body.add("tax_free_amount", "0");
		
		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
		
		body.add("approval_url", path + "/success");
		body.add("cancel_url", path + "/cancel");
		body.add("fail_url", path + "/fail");
		
		//요청 발송
		HttpEntity entity = new HttpEntity(body, headers);
		
		KakaoPayReadyResponseVO response = template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
		
		return response;
	}


	@Override
	public KakaoPayApproveResponseVO periodApprove(KakaoPayApproveRequestVO request) throws URISyntaxException {
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", periodProperties.getCid());
		body.add("tid", request.getTid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("pg_token", request.getPgToken());
		
		HttpEntity entity = new HttpEntity(body, headers);
		
		KakaoPayApproveResponseVO response = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		log.debug("정기 결제 승인 완료 = {}", response.getTid());
		return response;
	}


	@Override
	public KakaoPayApproveResponseVO period2Approve(KakaoPayApproveRequestInPeriodVO request)
			throws URISyntaxException {
		URI uri = new URI("https://kapi.kakao.com/v1/payment/subscription");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", periodProperties.getCid());
		body.add("sid", request.getSid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("quantity", "1");
		body.add("total_amount", String.valueOf(request.getTotalAmount()));
		body.add("tax_free_amount", "0");
		
		
		HttpEntity entity = new HttpEntity(body, headers);
		
		KakaoPayApproveResponseVO response = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		//log.debug("결제 승인 완료 = {}", response.getTid());
		return response;
	}
}
