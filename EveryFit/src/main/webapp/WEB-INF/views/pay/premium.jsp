<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../template/Header.jsp"%>

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
</style>
<div class="m-5 p-5">
	<div class="container-fluid m-5 p-5">
		<div class="row">
			<div class="col-md-8 offset-md-2 col-sm-10 offset-sm-1">



				<div class="row">
					<div class="col">
						<h1 class="text-center">${productDto.productName}</h1>
					</div>
				</div>
				
			
				<div class="row">
					<div class="col">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<h3 class="text-center">EeveryFIt 프리미엄 멤버가 되어 보세요!</h3>
								
							</c:when>
							<c:otherwise>
								<h3 class="text-center">EeveryFit 프리미엄 모임으로 업그레이드 해보세요!</h3>
								
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<span class="text-center ms-5">EeveryFit 프리미엄 회원권은 한번
							결제하면 평생 이용이 가능합니다.</span>
								<div class="row">
									<div class="col text-center">
										<img src="/images/memberCard.png" class="main-image text-center">
									</div>
								</div>
								<div class="row">
					<div class="col-1">

						<div class="row">
							<div class="col">
								<h1 class="text-center mt-3 ms-5">
								
									<i class="fa-regular fa-hand-point-right"></i>
								</h1>
							</div>
						</div>

					</div>

					<div class="col-10">
						<div class="row">
							<div class="col ms-5 mt-3 ">가입모임 개수 증가</div>
						</div>
						<div class="row">
							<div class="col ms-5">모임 가입 최대 10개까지 늘리기<br>
							(일반 회원은 최대 3개의 모임에 가입이 가능합니다)
							</div>
							
						</div>
					</div>
				</div>
							</c:when>
							<c:otherwise>
								<span class="text-center ms-5">
								EeveryFIt 프리미엄 모임권 구독은 매월/매년 자동결제되고 언제든 해지가능합니다.
								</span>
								<div class="row">
									<div class="col text-center">
										<img src="/images/moinCard.png" class="main-image img-thumbnail text-center">
									</div>
								</div>
								<div class="row">
					<div class="col-2 mt-5">

						<div class="row">
							<div class="col">
								<h1 class="text-center mt-3 ms-3">
									<i class="fa-regular fa-face-grin-stars"></i>
								</h1>
							</div>
						</div>

					</div>

					<div class="col-8">
						<div class="row">
							<div class="col  mt-5">모임 사용 가능 일수 늘리기</div>
						</div>
						<div class="row">
							<div class="col">비활성화 해제 (일반 모임은 1달 후 비활성화로 변경됩니다.)
							</div>
						</div>
					</div>
				</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				
				





				<div class="row mt-3">
					<div class="col text-center">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
							<c:if test="${memberDto.memberLevel != '프리미엄'}">
								<a href="pay/purchase?productNo=${productDto.productNo}"
									class="ataglink"> EeveryFIt 프리미엄 회원권 구매하기 </a>
							</c:if>
								<c:if test="${memberDto.memberLevel == '프리미엄'}">
								<span style="color: red; text-bold">
								${memberDto.memberEmail} 님은 이미 "프리미엄" 회원입니다.
								이용해 주셔서 감사합니다
								</span>	
							</c:if>
							</c:when>
							<c:otherwise>

<%-- 							<c:forEach var="moimMemberDto" items="${list}">
							<a href="pay/periodPurchase?productNo=2&moimNo=${moimMemberDto.moimNo}">
							[${moimMemberDto.moimNo}] EeveryFIt 프리미엄 모임권 구매하기
							</a>
								<a href="/moim/detail?moimNo=${moimMemberDto.moimNo}">모임상세보기</a>
							<br>
							</c:forEach> --%>

							<c:forEach var="MoimDtoList" items="${MoimDtoList}">
							<c:if test="${MoimDtoList.moimUpgrade eq 'N'}" >
							
							
							

							<a href="pay/periodPurchase?productNo=2&moimNo=${MoimDtoList.moimNo}"
							class="ataglink mb-1">
							<%-- [${MoimDtoList.moimNo}] --%>[${MoimDtoList.moimTitle}] 모임에 대한 EeveryFIt 프리미엄 모임권 구매하기
							
							</a>
								(<a href="/moim/detail?moimNo=${MoimDtoList.moimNo}">모임상세보기</a>)
								
							<br>
							
							</c:if>
							
														<c:if test="${MoimDtoList.moimUpgrade eq 'Y'}" >
							
							
							

							<a href="pay/periodPurchase?productNo=2&moimNo=${MoimDtoList.moimNo}"
							class="ataglink mb-1 disabled-link">
							<%-- [${MoimDtoList.moimNo}] --%>[${MoimDtoList.moimTitle}] 모임은 프리미엄 등급입니다
							
							</a>
								(<a href="/moim/detail?moimNo=${MoimDtoList.moimNo}">모임상세보기</a>)
								
							<br>
							
							</c:if>
							</c:forEach>

							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
<hr>
<나중에삭제하겠음>
				<div class="row">
					<div class="col">
					<회원권>
						[${memberDto.memberEmail}] - ${memberDto.memberLevel} <br>
<c:forEach var="MoimDtoList" items="${MoimDtoList}">
<모임권>
[${MoimDtoList.moimTitle}] - ${MoimDtoList.moimUpgrade}<br>

</c:forEach>
					</div>
				</div>


			</div>
		</div>
	</div>
</div>
<%@ include file="../template/Footer.jsp"%>