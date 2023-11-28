package com.kh.EveryFit.controller;

import java.net.URISyntaxException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dao.PaymentDao;
import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.MoimMemberDto;
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
import com.kh.EveryFit.vo.MoimTitleForPaymentVO;
import com.kh.EveryFit.vo.PaymentListAllVO;
import com.kh.EveryFit.vo.PaymentListByMemberVO;

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
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MoimDao moimDao;
	
	@GetMapping("/pay")
	public String premium1(Model model, @RequestParam int productNo, HttpSession session) {
		model.addAttribute("productDto", productDao.oneOfList(productNo));
		//session에서 회원정보 가져오기 partnerUserId에 회원정보 넣기
		String memberId = (String)session.getAttribute("name");
		
		//구매할사람이 포함된 모임정보 조회
		List<MoimMemberDto> moimMemberDto= moimDao.selectAllMoimNo(memberId);
		List<MoimTitleForPaymentVO> moimTitleForPaymentVO = moimDao.selectTitleMoimNo(memberId);
		List<MoimDto> MoimDto= moimDao.moimListByEmailAndCrown(memberId);
		MemberDto memberDto = memberDao.selectOne(memberId);
		//List<PaymentListAllVO> PaymentListAllVO = paymentDao.paymentListByMember(memberId);
		//가입된 모임 번호를 확인하여 periodPayment의 moim_no에 저장
		//가입된 모임 번호를 확인하여 VO에 저장
		log.debug("moimMemberDto={}", moimMemberDto);
		log.debug("moimTitleForPaymentVO={}", moimTitleForPaymentVO);
		//model.addAttribute("list", moimMemberDto);
		//model.addAttribute("list",PaymentListAllVO);
		model.addAttribute("moimTitleForPaymentVO", moimTitleForPaymentVO);
		model.addAttribute("MoimDtoList", MoimDto);
		model.addAttribute(memberDto);

		return "pay/premium";
	}
	
	@GetMapping("/pay/purchase")
	public String purchase(HttpSession session, @RequestParam int productNo) throws URISyntaxException {
		//상품정보 조회
				ProductDto productDto = productDao.oneOfList(productNo);
				//상품정보를 이용하여 결제준비 요청
				
				//session에서 회원정보 가져오기 partnerUserId에 회원정보 넣기
				String memberId = (String)session.getAttribute("name");
				
				KakaoPayReadyRequestVO request = KakaoPayReadyRequestVO.builder()
						.itemName(productDto.getProductName())
						.itemPrice(productDto.getProductPrice())
						.partnerOrderId(UUID.randomUUID().toString())
						.partnerUserId(memberId)
						//.payload(String.valueOf(moimNo))
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
					
					//회원권 구매 후 member_moim_count (3->10) 디비 수정
					//String memberEmail = KH12FD;
					String memberEmail = (String)session.getAttribute("name");
					memberDao.updateMemberMoimCount(memberEmail);
					
					return "redirect:successResult";
		}
		
		@RequestMapping("/pay/purchase/successResult")
		public String purchaseSuccessResult(HttpSession session) {

			return "pay/successResult";
		}
		
		@GetMapping("/pay/periodPurchase")
		public String periodPurchase(HttpSession session, @RequestParam int productNo, Model model,int moimNo) throws URISyntaxException {
			//상품정보 조회
					ProductDto productDto = productDao.oneOfList(productNo);
					//상품정보를 이용하여 결제준비 요청
					
					//session에서 회원정보 가져오기 partnerUserId에 회원정보 넣기
					String memberId = (String)session.getAttribute("name");
					

					

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
					session.setAttribute("moimNo", moimNo);
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
						int moimNo = (int) session.getAttribute("moimNo");
						session.removeAttribute("approve");
						session.removeAttribute("productNo");
						session.removeAttribute("moimNo");
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
								//가입된 모임 번호를 확인하여 periodPayment의 moim_no에 저장
								.periodPaymentMoimNo(moimNo)
								.build());

						//moim 테이블에 프리미엄 모임 상태를 N->Y로 변경
						moimDao.upgradeToPrimium(MoimDto.builder()
								.moimNo(moimNo)
								.build());
						
						
						
						return "redirect:/pay/list";
			}
			
			@RequestMapping("/pay/periodPurchase/successResult")
			public String periodPurchaseSuccessResult() {
				return "pay/successResult";
			}
			
			@RequestMapping("pay/list")
			public String list(HttpSession session, Model model) {
				String memberId = (String)session.getAttribute("name");
				List<PaymentListByMemberVO> PaymentListByMemberVO = paymentDao.selectPaymentListByMember(memberId);
				List<MoimMemberDto> moimMemberDto= moimDao.selectAllMoimNo(memberId);
				List<MoimTitleForPaymentVO> moimTitleForPaymentVO = moimDao.selectTitleMoimNo(memberId);
				List<MoimDto> MoimDto= moimDao.moimListByEmail(memberId);
				MemberDto memberDto = memberDao.selectOne(memberId);



				model.addAttribute("PaymentListByMemberVO",PaymentListByMemberVO);


				

				model.addAttribute("list2", moimTitleForPaymentVO);
				model.addAttribute("MoimDtoList", MoimDto);
				model.addAttribute(memberDto);
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
			public String periodCancel(@RequestParam int periodPaymentNo, RedirectAttributes redirectAttributes) throws URISyntaxException {
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
				
				//periodPaymentStatus 이게 Y 여야 정기결제가 실행되므로,
				//취소를 하게되면 N이 되기때문에 정기결제는 멈춤
				//또다른 스케줄러로
				//moim_end_time이 오늘날짜보다 작으면 moim_upgrade를 Y->N으로 변경하고 moim_member_count도 30으로 변경
				
				
				//모임테이블의 moim_upgrade가 Y->N으로 변경
				
//				moimDao.upgradeToNotPrimium(MoimDto.builder()
//						.moimNo(periodPaymentDto.getPeriodPaymentMoimNo())
//						.build());
//				log.debug("비활성화 완료");
				
			    // 취소 상태를 나타내는 속성 추가
			    redirectAttributes.addFlashAttribute("cancellationStatus", "success");
				return "redirect:list";
			}
			
			
}





