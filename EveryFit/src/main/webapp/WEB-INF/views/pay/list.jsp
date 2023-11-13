<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>결제 내역</h1>
<!-- 전체목록 -->

<c:forEach var="paymentListAllVO" items="${list}">
<c:if test="${paymentListAllVO.periodPaymentNo > 0}">
<div style="border:1px solid black; margin:30px 0px; padding:10px">

	<!-- 대표정보 -->
	<div style="border:1px solid blue; padding:10px" class="payment">
	
	${paymentListAllVO}
	<hr>
			<c:if test="${paymentListAllVO.paymentPrice > 0}">
			<a href="cancel?paymentNo=${paymentListAllVO.paymentNo}">
			정기 결제 취소</a>
			</c:if>
	</div>
</div>
</c:if>

<c:if test="${paymentListAllVO.periodPaymentNo == 0}">
<div style="border:1px solid black; margin:30px 0px; padding:10px">

	<!-- 대표정보 -->
	<div style="border:1px solid blue; padding:10px" class="payment">
	
	${paymentListAllVO}
	<hr>
			<c:if test="${paymentListAllVO.paymentPrice > 0}">
			<a href="cancel?paymentNo=${paymentListAllVO.paymentNo}">
			단건 결제 취소</a>
			</c:if>
	</div>
</div>
</c:if>
</c:forEach>