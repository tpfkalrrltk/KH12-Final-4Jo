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

import com.kh.EveryFit.configuration.KakaoPayProperties;
import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.vo.KakaoPayApproveRequestVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.KakaoPayReadyRequestVO;
import com.kh.EveryFit.vo.KakaoPayReadyResponseVO;

@Repository
public class KakaoPayServiceImpl implements KakaoPayService{

	@Autowired
	private RestTemplate template;
	
	@Autowired
	private KakaoPayProperties properties;
	
	@Autowired
	private HttpHeaders headers;
	
	@Autowired
	private ProductDao productDao;
	
@Override
public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException {
	//주소설정
	URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
	//바디설정
	MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
	body.add("cid", properties.getCid());
	body.add("partner_order_id", request.getPartnerOrderId());
	body.add("partner_user_id", request.getPartnerUserId());
	body.add("item_name", request.getItemName());
	body.add("quantity", "1");
	body.add("total_amount", String.valueOf(request.getItemPrice()));
	body.add("tax_free_amount", "0");
	body.add("approval_url", "");
	body.add("cancel_url", "");
	body.add("fail_url", "");
	
	HttpEntity entity = new HttpEntity(headers, body);
	KakaoPayReadyResponseVO response = template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
	return response;
}

@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request) throws URISyntaxException {
	//주소설정
	URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
	
	MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
	body.add("cid", properties.getCid());
	body.add("tid", request.getTid());
	body.add("partner_order_id", request.getPartnerOrderId());
	body.add("partner_user_id", request.getPartnerUserId());
	body.add("pg_token", request.getPgToken());
	
	HttpEntity entity = new HttpEntity(body, headers);
	
	KakaoPayApproveResponseVO response = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
	
	return response;
	}
}
