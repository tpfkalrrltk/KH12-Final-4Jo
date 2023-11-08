<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 <c:forEach var="productDto" items="${list}">
 
<div>
 ${productDto.productName}
 ${productDto.productPrice}
 </div>
 <a href="update"> 수정</a>

 </c:forEach>