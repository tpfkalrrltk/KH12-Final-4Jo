<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<%@ include file="template/adminHeader.jsp"%>

<%--
<c:choose>
	<c:when test="${sessionScope.level =='운영자' }">
		<%@ include file="template/adminHeader.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="template/Header.jsp"%>
	</c:otherwise>
</c:choose> 
--%>

<!-- CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<!-- JS -->
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>
	$(function() {
		const swiper = new Swiper('.swiper', {
			// Optional parameters
			direction : 'vertical',
			loop : true,

			// If we need pagination
			pagination : {
				el : '.swiper-pagination',
			},

			// Navigation arrows
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},

			// And if we need scrollbar
			scrollbar : {
				el : '.swiper-scrollbar',
			},
		});
	});
</script>
<style>
.swiper {
	width: 1200px;
	height: 200px;
}
</style>

<div class="m-3 p-3">

	<div class="container-fluid">


		<div class="swiper">
			<!-- Additional required wrapper -->
			<div class="swiper-wrapper">
				<!-- Slides -->
				<div class="swiper-slide">
					<img src="images/swiper1.jpg" width="1100px" height="200px">
				</div>
				<div class="swiper-slide">
					<img src="images/swiper2.jpg" width="1100px" height="200px">
				</div>
				<div class="swiper-slide">
					<img src="images/swiper3.jpg" width="1100px" height="200px">
				</div>
				<div class="swiper-slide">
					<img src="images/swiper4.jpg" width="1100px" height="200px">
				</div>
				...
			</div>
			<!-- If we need pagination -->
			<div class="swiper-pagination"></div>

			<!-- If we need navigation buttons -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>

			<!-- If we need scrollbar -->
			<div class="swiper-scrollbar"></div>
		</div>





		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">Premium</h1>
			</div>
		</div>


		<div class="row align-items-center m-5">

			<c:forEach var="PremiumMoimList" items="${PremiumMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0 ">
					<div class="card border-primary mb-3 w-100 "
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light ">Moim
							No.${PremiumMoimList.moimNo}</div>
						<div class="card-body ">


							<div class="text-center">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${PremiumMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${PremiumMoimList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>


							<h4 class="card-title">${PremiumMoimList.moimTitle}</h4>
							<p class="card-text lead">${PremiumMoimList.moimContent}</p>
							<a class="btn btn-primary btn-lg fw-bold" href="" role="button">Join</a>
						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		</div>
		<div class="row contaner-fluid  auto-width m-5">
			</c:if>
			</c:forEach>

		</div>



		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">최근 생성된 모임</h1>
			</div>
		</div>


		<div class="row align-items-center m-5" >

			<c:forEach var="NewMoimList" items="${NewMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0" >
					<div class="card border-primary mb-3 w-100" 
						style="max-width: 400px; ">
						<div class="card-header bg-primary text-light ">Moim
							No.${NewMoimList.moimNo}</div>
						<div class="card-body ">


							<div class="text-center">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${NewMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${NewMoimList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>


							<h4 class="card-title">${NewMoimList.moimTitle}</h4>
							<p class="card-text lead">${NewMoimList.moimContent}</p>
							<a class="btn btn-primary btn-lg fw-bold" href="" role="button">Join</a>
						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		</div>
		<div class="row contaner-fluid  auto-width m-5">
			</c:if>
			</c:forEach>


		</div>


		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">여성전용 모임 (최신순)</h1>
			</div>
		</div>


		<div class="row align-items-center m-5">

			<c:forEach var="GenderCheckMoimList" items="${GenderCheckMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0 ">
					<div class="card border-primary mb-3 w-100 "
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light ">Moim
							No.${GenderCheckMoimList.moimNo}</div>
						<div class="card-body ">


							<div class="text-center">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${GenderCheckMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${GenderCheckMoimList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>


							<h4 class="card-title">${GenderCheckMoimList.moimTitle}</h4>
							<p class="card-text lead">${GenderCheckMoimList.moimContent}</p>
							<a class="btn btn-primary btn-lg fw-bold" href="" role="button">Join</a>
						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		</div>
		<div class="row contaner-fluid  auto-width m-5">
			</c:if>
			</c:forEach>

		</div>




	</div>
</div>
</div>
<div class="col">
	<div class="jumbotron">
		<h1 class="display-4">Hello, Every Fit</h1>
		<p class="lead">This is a simple hero unit, a simple
			jumbotron-style component for calling extra attention to featured
			content or information.</p>
		<hr class="my-4" />
		<p>It uses utility classes for typography and spacing to space
			content out within the larger container.</p>

	</div>



	<%@ include file="template/Footer.jsp"%>