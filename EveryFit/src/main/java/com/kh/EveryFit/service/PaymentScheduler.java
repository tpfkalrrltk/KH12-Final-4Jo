package com.kh.EveryFit.service;

import java.net.URISyntaxException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.EveryFit.configuration.PeriodKakaoPayProperties;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dao.PaymentDao;
import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.KakaoPayApproveRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.PaymentListAllVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentScheduler {

	@Autowired
	private MoimDao moimDao;
	
	@Autowired
	private PaymentDao paymentDao;
	@Autowired
	private KakaoPayService kakoPayService;
	@Autowired
	private PeriodKakaoPayProperties periodProperties;
	//실행조건
	//WHERE TRUNC(pp.period_payment_END) = TRUNC(SYSDATE) AND pp.period_payment_status = 'Y'
	//@Scheduled(cron = "0 */1 * * * *")
	private void periodPayment() throws URISyntaxException {
		List<PaymentListAllVO> list = paymentDao.selectListAll();
		for (PaymentListAllVO paymentListAllVO : list) {
			log.debug("NO: {}", paymentListAllVO.getPeriodPaymentNo() , paymentListAllVO.getPeriodPaymentEnd(), paymentListAllVO.getPeriodPaymentStatus());
		    log.debug("END: {}", paymentListAllVO.getPeriodPaymentEnd());
		    log.debug("STATUE: {}", paymentListAllVO.getPeriodPaymentStatus());
		    
			KakaoPayApproveRequestInPeriodVO request =
			KakaoPayApproveRequestInPeriodVO.builder()
			.partnerOrderId(UUID.randomUUID().toString())
			.partnerUserId(paymentListAllVO.getPaymentMember())
			.cid(periodProperties.getCid())
			.sid(paymentListAllVO.getPeriodPaymentSid())
			.quantity(0)
			.totalAmount(paymentListAllVO.getPaymentPrice())
			.taxFreeAmount(0)
			.build();
			
			//결제 승인 요청
			KakaoPayApproveResponseVO response = kakoPayService.period2Approve(request);
			log.debug("정기결제승인요청하였고SID는={}", response.getSid());
			log.debug("정기결제승인요청하였고PRICE는={}", response.getAmount().getTotal());
			log.debug("정기결제승인요청하였고결제요청시각은={}", response.getCreatedAt());
			
			
			//결제 승인이 완료되었다면 DB에 결제 정보(period_payment_end)를 업데이트
//			int paymentNo = paymentDao.sequence();
//			paymentDao.insert(PaymentDto.builder()
//					.paymentNo(paymentNo)
//					.paymentMember(response.getPartnerUserId())
//					.paymentProduct(productNo)
//					.paymentTid(response.getTid())
//					.paymentName(response.getItemName())
//					.paymentPrice(response.getAmount().getTotal())
//					.build());
//
//			paymentDao.insertToPeriodPayment(PeriodPaymentDto.builder()
//					.periodPaymentNo(paymentNo)
//					.periodPaymentSid(response.getSid())
//					.build());
			PeriodPaymentDto periodPaymentDto =paymentDao.selectOne(paymentListAllVO.getPeriodPaymentNo());
			
			paymentDao.update(periodPaymentDto);
			moimDao.updateToEndDate(paymentListAllVO.getPeriodPaymentMoimNo());
			
		}
	}
	
	
}
