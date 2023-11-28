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
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.KakaoPayApproveRequestInPeriodVO;
import com.kh.EveryFit.vo.KakaoPayApproveResponseVO;
import com.kh.EveryFit.vo.PaymentListAllVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DownGradeMoimScheduler {

	@Autowired
	private MoimDao moimDao;
	
	@Autowired
	private PaymentDao paymentDao;
	@Autowired
	private KakaoPayService kakoPayService;
	@Autowired
	private PeriodKakaoPayProperties periodProperties;
	
	//@Scheduled(cron = "0 */1 * * * *")
		private void DownGradeMoim() throws URISyntaxException {
			List<MoimDto> list = moimDao.selectMoimListBeforeToday();
			for (MoimDto moimDto : list) {
				
			//log.debug("NO: {}", paymentListAllVO.getPeriodPaymentNo() , paymentListAllVO.getPeriodPaymentEnd(), paymentListAllVO.getPeriodPaymentStatus());
		    //log.debug("END: {}", paymentListAllVO.getPeriodPaymentEnd());
		    log.debug("moimDto: {}", moimDto);

		    moimDao.upgradeToNotPrimium(MoimDto.builder()
					.moimNo(moimDto.getMoimNo())
					.build());
			log.debug("상태 Y->N로 변경 완료");
		}
			
	}
	
	
}
