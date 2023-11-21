package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.PaymentListAllVO;
import com.kh.EveryFit.vo.PaymentListByMemberVO;



public interface PaymentDao {
	int sequence();
	void insert(PaymentDto paymentDto);
	List<PaymentDto> selectList();
	void insertToPeriodPayment(PeriodPaymentDto periodPaymentDto);
	List<PeriodPaymentDto> selectListOfPeriodPayment();
	List<PaymentListAllVO> selectListAll();
	boolean update(PeriodPaymentDto periodPaymentDto);
	PeriodPaymentDto selectOne(int periodPaymentNo);
	PaymentDto selectOneOfPayment(int paymentNo);
	List<PaymentListAllVO> paymentListByMember(String paymentMember);
	void cancel(PaymentDto paymentDto);
	void periodCancel (PeriodPaymentDto periodPaymentDto);
	List<PaymentListByMemberVO> selectPaymentListByMember(String memberId);
}
