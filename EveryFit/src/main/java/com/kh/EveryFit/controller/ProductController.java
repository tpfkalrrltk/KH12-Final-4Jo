package com.kh.EveryFit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.EveryFit.dao.ProductDao;
import com.kh.EveryFit.dto.ProductDto;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductDao productDao;
	
	@GetMapping("/add")
	public String add() {
		return "product/add";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ProductDto productDto) {
		int productNo = productDao.sequence();
		productDto.setProductNo(productNo);
		productDao.insert(productDto);
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<ProductDto> list = productDao.selectList();
		model.addAttribute("list", list);
		return "product/list";
	}
	
	@GetMapping("/update")
	public String update(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.oneOfList(productNo);
		model.addAttribute("productDto", productDto);
		return "product/update";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute ProductDto productDto) {
		boolean result = productDao.update(productDto);
		if(result) {return "redirect:list";}
		else {return "redirect:error";}
	}
	
	
}



