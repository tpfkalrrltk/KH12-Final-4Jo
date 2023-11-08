<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 <h1>상품등록하기</h1>
 <form method="post">
 	상품명 : <input type="text" name="productName">
 	상품 가격 : <input type="text" name="productPrice">
 	<button type="submit">상품등록</button>
 </form>