package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);
	List<ProductDto> selectList();
	ProductDto oneOfList(int productNo);
	boolean update(ProductDto productDto);
	boolean delete(int productNo);
}
