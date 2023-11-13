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
</style>
<div class="m-5 p-5">
	<div class="container-fluid m-5 p-5">
		<div class="row">
			<div class="col-md-8 offset-md-2 col-sm-10 offset-sm-1">



				<div class="row">
					<div class="col">
						<h1 class="text-center border">${productDto.productName}</h1>
					</div>
				</div>
				
			
				<div class="row">
					<div class="col">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<h3 class="text-center border">EeveryFIt 프리미엄 멤버가 되어 보세요!</h3>
							</c:when>
							<c:otherwise>
								<h3 class="text-center border">EeveryFIt 프리미엄 모임으로 업그레이드 해보세요!</h3>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						<c:choose>
							<c:when test="${productDto.productType == '단건'}">
								<span class="text-center border">EeveryFIt 프리미엄 회원권은 한번
							결제하면 평생 이용이 가능합니다.</span>
								<div class="row">
									<div class="col text-center">
										<img src="/images/memberCard.png" class="main-image img-thumbnail text-center">
									</div>
								</div>
								<div class="row">
					<div class="col-2">

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
							<div class="col">가입모임 개수 증가</div>
						</div>
						<div class="row">
							<div class="col">모임 가입 최대 10개까지 늘리기 (일반 회원은 모임 가입 최대 3개입니다)
							</div>
						</div>
					</div>
				</div>
							</c:when>
							<c:otherwise>
								<span class="text-center border">
								EeveryFIt 프리미엄 모임권 구독은 매월/매년 자동결제되고 언제든 해지가능합니다.
								</span>
								<div class="row">
									<div class="col text-center">
										<img src="/images/moinCard.png" class="main-image img-thumbnail text-center">
									</div>
								</div>
								<div class="row">
					<div class="col-2">

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
							<div class="col">가입모임 개수 증가</div>
						</div>
						<div class="row">
							<div class="col">모임 가입 최대 10개까지 늘리기 (일반 회원은 모임 가입 최대 3개입니다)
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
								<a href="pay/purchase?productNo=${productDto.productNo}"
									class="ataglink"> EeveryFIt 프리미엄 회원권 구매하기 </a>
							</c:when>
							<c:otherwise>
								<a href="pay/periodPurchase?productNo=${productDto.productNo}"
									class="ataglink"> EeveryFIt 프리미엄 모임권 구매하기 </a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>



			</div>
		</div>
	</div>
</div>
<%@ include file="../template/Footer.jsp"%>