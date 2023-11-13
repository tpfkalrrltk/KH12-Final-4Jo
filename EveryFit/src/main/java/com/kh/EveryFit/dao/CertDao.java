package com.kh.EveryFit.dao;

import com.kh.EveryFit.dto.CertDto;

public interface CertDao {

	void insert(CertDto certDto);
	boolean delete(String certEmail);
	CertDto selectOnt(String certEmail);
}
