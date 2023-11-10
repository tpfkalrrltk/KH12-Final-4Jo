package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.PaymentListAllVO;

@Repository
public class PaymentDaoImpl implements PaymentDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("payment.sequence");
	}

	@Override
	public void insert(PaymentDto paymentDto) {
		sqlSession.insert("payment.save", paymentDto);
		
	}

	@Override
	public List<PaymentDto> selectList() {
		return sqlSession.selectList("payment.list");
	}

	@Override
	public void insertToPeriodPayment(PeriodPaymentDto periodPaymentDto) {
		sqlSession.insert("payment.periodPaymentSave", periodPaymentDto);
		
	}

	@Override
	public List<PeriodPaymentDto> selectListOfPeriodPayment() {
		return sqlSession.selectList("payment.periodPaymentList");
	}

	@Override
	public List<PaymentListAllVO> selectListAll() {
		return sqlSession.selectList("payment.listAll");
	}

	@Override
	public boolean update(PeriodPaymentDto periodPaymentDto) {
		return sqlSession.update("payment.updateEndDate", periodPaymentDto)>0;
	}

	@Override
	public PeriodPaymentDto selectOne(int periodPaymentNo) {
		return sqlSession.selectOne("payment.periodPaymentdetail", periodPaymentNo);
	}



}



