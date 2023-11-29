<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>
<body>
	<div class="container ">

		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">${faqDto.faqTitle}</h1>
			</div>
		</div>
		
		<div class="row me-5 pe-4">
			<a href="${pageContext.request.contextPath}/faq/list"
				style="text-decoration: none"
				class="text-end btn-light fw-bold  p-4 "> 목록으로 돌아가기 </a>
		</div>


<c:if test="${sessionScope.level =='관리자'}">
		<div class="row">

			<div class="col-1 offset-9">

				<a href="${pageContext.request.contextPath}/faq/edit?faqNo=${faqDto.faqNo}" class="text-light"
					style="text-decoration: none">
					<div class="text-center bg-info rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-gear"></i></h7>
					</div>
				</a>
			</div>
			<div class="col-1">
				<a href="${pageContext.request.contextPath}/faq/delete?faqNo=${faqDto.faqNo}" class="text-light"
					style="text-decoration: none">
					<div class="text-center bg-danger rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-trash-can"></i></h7>
					</div>
				</a>
			</div>
		</div>
	
</c:if></div>
	<div class="row mt-3">
		<div class="col-8 offset-2">

			<table class="table">
				<tr class="table-primary text-center ">
					<th class="fw-bold">번호</th>
					<th class="fw-bold">카테고리</th>
					<th class="fw-bold">제목</th>
					<th class="fw-bold">작성시간</th>
				</tr>
				<tr class="text-center">

					<td class="fw-bold text-primary">${faqDto.faqNo}</td>
					<td class="fw-bold text-primary">${faqDto.faqCategory}</td>
					<td class="fw-bold text-primary">${faqDto.faqTitle}</td>
					<td class="fw-bold text-primary">${faqDto.faqTime}<fmt:formatDate
							value="${faqDto.faqTime}" pattern="a h:mm" type="date" />
					</td>
				</tr>


			</table>


			<table class="table">
				<tr class="table table-primary text-center">
					<th class="fw-bold ">내용</th>

				</tr>
				<tr>
					<td class="fw-bold text-primary">

						<div>
							<c:choose>
								<c:when test="${faqImage == null}">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/faq/rest/attach/download?attachNo=${faqImage}"
										class="rounded profile-image" style="max-width: 1100px">
								</c:otherwise>
							</c:choose>
						<textarea cols="150" rows="30" class=" text-primary fw-bold" readonly="readonly" style="resize: none; border: 0"><c:out value="${content}">${faqDto.faqDetail}</c:out></textarea>

						</div>
					</td>

				</tr>


			</table>

		</div>
	</div>


	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>