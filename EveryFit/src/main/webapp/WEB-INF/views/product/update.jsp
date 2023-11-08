<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 


 <form method="post">
<input hidden type="text" name="productNo" value="${productDto.productNo}">
상품명 : <input type="text" name="productName" value="${productDto.productName}">
상품 가격 : <input type="text" name="productPrice" value="${productDto.productPrice}">
<button type="submit">상품 수정</button>
 </form>
 