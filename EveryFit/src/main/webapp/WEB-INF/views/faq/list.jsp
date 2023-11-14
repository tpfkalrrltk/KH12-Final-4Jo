<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/Header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>
<body>
	<div class="container mt-5 pt-5">

		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">FAQ</h1>
			</div>
		</div>


		<div class="row">


			<a href="add" class="text-light" style="text-decoration: none">
				<div
					class="col-1 offset-10 text-center bg-primary rounded-5  text-light">
					<h7 class="display-4"> <i class="fa-solid fa-plus"></i></h7>
				</div>
			</a>

		</div>



		<table class="table table-hover row">
			<thead>
				<tr class=" table-primary text-center row mt-4">
					<th class="col-2  fw-bold">번호</th>
					<th class="col-2  fw-bold">카테고리</th>
					<th class="col-5  fw-bold">제목</th>
					<th class="col-3  fw-bold">작성자</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${faqList}" var="faqList">
					<tr class="text-center table- row">

						<td class="col-2">${faqList.faqNo}</td>
						<td class="col-2">${faqList.faqCategory}</td>
						<td class="col-5"><a href="detail?faqNo=${faqList.faqNo}"
							style="text-decoration: none" class="text-primary fw-bold">
								${faqList.faqTitle}</a></td>
						<td class="col-3">운영자</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>

	</div>
	</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>