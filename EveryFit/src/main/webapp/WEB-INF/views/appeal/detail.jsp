<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
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

				<h1 class="display-5 fw-bold">${appealDto.appealReason}</h1>
			</div>
		</div>
		<a href="/appeal/list" style="text-decoration: none"
			class="text-light ">
			<div
				class="text-center me-5 mb-2  bg-primary col-2  offset-9 text-light rounded-3 fw-bold"
				style="width: 150px">목록 전환</div>
		</a>

		<div class="row mt-3">
			<div class="col-10 offset-1">

				<table class="table">
					<tr class="table-primary text-center ">
						<th class="fw-bold">번호</th>
						<th class="fw-bold">카테고리</th>
						<th class="fw-bold">아이디</th>
						<th class="fw-bold">시간</th>


					</tr>
					<tr class="text-center">

						<td class="fw-bold text-primary">${appealDto.appealNo}</td>
						<td class="fw-bold text-primary">${appealDto.appealCategory}</td>
							<td class="fw-bold text-primary">${appealDto.memberEmail}</td>
						<td class="fw-bold text-primary">${appealDto.appealTime}<fmt:formatDate
								value="${appealDto.appealTime}" pattern="a h:mm" type="date" />
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
									<c:when test="${appealImage == null}">
									</c:when>
									<c:otherwise>
										<img
											src="/rest/report/attach/download?attachNo=${appealImage}"
											class="rounded profile-image" style="max-width: 1060px">
									</c:otherwise>
								</c:choose>
								${appealDto.appealContent}
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