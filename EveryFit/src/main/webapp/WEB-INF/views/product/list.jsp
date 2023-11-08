<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <!-- 부트스트랩 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/sandstone/bootstrap.min.css" rel="stylesheet">
<link href="test.css" rel="stylesheet">

<style>
      .main-image {
    width: 100%;
    height : 200px;
    max-width: 300px;
    max-height: 300px;
    
  }
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
                     <a href="update?productNo=${productDto.productNo}"> 수정</a>
                    </h2>
                </div>
            </div>

            <div class="row">
                <div class="col-5 text-center">
                <c:if test="${productDto.productNo == 1}">
                    <img src="/images/memberCard.png" class="main-image img-thumbnail">
                </c:if>
                <c:if test="${productDto.productNo == 3}">
                    <img src="/images/moinCard.png" class="main-image img-thumbnail">
                </c:if>
                </div>
                
                <c:if test="${productDto.productNo == 1}">
			    
			    <div class="col-7 border">
                    <br><br><br>
                    모임방 참가 횟수에 제한이 사라집니다
                    <a href="purchase?productNo=${productDto.productNo}">구매하기</a>
                </div>
				</c:if>
				
				<c:if test="${productDto.productNo == 3}">
			    
			    <div class="col-7 border">
                    <br><br><br>
                    프리미엄 모임 이용권으로 모임을 최대한 활용하세요 !
                    구독은 매월 자동결제되고 언제든 해지가능합니다.
                    <a href="purchase?productNo=${productDto.productNo}">구매하기</a>
                </div>
				</c:if>
				

            </div>

            

                    
                    
                </c:forEach>
            
        </div>
    </div>
</div>