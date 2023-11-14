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

import com.kh.EveryFit.dao.PaymentDao;
import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.dto.ProductDto;
import com.kh.EveryFit.service.KakaoPayService;
import com.kh.EveryFit.vo.KakaoPayApproveRequestVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.KakaoPayCancelRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayCancelRequestVO;
import com.kh.EveryFit.vo.KakaoPayCancelResponseInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayCancelResponseVO;
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
	
	@Autowired
	private PaymentDao paymentDao;
	
	
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
				
				//session에서 회원정보 가져오기 partnerUserId에 회원정보 넣기
				String memberId = (String) session.getAttribute("name");
				
				KakaoPayReadyRequestVO request = KakaoPayReadyRequestVO.builder()
						.itemName(productDto.getProductName())
						.itemPrice(productDto.getProductPrice())
						.partnerOrderId(UUID.randomUUID().toString())
						.partnerUserId(memberId)
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
		public String purchaseSuccess(HttpSession session, @RequestParam String pg_token) throws URISyntaxException {
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
					int paymentNo = paymentDao.sequence();
					paymentDao.insert(PaymentDto.builder()
							.paymentNo(paymentNo)
							.paymentMember(response.getPartnerUserId())
							.paymentProduct(productNo)
							.paymentTid(response.getTid())
							.paymentName(response.getItemName())
							.paymentPrice(response.getAmount().getTotal())
							.build());
					
					return "redirect:successResult";
		}
		
		@RequestMapping("/pay/purchase/successResult")
		public String purchaseSuccessResult() {
			return "pay/successResult";
		}
		
		@GetMapping("/pay/periodPurchase")
		public String periodPurchase(HttpSession session, @RequestParam int productNo) throws URISyntaxException {
			//상품정보 조회
					ProductDto productDto = productDao.oneOfList(productNo);
					//상품정보를 이용하여 결제준비 요청
					
					//session에서 회원정보 가져오기 partnerUserId에 회원정보 넣기
					String memberId = (String) session.getAttribute("name");
					
					KakaoPayReadyRequestVO request = KakaoPayReadyRequestVO.builder()
							.itemName(productDto.getProductName())
							.itemPrice(productDto.getProductPrice())
							.partnerOrderId(UUID.randomUUID().toString())
							.partnerUserId(memberId)
							.build();
					
					KakaoPayReadyResponseVO response = kakaoPayService.periodReady(request);
					
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
			@GetMapping("/pay/periodPurchase/success")
			public String periodPurchaseSuccess(HttpSession session, @RequestParam String pg_token) throws URISyntaxException {
				//session에 저장되어 있는 flash value를 꺼내어 pg_token을 추가한 뒤 승인 요청
						KakaoPayApproveRequestVO request = 
								(KakaoPayApproveRequestVO) session.getAttribute("approve");
						int productNo = (int) session.getAttribute("productNo");
						session.removeAttribute("approve");
						session.removeAttribute("productNo");
						
						request.setPgToken(pg_token);//토큰 추가
						
						//결제 승인 요청
						KakaoPayApproveResponseVO response = kakaoPayService.periodApprove(request);
						log.debug("response(SID)={}", response.getSid());
						//결제 승인이 완료되었다면 DB에 결제 정보를 저장
						int paymentNo = paymentDao.sequence();
						paymentDao.insert(PaymentDto.builder()
								.paymentNo(paymentNo)
								.paymentMember(response.getPartnerUserId())
								.paymentProduct(productNo)
								.paymentTid(response.getTid())
								.paymentName(response.getItemName())
								.paymentPrice(response.getAmount().getTotal())
								.build());
		
						paymentDao.insertToPeriodPayment(PeriodPaymentDto.builder()
								.periodPaymentNo(paymentNo)
								.periodPaymentSid(response.getSid())
								.build());
						
						return "redirect:successResult";
			}
			
			@RequestMapping("/pay/periodPurchase/successResult")
			public String periodPurchaseSuccessResult() {
				return "pay/successResult";
			}
			
			@RequestMapping("pay/list")
			public String list(HttpSession session, Model model) {
				String memberId = (String) session.getAttribute("name");
				model.addAttribute("list", paymentDao.paymentListByMember(memberId));
				log.debug("memberId={}",memberId);
				log.debug("paymentDao={}",paymentDao.paymentListByMember(memberId));
				return "pay/list";
			}
			
			@RequestMapping("/pay/cancel")
			public String cancel(@RequestParam int paymentNo) throws URISyntaxException {
				PaymentDto paymentDto = paymentDao.selectOneOfPayment(paymentNo);
				KakaoPayCancelRequestVO request = KakaoPayCancelRequestVO.builder()
						.tid(paymentDto.getPaymentTid())
						.cancelAmount(paymentDto.getPaymentPrice())
						.build();
				
				KakaoPayCancelResponseVO response = kakaoPayService.cancel(request);
				
				paymentDao.cancel(PaymentDto.builder()
						.paymentNo(paymentDto.getPaymentNo())
						.paymentPrice(0)
						.build());
				return "redirect:list";
			}
			
			@RequestMapping("/pay/periodCancel")
			public String periodCancel(@RequestParam int periodPaymentNo) throws URISyntaxException {
				//int periodPaymentNo = paymentNo; 
				PeriodPaymentDto periodPaymentDto = paymentDao.selectOne(periodPaymentNo);
				PaymentDto paymentDto = paymentDao.selectOneOfPayment(periodPaymentNo);
				KakaoPayCancelRequestInPeriodVO request = KakaoPayCancelRequestInPeriodVO.builder()
						.sid(periodPaymentDto.getPeriodPaymentSid())
						.build();
				log.debug("sid={}",periodPaymentDto.getPeriodPaymentSid());
				log.debug("vo sid={}", request);
				KakaoPayCancelResponseInPeriodVO response = kakaoPayService.periodCancel(request);
				
				paymentDao.cancel(PaymentDto.builder()
						.paymentNo(periodPaymentNo)
						.paymentPrice(0)
						.build());
				
				paymentDao.periodCancel(PeriodPaymentDto.builder()
						.periodPaymentSid(response.getStatus())
						.periodPaymentStatus("N")
						.periodPaymentNo(periodPaymentNo)
						.build());
				
				log.debug("비활성화 완료");
				return "redirect:list";
			}
			
			
}





