package com.kh.EveryFit.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.EveryFit.dto.CertDto;
import com.kh.EveryFit.error.NoTargetException;

@Repository
public class CertDaoImpl implements CertDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder encoder;

	@Override
	public void insert(CertDto certDto) {
		sqlSession.insert("cert.add", certDto); 
		
	}

	@Override
	public boolean delete(String certEmail) {
		return sqlSession.delete("cert.remove", certEmail) > 0;
	}

	@Override
    public CertDto selectOne(String certEmail) {
    	CertDto certDto = sqlSession.selectOne("cert.selectOne", certEmail);
		if(certDto == null) throw new NoTargetException();
		return certDto;
	}
	}

	
