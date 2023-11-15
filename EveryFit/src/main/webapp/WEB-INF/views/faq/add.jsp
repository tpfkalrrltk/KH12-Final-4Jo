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
	<div class="container ">

		<div class="row mt-5 p-5">
			<div class="col-5 offset-2 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">등록</h1>
			</div>
		</div>




		<div class="row mt-3">
			<div class="col">
				<form action="add" method="post">

					<div class="row">
						<div class="col-5 offset-1">
								<p class="text-primary fw-bold">제목 : </p>
								<input type="text" name="faqTitle"
								class="form-control">
						</div>
					</div>

					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">
							카테고리 :</p> <select name="faqCategory" class="form-select">
								<option>회원</option>
								<option>모임</option>
								<option>운동</option>
								<option>장소</option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="col offset-1">
							<p class="text-primary fw-bold">내용 :</p>
							<textarea rows="30" cols="52" name="faqDetail"
								class="form-control"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-10 offset-1">
							<button type="submit" class="btn btn-primary w-100 m-5">등록</button>
						</div>
					</div>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>