<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>
<c:forEach items="${boardList}" var="boardList">
    <tr class="text-center table- row" onClick="location.href='${pageContext.request.contextPath}/moim/board/detail?moimBoardNo=${boardList.moimBoardNo}'" style="cursor:pointer;">
        <td class="col-2">${boardList.moimBoardNo}</td>
        <td class="col-2">${boardList.moimNo}</td>
        <td class="col-2">${boardList.memberEmail}</td>
        <td class="col-2">${boardList.moimBoardTitle}</td>
        <td class="col-2">${boardList.moimBoardContent}</td>
        <td class="col-2">${boardList.moimBoardCategory}</td>
    </tr>
</c:forEach>
<h1>dddd</h1>


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
    <button onclick="getBoardListByCategory('공지사항')">공지사항</button>
    <button onclick="getBoardListByCategory('가입인사')">가입인사</button>
    <button onclick="getBoardListByCategory('모임후기')">모임후기</button>
    <button onclick="getBoardListByCategory('자유롭게')">자유롭게</button>
</div>
			</div>
		</div>


		<div class="row">


			<a href="${pageContext.request.contextPath}/moim/board/add?moimNo=${param.moimNo}" class="text-dark" style="text-decoration: none">
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
					<th class="col-2  fw-bold">카테고리</th>
	
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
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>