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

		<div class="row">
				<a href="/moim/board/list?moimNo=${moimBoardDto.moimNo}" >목록으로 돌아가기
				</a>
		</div>

		
		

		<div class="row mt-3">
			<div class="col">
				<form action="edit" method="post">
				
				<input type="text" name="moimBoardNo" value = "${moimBoardDto.moimBoardNo}" style="width : 450px;">
				<input type="text" name="moimNo" value = "${moimBoardDto.moimNo}" style="width : 450px;">
					<div class="row">
						<div class="col-5">
							카테고리 : <select  name="moimBoardCategory" >
    <c:forEach items="${moimBoardDto.moimBoardCategory}" var="category">
        <option value="${category}" ${category eq moimBoardDto.moimBoardCategory ? 'selected' : ''}>${category}</option>
    </c:forEach>
							</select>
						</div>
					</div>
					
					<div class="row">
						<div class="col">
							제목 :
						</div>
					</div>
					
					<div class="row">
						<div class="col-2">
							<input type="text" name="moimBoardTitle" value="${moimBoardDto.moimBoardTitle}" style="width : 450px;">
						</div>
					</div>



					<div class="row">
						<div class="col">
							내용 :
						</div>
					</div>
					
					<div class="row">
						<div class="col">
							<textarea rows="30" cols="52" name="moimBoardContent" >${moimBoardDto.moimBoardContent}	</textarea>
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