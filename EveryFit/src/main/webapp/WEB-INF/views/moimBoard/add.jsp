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

				<h1 class="display-5 fw-bold">등록</h1>
			</div>
		</div>

		<div class="row">
				<a href="/moim/board/list?moimNo=${param.moimNo}" 
				style="text-decoration: none" class="text-end btn-light fw-bold">목록으로 돌아가기
				</a>
		</div>

		
		

		<div class="row mt-3">
			<div class="col">
				<form action="add" method="post">
				
				<input type="hidden" name="moimNo" value = "${param.moimNo}" style="width : 450px;" 
				class="form-control  fw-bold bg-primary text-light">
					<div class="row">
						<div class="col-5">
							<p class="text-primary fw-bold">카테고리 : </p><select  name="moimBoardCategory"class="form-select  fw-bold bg-primary text-light">
								<option>공지사항</option>
								<option>가입인사</option>
								<option>모임후기</option>
								<option>자유롭게</option>
							</select>
						</div>
					</div>
					
					<div class="row">
						<div class="col">
						<p class="text-primary fw-bold">제목 : </p>
						</div>
					</div>
					
					<div class="row">
						<div class="col-2">
							<input type="text" name="moimBoardTitle" style="width : 450px;" class="form-control  fw-bold bg-primary text-light">
						</div>
					</div>



					<div class="row">
						<div class="col ">
					<p class="text-primary fw-bold">내용 : </p>
						</div>
					</div>
					
					<div class="row">
						<div class="col">
							<textarea rows="30" cols="52" name="moimBoardContent" class="form-control  fw-bold bg-primary text-light"></textarea>
						</div>
						
					</div>
					
					
					<button type="submit" class="btn btn-primary w-100 mt-5">등록</button>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>