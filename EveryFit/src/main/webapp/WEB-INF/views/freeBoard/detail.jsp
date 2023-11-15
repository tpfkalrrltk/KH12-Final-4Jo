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

<style>
textarea {
	width: 100%;
	height: 6.25em;
	border: none;
	resize: none;
}
</style>


<script>
	
</script>







<script id="reply-template" type="text/template">
		<div class="row bg-primary">
			<div class="col-3">
					<p class="replyWriter">작성자</p>
				<div class="col-9">
					<pre class="replyContent">내용</pre>
				</div>
			</div>
			<div class="w-25 row">
				<div class="col-5 right">
					<button class="btn btn-edit btn-navy">
						<i class="fa-solid fa-edit"></i>
						수정
					</button>
				</div>
				<div class="col-5 right">
					<button class="btn btn-orange btn-delete">
						<i class="fa-solid fa-trash"></i>
						삭제
					</button>
				</div>
			</div>
		</div>
</script>
<script id="reply-edit-template" type="text/template">
		<form class="reply-edit-form edit-container">
		<input type="hidden" name="replyNo" value="?">
		<div class="row flex-container">
			<div class="w-75">
				<textarea name="replyContent" class="form-input w-100" rows="4"></textarea>
			</div>
			<div class="w-25">
				<div class="row right">
					<button type="submit" class="btn btn-positive">
						<i class="fa-solid fa-check"></i>
						수정
					</button>
				</div>
				<div class="row right">
					<button type="button" class="btn btn-negative btn-cancel">
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
			</div>
		</div>
		</form>
</script>



<body>
	<div class="container ">

		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">${freeBoardDto.freeBoardTitle}</h1>
			</div>
		</div>



		<div class="row">

			<div class="col-1 offset-9">

				<a href="edit?freeBoardNo=${freeBoardDto.freeBoardNo}"
					class="text-light" style="text-decoration: none">
					<div class="text-center bg-info rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-gear"></i></h7>
					</div>
				</a>
			</div>
			<div class="col-1">
				<a href="delete?freeBoardNo=${freeBoardDto.freeBoardNo}"
					class="text-light" style="text-decoration: none">
					<div class="text-center bg-danger rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-trash-can"></i></h7>
					</div>
				</a>
			</div>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col-8 offset-2">

			<table class="table">
				<tr class="table-primary text-center ">
					<th class="fw-bold">번호</th>
					<th class="fw-bold">카테고리</th>
					<th class="fw-bold">제목</th>
					<th class="fw-bold">닉네임</th>
				</tr>
				<tr class="text-center">

					<td class="fw-bold text-primary">${freeBoardDto.freeBoardNo}</td>
					<td class="fw-bold text-primary">${freeBoardDto.freeBoardCategory}</td>
					<td class="fw-bold text-primary">${freeBoardDto.freeBoardTitle}</td>
					<td class="fw-bold text-primary">${freeBoardDto.memberNick}</td>
				</tr>


			</table>


			<table class="table">
				<tr class="table table-primary text-center">
					<th class="fw-bold ">내용</th>

				</tr>
				<tr>
					<td class="fw-bold text-primary">${freeBoardDto.freeBoardContent}</td>

				</tr>


			</table>

			<div class="row  ps-2 ms-2">
				<div class="col-3 offset-4 p-3 m-4 bg-primary rounded-3  text-light"
					style="height: 100px">

					<h1 class="display-5 fw-bold">Comment</h1>
				</div>
			</div>

			<div class="container reply-list "></div>



			<form class="reply-insert-form" method="post">
				<input type="hidden" name="freeBoardNo"
					value="${freeBoardDto.freeBoardNo}">
				<div class="row">
					<textarea class="form-input  bg-primary  text-light fw-bold"
						name="replyContent" rows="4"></textarea>
				</div>
				<div class="row">
					<button
						class="btn btn-positive w-50 bg-primary text-light fw-bold mt-3 offset-3">
						<i class="fa-solid fa-pen text-light"></i>Comment insert
					</button>
				</div>
			</form>




		</div>
	</div>


	</div>


</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>