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

				<h1 class="display-5 fw-bold">상세</h1>
			</div>
		</div>


		<div class="row">
			<div
				class="col-2 offset-7 text-center bg-primary rounded-3  text-light">

				<a href="edit?freeBoardNo=${freeBoardDto.freeBoardNo}"
					class="text-light" style="text-decoration: none"> <h7
						class="display-5">수정</h7></a>


			</div>
		</div>


		<div class="row ">
			<div
				class="col-2 offset-7 text-center bg-danger rounded-3  text-light">

				<a href="delete?freeBoardNo=${freeBoardDto.freeBoardNo}"
					class="text-light" style="text-decoration: none">
					 <h7 class="display-5">삭제</h7></a>


			</div>
		</div>

		<div class="row mt-3">
			<div class="col-10">

				<table class="table">
					<tr class="table table-primary text-center">
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>닉네임</th>
					</tr>
					<tr class="text-center">
						
						<td>${freeBoardDto.freeBoardNo}</td>
						<td>${freeBoardDto.freeBoardCategory}</td>
						<td>${freeBoardDto.freeBoardTitle}</td>
						<td>${freeBoardDto.memberNick}</td>
					</tr>


				</table>


				<table class="table">
					<tr class="table table-primary text-center">
						<th>내용</th>

					</tr>
					<tr>
						<td>${freeBoardDto.freeBoardContent}</td>

					</tr>


				</table>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>