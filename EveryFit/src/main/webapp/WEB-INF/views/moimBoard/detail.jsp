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
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">${moimBoardDto.moimBoardTitle}</h1>
			</div>
		</div>

		<div class="row">
				<a href="/moim/board/list?moimNo=${moimBoardDto.moimNo}" >
					목록으로 돌아가기
				</a>
		</div>

		<div class="row">

			<div class="col-1 offset-9">
				<a href="edit?moimBoardNo=${moimBoardDto.moimBoardNo}"
					class="text-light" style="text-decoration: none">
					<div class="text-center bg-info rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-gear"></i></h7>
					</div>
				</a>
			</div>
			<div class="col-1">
				<a href="delete?moimBoardNo=${moimBoardDto.moimBoardNo}"
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

				</tr>
				<tr class="text-center">

					<td class="fw-bold text-primary">${moimBoardDto.moimBoardNo}</td>
					<td class="fw-bold text-primary">${moimBoardDto.moimBoardCategory}</td>
					<td class="fw-bold text-primary">${moimBoardDto.moimBoardTitle}</td>

				</tr>


			</table>

			<div class="fw-bold text-center text-bg-primary" >
			내용
			</div>
			<div class="fw-bold text-primary" style= "border: 1px solid white;">
			${moimBoardDto.moimBoardContent}<hr>
			</div>
			
			

 <div class="row  ps-2 ms-2">
                        <div class="col-3 offset-4 p-3 m-4 bg-primary rounded-3  text-light" style="height: 100px">

                            <h1 class="display-5 fw-bold ms-4">Comment</h1>
                        </div>
                    </div>

                    <div class="container reply-list"></div>


                    <c:if test="${sessionScope.name != null }">

                        <form class="reply-insert-form p-2 m-2" method="post">
                            <input type="hidden" name="freeBoardNo" value="${freeBoardDto.freeBoardNo}">
                            <div class="row ">
                                <textarea class="form-input  bg-primary  text-light fw-bold "
                                    name="freeBoardReplyContent" rows="4"></textarea>
                            </div>
                            <div class="row">
                                <button type="submit"
                                    class="btn btn-positive w-50 bg-primary text-light fw-bold mt-3 offset-3">
                                    <i class="fa-solid fa-pen text-light"></i>Comment insert
                                </button>
                            </div>
                        </form>

                    </c:if>


                </div>

		</div>
	</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>