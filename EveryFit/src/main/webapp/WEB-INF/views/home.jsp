<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<div class="m-3 p-3">

	<div class="container-fluid">
		<div class="row">
			<div class="jumbotron">
				<h1 class="display-4">Hello, Every Fit</h1>
				<p class="lead">환영 합니다.</p>
				<hr class="my-4" />
				<p>아마 여기에 스와이퍼 넣을 예정</p>

			</div>
		</div>



		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">모임 목록 (임시)</h1>
			</div>
		</div>

${moimProfileList};
		<div class="row align-items-center">

			<c:forEach var="moimList" items="${moimList}" varStatus="loopStatus">
				<div class="col pe-0">
					<div class="card border-primary mb-3 w-100 " style="max-width: 30rem;">
						<div class="card-header bg-primary text-light ">Moim
							No.${moimList.moimNo}</div>
						<div class="card-body ">

							<c:choose>
								<c:when test=" ${fn:contains(moimProfileList, moimList.moimNo)}">
									<div class="text-center">
										<a href="${pageContext.request.contextPath}/moim/detail?moimNo=${moimList.moimNo}"> <img
											src="${pageContext.request.contextPath}/images/user.png" class="rounded profile-image"
											width="286px" height="200px"></a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="text-center">
										<a href="${pageContext.request.contextPath}/moim/detail?moimNo=${moimList.moimNo}"> <img
											src="${pageContext.request.contextPath}/image?moimNo=${moimList.moimNo}"
											class="rounded profile-image" width="286px" height="200px"></a>
									</div>
								</c:otherwise>
							</c:choose>


							<h4 class="card-title">${moimList.moimTitle}</h4>
							<p class="card-text lead">${moimList.moimContent}</p>
							<a class="btn btn-primary btn-lg fw-bold" href="" role="button">Join</a>
						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		</div>
		<div class="row flex-container  w-250 auto-width">
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