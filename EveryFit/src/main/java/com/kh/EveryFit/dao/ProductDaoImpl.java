package com.kh.EveryFit.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.EveryFit.dto.ProductDto;

public class ProductDaoImpl implements ProductDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("product.sequence");
	}

	@Override
	public void insert(ProductDto productDto) {
		sqlSession.insert("product.add", productDto);
	}

	@Override
	public List<ProductDto> selectList() {
		return sqlSession.selectList("product.list");
	}

	@Override
	public ProductDto oneOfList(int productNo) {
		return sqlSession.selectOne("product.oneOfList", productNo);
	}

	@Override
	public boolean update(ProductDto productDto) {
		return sqlSession.update("product.edit", productDto)>0;
	}

	@Override
	public boolean delete(int productNo) {
		return sqlSession.delete("product.delete", productNo)>0;
	}

}
