package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.PaymentDto;


public interface PaymentDao {
	int sequence();
	void insert(PaymentDto paymentDto);
	List<PaymentDto> selectList();
}
