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
				<h1 class="display-5 fw-bold">Moim 게시판</h1>
				<div class="row">
<%--    <a class="btn btn-warning" href="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=공지사항">공지사항</a>
    <button>가입인사</button>
    <button>모임후기</button>
    <button>자유롭게</button> --%>
</div>
			</div>
		</div>


		<div class="row">


			<a href="/moim/board/add?moimNo=${param.moimNo}" class="text-dark" style="text-decoration: none">
<!-- 				<div class="col-1 offset-10 text-center bg-primary rounded-5 text-light">
					
					<i class="fa-solid fa-plus display-3"></i>
					
				</div> -->
				<h1>등록 하기</h1>
			</a>

		</div>



		<table class="table table-hover row">
			<thead>
				<tr class=" table-primary text-center row mt-4">
					<th class="col-2  fw-bold">모임게시판번호</th>
					<th class="col-2  fw-bold">모임번호</th>
					<th class="col-2  fw-bold">모임멤버</th>
					<th class="col-2  fw-bold">제목</th>
					<th class="col-2  fw-bold">내용</th>
					<th class="col-2  fw-bold">
					<select id="categorySelect" class="form-select">
					
						<option value="/moim/board/list?moimNo=${param.moimNo}" checked>카테고리</option>
						<option value="/moim/board/list?moimNo=${param.moimNo}" >ALL</option>
                        <option value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=공지사항">공지사항</option>
					
                        
                        <option value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=가입인사">가입인사</option>
                        <option value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=모임후기">모임후기</option>
                        <option value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=자유롭게">자유롭게</option>
                    </select>
                    <script>
                        // 카테고리가 변경될 때마다 선택된 옵션의 링크로 이동
                        document.getElementById('categorySelect').addEventListener('change', function () {
                            window.location.href = this.value;
                        });
                    </script>
					</th>
	
				</tr>
			</thead>

			<tbody id="boardTable">
				<c:forEach items="${boardList}" var="boardList">
					<tr class="text-center table- row" onClick="location.href='${pageContext.request.contextPath}/moim/board/detail?moimBoardNo=${boardList.moimBoardNo}'" style="cursor:pointer;">

						<td class="col-2">${boardList.moimBoardNo}</td>
						<td class="col-2">${boardList.moimNo}</td>
						<td class="col-2">${boardList.memberEmail}</td>
						<td class="col-2">${boardList.moimBoardTitle}</td>
						<td class="col-2">${boardList.moimBoardContent}</td>
						<td class="col-2">
						${boardList.moimBoardCategory}
						</td>
			
					</tr>
				</c:forEach>
			</tbody>

		</table>


	</div>


	</div>
</body>
</html>

<jsp:include page="../template/Footer.jsp"></jsp:include>