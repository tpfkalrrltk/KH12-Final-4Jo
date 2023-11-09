package com.kh.EveryFit.service;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class PaymentScheduler {

	@Scheduled(cron = "0 5 * * * *")
	public void periodPayment() {
		
	}
}
