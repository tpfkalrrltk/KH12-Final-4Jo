package com.kh.EveryFit.service;

import java.net.URISyntaxException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.EveryFit.configuration.PeriodKakaoPayProperties;
import com.kh.EveryFit.dao.PaymentDao;
import com.kh.EveryFit.vo.KakaoPayApproveRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.PaymentListAllVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class PaymentScheduler {

	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private KakaoPayService kakoPayService;
	@Autowired
	private PeriodKakaoPayProperties periodProperties;
	
	@Scheduled(cron = "0 */5 * * * *")
	public void periodPayment() throws URISyntaxException {
		
		//List<PaymentDto> list = paymentDao.selectList();
		//List<PeriodPaymentDto>  periodList= paymentDao.selectListOfPeriodPayment();
		//List<PaymentListAllVO> list = paymentDao.selectListAll();
		
		List<PaymentListAllVO> list = paymentDao.selectListAll();
		for (PaymentListAllVO paymentListAllVO : list) {
		    log.debug("PaymentListAllVO: {}", paymentListAllVO);
		
			KakaoPayApproveRequestInPeriodVO request =
			KakaoPayApproveRequestInPeriodVO.builder()
			.partnerOrderId(UUID.randomUUID().toString())
			.partnerUserId(paymentListAllVO.getPaymentMember())
			.cid(periodProperties.getCid())
			.sid(paymentListAllVO.getPeriodPaymentSid())
			.quantity(1)
			.totalAmount(paymentListAllVO.getPaymentPrice())
			.taxFreeAmount(0)
			.build();
			
			//결제 승인 요청
			KakaoPayApproveResponseVO response = kakoPayService.period2Approve(request);
			//log.debug("response(SID)={}", response.getSid());
		}
		

		
		
		//log.debug("list={}", list);
		//log.debug("periodList={}", periodList);
		//log.debug("list={}", list);
		//log.debug("PaymentListAllVO: {}", list.toArray());
	}
}
