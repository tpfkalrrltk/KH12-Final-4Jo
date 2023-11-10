package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.PaymentListAllVO;


public interface PaymentDao {
	int sequence();
	void insert(PaymentDto paymentDto);
	List<PaymentDto> selectList();
	void insertToPeriodPayment(PeriodPaymentDto periodPaymentDto);
	List<PeriodPaymentDto> selectListOfPeriodPayment();
	List<PaymentListAllVO> selectListAll();
}
