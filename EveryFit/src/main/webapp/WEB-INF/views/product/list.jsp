<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <!-- 부트스트랩 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/sandstone/bootstrap.min.css" rel="stylesheet">
<link href="test.css" rel="stylesheet">

<style>

  .border {
  border: 1px solid #2d3436;
  }
</style>
<div class="container-fluid mb-5 pb-5">
    <div class="row">
    
        <div class="col-md-8 offset-md-2">
            <div class="row">
                <div class="col">
                    <h1 class="text-center border">상품 내역</h1>
                </div>
            </div>

            <c:forEach var="productDto" items="${list}">
            <div class="row">
                <div class="col">
                    <h2>
                    ${productDto.productName} (${productDto.productPrice} 원)
                     <a href="${pageContext.request.contextPath}/product/update?productNo=${productDto.productNo}"> 수정</a>
                    </h2>
                </div>
            </div>
                </c:forEach>
        </div>
    </div>
</div>