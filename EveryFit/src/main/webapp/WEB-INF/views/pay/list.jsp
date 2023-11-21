<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../template/Header.jsp"%>
<style>
.ataglink {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007BFF;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}
</style>
<h1>${memberDto.memberEmail} 님이 보유한 프리미엄 카드 리스트</h1>
<%-- <c:forEach var="paymentListAllVO" items="${list}">
<c:if test="${paymentListAllVO.periodPaymentNo > 0}"> --%>

<div class="row">
					<div class="col">
					<c:if test="${memberDto.memberLevel == '프리미엄'}">
					<h2>프리미엄 회원권 카드</h2>
					<div class="col text-start"><img src="/images/moinCard.png" ></div>
					
					</c:if>
					<hr>
<c:forEach var="MoimDtoList" items="${MoimDtoList}">
<c:if test="${MoimDtoList.moimUpgrade == 'Y'}">
<h2>[${MoimDtoList.moimTitle}] 모임을 위한 프리미엄 카드</h2>

<c:forEach var="paymentListAllVO" items="${list}">

<c:if test="${paymentListAllVO.periodPaymentStatus == 'Y'}">
			<a href="javascript:void(0);" onclick="cancelSubscription(${paymentListAllVO.paymentNo}, '${MoimDtoList.moimTitle}')" class="ataglink">
              [${MoimDtoList.moimTitle}] 프리미엄 카드 구독 취소
            </a>
<%-- 			<a href="periodCancel?periodPaymentNo=${paymentListAllVO.paymentNo}"
			 class="ataglink">
			[${MoimDtoList.moimTitle}] 프리미엄 카드 구독 취소</a> --%>
			</c:if>
</c:forEach>
<div class="row">
									<div class="col text-start">
										<img src="/images/moinCard.png" >
									</div>
								</div>
											

</c:if>
</c:forEach>
<hr>
					

					</div>
				</div>
<%-- </c:if>
</c:forEach> --%>
<script>
  function cancelSubscription(paymentNo, moimTitle) {
    var confirmation = confirm("프리미엄 카드 구독을 정말로 취소하시겠습니까?");
    if (confirmation) {
      // 사용자가 확인을 선택한 경우에 수행할 작업
      window.location.href = "periodCancel?periodPaymentNo=" + paymentNo;
    } else {
      // 사용자가 취소를 선택한 경우에 수행할 작업
    }
  }
</script>

<%@ include file="../template/Footer.jsp"%>