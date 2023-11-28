<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<!-- 아이콘 사용을 위한 font awesomedmf 불러오기 위한  -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


<style>
.main-image {
	width: 100%;
	height: 300px;
	 max-width : 700px;
	/* 	max-width: 500px;
	max-height: 300px; */
}

.border {
	border: 1px solid #2d3436;
}

.ataglink {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007BFF;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.ataglink:hover {
	background-color: #0056b3;
}

    .disabled-link {
        pointer-events: none;
        color: #999; /* 비활성화된 링크의 색상을 변경할 수 있습니다. */
        text-decoration: none; /* 비활성화된 링크에 밑줄을 제거할 수 있습니다. */
    }
    .box {
	margin: 20px;
	padding: 30px;
	border: 1px solid orange;
	border-radius: 14px;
}
.fixed-size-image {
    width: 100%; /* 또는 원하는 크기(px 등)를 지정할 수 있습니다. */
    height: auto; 
    max-height: 300px;
    min-height:100px;
}
.h5 {
	margin : -7px;
}
</style>

<!-- 회원 멤버쉽 모달 코드 추가 -->
<div class="modal fade" id="membershipPurchaseModal" tabindex="-1" role="dialog" aria-labelledby="membershipPurchaseModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 50%; width: 50%;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="membershipPurchaseModalLabel">프리미엄 회원권 구매 확인</h5>
        
          
      </div>
      <div class="modal-body">
      ※ 프리미엄 회원권 이용약관 ※ <br>
       - EeveryFIt 프리미엄 회원권은 결제 버튼을 누르면 카카오페이로 결제 됩니다.<br>
       - EeveryFit 프리미엄 회원권은 한번 결제하면 평생 이용이 가능합니다.
 <hr>
     <p id="membershipPriceText" class="text-primary"></p>
     <p id="membershipText" class="text-primary"></p>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <a href="#" id="membershipPurchaseLink" class="btn btn-primary">결제</a>
      </div>
    </div>
  </div>
</div>

<!-- 모달 코드 추가 -->
<div class="modal fade" id="purchaseModal" tabindex="-1" role="dialog" aria-labelledby="purchaseModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 50%; width: 50%;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="purchaseModalLabel">프리미엄 모임권 구매 확인</h5>
        
          
      </div>
      <div class="modal-body">
      ※ 구독이용약관 ※ <br>
       - EeveryFIt 프리미엄 모임권은 결제 버튼을 누르면 카카오페이로 결제 됩니다.<br>
       - EeveryFIt 프리미엄 모임권을 구독하시면 매월 자동결제됩니다.<br>
       - 나의결재내역리스트에서 언제든 구독 취소가 가능합니다.<br>
       - 정기구독 특성상 최초 1회의 결제금액은 과금되며 환불이 불가능합니다.<br>
       - 이용권에 대한 기능은 임의로 변경될 수 있습니다.<br>
       - 회원 탈퇴 시 구독해지가 자동으로 되지 않으니 반드시 구독 취소 부탁드립니다.<br>
       <hr>
        <p id="activationDateInfo" class="text-primary"></p>
        <p id="moimTitleText" class="text-primary"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <a href="#" id="purchaseLink" class="btn btn-primary">결제</a>
      </div>
    </div>
  </div>
</div>


<!-- -------------------------------------------------------------------------------------------- -->
<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">


			<div class="d-flex  ">
				<div class="box w-100">
					<div>
						<h2>${productDto.productName}</h2>
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<h4 class="mt-5">EeveryFIt 프리미엄 멤버가 되어 보세요!</h4>
<!-- 								<label>(EeveryFit 프리미엄 회원권은 한번
							결제하면 평생 이용이 가능합니다)</label> -->
							</c:when>
							<c:otherwise>
								<h4>EeveryFit 프리미엄 모임으로 업그레이드 해보세요!</h4>
								
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="box p-2 flex-shrink-1 w-50 text-center">
					<c:choose>
						<c:when test="${productDto.productType == '단건'}">
						<span class="text-center mb-2">★프리미엄 회원 카드★</span>
								<img src="/images/memberCard.png" class="main-image text-center fixed-size-image mt-1">
						</c:when>
					<c:otherwise>
						<span class="text-center mb-2">★프리미엄 모임 카드★</span>
								<img src="/images/moinCard.png" class="main-image text-center fixed-size-image mt-1">
							</c:otherwise>
						</c:choose>
				</div>
			</div>


	<div class="d-flex">
	  <div class="box p-2 w-100 text-center">
	  <c:choose>
							<c:when test="${productDto.productType == '단건'}">
							<span class="text-center mb-2">★프리미엄 회원 badge 예시(Before)★</span>
		<img src="/images/mypagememberExample.png" class="main-image text-center fixed-size-image mt-1">
		</div> 
	  <div class="box p-2 w-100 text-center">
		<span class="text-center mb-2">★프리미엄 회원 badge 예시(After)★</span>
		<img src="/images/mypagememberExampleAfter.png" class="main-image text-center fixed-size-image mt-3">
							</c:when>
							<c:otherwise>
									<span class="text-center mb-2">★프리미엄 회원 badge 예시(Before)★</span>
		<img src="/images/mymoimExampleBefore.png" class="main-image text-center fixed-size-image mt-1">
		</div> 
	  <div class="box p-2 w-100 text-center">
		<span class="text-center mb-2">★프리미엄 회원 badge 예시(After)★</span>
		<img src="/images/mymoimExampleAfter.png" class="main-image text-center fixed-size-image mt-3">					
							</c:otherwise>
	</c:choose>
	</div>
	</div>





			<div class="d-flex ">
				<div class="box w-100">
					<div>
						
						
				<div class="row">
					<div class="col">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<h4>♥프리미엄 회원권 혜택♥</h4><br>
									<span class="text-start">▶ EeveryFit 프리미엄 회원권은 한번 결제하면 평생 이용이 가능합니다.</span> <br>
									<span class="text-start">▶ 최대 가입 가능한 모임 개수 3 -> 10로 증가 (일반 회원은 최대 3개의 모임에 가입이 가능합니다)</span> <br>
									<span class="text-start">▶ 마이페이지에 프리미엄 회원 뱃지 제공 -> 상단 예시에서 볼 수 있습니다.</span>
									<br><br>
										<c:if test="${memberDto.memberLevel != '프리미엄'}">
											<%-- <a href="pay/purchase?productNo=${productDto.productNo}"
											class="ataglink"> EeveryFIt 프리미엄 회원권 구매하기 </a> --%>
											<a href="#" class="ataglink mb-1 w-50 text-center" onclick="setPurchaseLinkAndOpenModalForMembership('${productDto.productNo}' , '${productDto.productPrice}')"
   											data-toggle="modal" data-target="#membershipModal">EeveryFIt 프리미엄 회원권 구매하기 </a>
										</c:if>
										<c:if test="${memberDto.memberLevel == '프리미엄'}">
											<span style="color: red; text-bold">
											[${memberDto.memberName}(${memberDto.memberEmail})] 님은 "프리미엄" 회원입니다.
											이용해 주셔서 감사합니다.<br>
											최대 10개의 모임에 가입할 수 있습니다!
											</span>	
										</c:if>
							</c:when>
							
							<c:otherwise>
								<h4>♥프리미엄 모임권 혜택♥</h4><br>
								<div class="mb-2">▶ EeveryFit 프리미엄 모임권은 정기결제로 언제든 해지할 수 있습니다.</div>
								<div class="mb-2">▶ 모임 정원 30 -> 100 명으로 증가</div>
								<div class="mb-3">▶ 모임 비활성화 해제 (일반 모임은 1달 후 비활성화 -> 프리미엄 모임권 결제 시, 비활성화 해제)</div>
								<br>
							<h4 class="h5">♥[${memberDto.memberName}(${memberDto.memberEmail})] 님이 모임장으로 이용하고 있는 모임 내역♥</h4><br>
							
							<c:choose>
    <c:when test="${empty MoimDtoList}">
    <button class="btn btn-warning w-25 mb-2">
			<a href="${pageContext.request.contextPath}/moim/create" style="text-decoration:none; color:white;">모임 생성</a>						
		</button>
        <div class="mb-2">▶ 모임장으로 운영중인 모임이 없습니다.</div>
        <div class="mb-2">▶ 모임을 만들어 볼까요? 모임 만들기를 원하시면 모임 생성 버튼을 클릭 해 주세요</div>
        
    </c:when>
    <c:otherwise>
							
							<c:forEach var="MoimDtoList" items="${MoimDtoList}">
							
							
  

							
							<c:if test="${MoimDtoList.moimUpgrade eq 'N'}" >
							
		<%-- 					<a href="pay/periodPurchase?productNo=2&moimNo=${MoimDtoList.moimNo}" --%>
							<a href="#"
							class="ataglink mb-1 w-50 text-center" onclick="setPurchaseLinkAndOpenModal('${MoimDtoList.moimNo}' , '${MoimDtoList.moimTitle}')"
   							data-toggle="modal" data-target="#purchaseModal">
							[${MoimDtoList.moimTitle}] <br> 매월 ${productDto.productPrice}원 (부가세 포함)<br>
							
							</a>
<%-- 								(<a href="/moim/detail?moimNo=${MoimDtoList.moimNo}">모임상세보기</a>) --%>
							<br>
							
							</c:if>
							
							<c:if test="${MoimDtoList.moimUpgrade eq 'Y'}" >
							
							<a href="${pageContext.request.contextPath}/pay/periodPurchase?productNo=2&moimNo=${MoimDtoList.moimNo}"
							class="ataglink mb-1 disabled-link w-50 text-center">
							
							[${MoimDtoList.moimTitle}] 모임은 ${MoimDtoList.moimEndTime} 까지 <br> 프리미엄 등급입니다. <br>이용해 주셔서 감사합니다.
							</a>
<%-- 							(<a href="/moim/detail?moimNo=${MoimDtoList.moimNo}">모임상세보기</a>) --%>
							<br>
							</c:if>
							
							  
							
							
							</c:forEach>

</c:otherwise>
</c:choose>							
							
							
							</c:otherwise>
						</c:choose>
					</div>
				</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



<!-- -------------------------------------------------------------------------------------------- -->

<%-- <hr>
<나중에삭제하겠음>
				<div class="row">
					<div class="col">
					<회원권>
					
						[${memberDto.memberEmail}] - ${memberDto.memberLevel} <br>
<c:forEach var="MoimDtoList" items="${MoimDtoList}">
<모임권>

[${MoimDtoList.moimTitle}] - ${MoimDtoList.moimUpgrade}<br>

</c:forEach>
<c:forEach var="moimTitleForPaymentVO" items="${moimTitleForPaymentVO}">
${moimTitleForPaymentVO}
</c:forEach>

					</div>
				</div> --%>


			</div>
		</div>
	</div>
</div>


<script>
  // 링크 설정 및 모달 열기 함수
  function setPurchaseLinkAndOpenModal(moimNo, moimTitle) {
    var purchaseLink = "pay/periodPurchase?productNo=2&moimNo=" + moimNo;
    $("#purchaseLink").attr("href", purchaseLink);
    $("#purchaseModal").modal("show");
    var currentDate = getCurrentDate();
    var activationDate = addMonths(currentDate, 1); // 현재 날짜에서 1달을 더한 날짜 계산

    // 활성화 날짜 정보를 모달에 출력
    document.getElementById("activationDateInfo").innerHTML = "지금 구매시, [" +
      activationDate.getFullYear() + "년 " +
      (activationDate.getMonth() + 1) + "월 " +
      activationDate.getDate() + "] 일까지 모임권이 활성화됩니다.";
    //할당된 JavaScript 변수를 사용하여 모임 제목 출력
   // var moimTitle = moimNo;
    document.getElementById("moimTitleText").innerText = "["+moimTitle+"] 모임에 대한 프리미엄 1달 모임권을 구매하시겠습니까?";
  }
//모달 닫기 함수
  function closeModal() {
    $("#purchaseModal").modal("hide");
  }
  
//현재 날짜를 가져오는 함수
  function getCurrentDate() {
    var currentDate = new Date();
    return currentDate;
  }

  // 날짜를 더하는 함수
function addMonths(date, months) {
  var result = new Date(date);
  result.setMonth(date.getMonth() + months);
  return result;
}
// 회원권 링크 설정 및 모달 열기 함수
function setPurchaseLinkAndOpenModalForMembership(productNo, productPrice) {
  var purchaseLink = "pay/purchase?productNo=" + productNo;
  $("#membershipPurchaseLink").attr("href", purchaseLink);
  $("#membershipPurchaseModal").modal("show");
  document.getElementById("membershipPriceText").innerText = "프리미엄 회원권의 가격은 "+productPrice+" 원입니다.";
  document.getElementById("membershipText").innerText = "프리미엄  회원권을 구매하시겠습니까?";
}
</script>




<%@ include file="/WEB-INF/views/template/Footer.jsp"%>