package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.PaymentDto;
import com.kh.EveryFit.dto.PeriodPaymentDto;
import com.kh.EveryFit.vo.PaymentListAllVO;
import com.kh.EveryFit.vo.PaymentListByMemberVO;

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
		return sqlSession.selectOne("payment.periodPaymentDetail", periodPaymentNo);
	}

	@Override
	public List<PaymentListAllVO> paymentListByMember(String paymentMember) {
		return sqlSession.selectList("payment.listAllByMember", paymentMember);
	}

	@Override
	public PaymentDto selectOneOfPayment(int paymentNo) {
		return sqlSession.selectOne("payment.paymentDetail", paymentNo);
	}

	@Override
	public void cancel(PaymentDto paymentDto) {
		sqlSession.update("payment.cancel", paymentDto);
	
}
	@Override
	public void periodCancel(PeriodPaymentDto periodPaymentDto) {
		sqlSession.update("payment.periodCancel", periodPaymentDto);
		
	}

	@Override
	public List<PaymentListByMemberVO> selectPaymentListByMember(String memberId) {
		return sqlSession.selectList("payment.paymentListByMember", memberId);
	}
}



