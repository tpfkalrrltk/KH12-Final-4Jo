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

				<h1 class="display-5 fw-bold">수정</h1>
			</div>
		</div>




		<div class="row mt-3">
			<div class="col">
				<form action="add" method="post">

					<div class="row">
						<div class="col-2">
							제목 : <input type="text" name="faqTitle"
								value="${faqDto.faqTitle}">
						</div>
					</div>

					<div class="row">
						<div class="col-5">
							카테고리 : <select name="faqCategory"
								value="${faqDto.faqCategory}">
								<option class="fw-bold">회원</option>
								<option class="fw-bold">모임</option>
								<option class="fw-bold">운동</option>
								<option class="fw-bold">장소</option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="col">
							내용 :
							<textarea rows="30" cols="52" name="freeBoardContent"
								>${faqDto.faqContent}</textarea>
						</div>
					</div>
					<button type="submit" class="btn btn-primary">수정</button>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>