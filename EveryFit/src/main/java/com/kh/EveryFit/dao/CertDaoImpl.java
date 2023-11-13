package com.kh.EveryFit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.CertDto;

@Repository
public class CertDaoImpl implements CertDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CertDto certDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean delete(String certEmail) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public CertDto selectOnt(String certEmail) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
