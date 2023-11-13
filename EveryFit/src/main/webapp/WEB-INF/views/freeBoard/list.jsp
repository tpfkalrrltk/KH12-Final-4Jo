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
	<div class="container">

		<div class="row">
			<div class="col-5 offset-2 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">자유 게시판</h1>
			</div>
		</div>


		<div class="row">
			<div class="col-2 offset-7 text-center bg-primary rounded-3  text-light">

			<h7 class="display-5">등록</h7>
			
				</div>
		</div>

		<div class="row mt-3">
			<div class="col-10">

				<table class="table">
					<tr class="table table-primary">
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>닉네임</th>
					</tr>
					<c:forEach items="${FreeBoardList}" var="FreeBoardList">
						<td>${FreeBoardList.freeBoardNo}</td>
						<td>${FreeBoardList.freeBoardCategory}</td>
						<td>${FreeBoardList.freeBoardTitle}</td>
						<td>${FreeBoardList.memberNick}</td>
						</tr>
					</c:forEach>
					<tr>
				</table>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>