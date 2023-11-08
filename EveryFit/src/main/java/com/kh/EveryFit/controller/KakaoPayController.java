package com.kh.EveryFit.controller;

import java.net.URISyntaxException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.dto.ProductDto;
import com.kh.EveryFit.service.KakaoPayService;
import com.kh.EveryFit.vo.KakaoPayApproveRequestVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.KakaoPayReadyRequestVO;
import com.kh.EveryFit.vo.KakaoPayReadyResponseVO;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class KakaoPayController {

	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private ProductDao productDao;
	
	@GetMapping("/pay")
	public String premium1(Model model, @RequestParam int productNo) {
		model.addAttribute("productDto", productDao.oneOfList(productNo));
		return "pay/premium";
	}
	
	@GetMapping("/pay/purchase")
	public String purchase(HttpSession session, @RequestParam int productNo) throws URISyntaxException {
		//상품정보 조회
				ProductDto productDto = productDao.oneOfList(productNo);
				//상품정보를 이용하여 결제준비 요청
				
				KakaoPayReadyRequestVO request = KakaoPayReadyRequestVO.builder()
						.itemName(productDto.getProductName())
						.itemPrice(productDto.getProductPrice())
						.partnerOrderId(UUID.randomUUID().toString())
						.partnerUserId("testuser1")
						.build();
				
				KakaoPayReadyResponseVO response = kakaoPayService.ready(request);
				
				log.debug("response = {}",response.getNextRedirectPcUrl());
				//session에 flash value를 저장(잠시 쓰고 지우는 데이터)
				//- 사용자를 거치지 않는 범위 내에서 사용해야 안전하게 쓸 수 있다
				session.setAttribute("approve", KakaoPayApproveRequestVO.builder()
						.partnerOrderId(request.getPartnerOrderId())
						.partnerUserId(request.getPartnerUserId())
						.tid(response.getTid())
						.build());
				
				//플래시 벨류//디비에도 저장하기 위해서 추가적으로
				session.setAttribute("productNo", productNo);
				
				//결제페이지를 사용자에게 안내
						return "redirect:"+response.getNextRedirectPcUrl();
	}
	//결제 성공
		@GetMapping("/pay/purchase/success")
		public String success(HttpSession session, @RequestParam String pg_token) throws URISyntaxException {
			//session에 저장되어 있는 flash value를 꺼내어 pg_token을 추가한 뒤 승인 요청
					KakaoPayApproveRequestVO request = 
							(KakaoPayApproveRequestVO) session.getAttribute("approve");
					int productNo = (int) session.getAttribute("productNo");
					session.removeAttribute("approve");
					session.removeAttribute("productNo");
					
					request.setPgToken(pg_token);//토큰 추가
					
					//결제 승인 요청
					KakaoPayApproveResponseVO response = kakaoPayService.approve(request);
					log.debug("response={}", response.getSid());
					//결제 승인이 완료되었다면 DB에 결제 정보를 저장
//					int paymentNo = paymentDao.sequence();
//					paymentDao.insert(PaymentDto.builder()
//							.paymentNo(paymentNo)
//							.paymentMember(response.getPartnerUserId())
//							//.paymentProduct(productNo)
//							.paymentTid(response.getTid())
//							.paymentName(response.getItemName())
//							.paymentPrice(response.getAmount().getTotal())
//							.paymentRemain(response.getAmount().getTotal())//추가하면 돌아감
//							.build());
					
					return "redirect:successResult";
		}
		
		@RequestMapping("/pay/purchase/successResult")
		public String test3SuccessResult() {
			return "pay/successResult";
		}
}





