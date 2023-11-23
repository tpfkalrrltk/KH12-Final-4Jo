<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../template/Header.jsp"></jsp:include>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>

<script>
	window.onscroll = function() {
		scrollRotate();
	};

	function scrollRotate() {
		let image = document.getElementById("addIcon");
		image.style.transform = "rotate(" + window.pageYOffset / 1 + "deg)";
	}
</script>



<body>
	<div class="container">

		<div class="row">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">No.${param.moimNo}모임 게시판</h1>
				<div class="row">
					<%--    <a class="btn btn-warning" href="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=공지사항">공지사항</a>
    <button>가입인사</button>
    <button>모임후기</button>
    <button>자유롭게</button> --%>
				</div>
			</div>
		</div>





		<div class="row">



			<div
				class="col-1 offset-10 text-center bg-primary rounded-5  text-light">
				<a href="/moim/board/add?moimNo=${param.moimNo}" class="text-light"
					style="text-decoration: none"> <h7 class="display-4"> <i
						class="fa-solid fa-plus" id="addIcon"></i></h7>
				</a>
			</div>



		</div>



		<table class="table table-hover row">
			<thead>
				<tr class=" table-primary text-center row mt-4">
					<th class="col-2  fw-bold">No</th>
					<th class="col-2  fw-bold">닉네임</th>
					<th class="col-2  fw-bold">제목</th>
					<th class="col-4  fw-bold">작성시간</th>
					<th class="col-2  fw-bold"><select id="categorySelect"
						class="form-select text-primary fw-bold">

							<option value="/moim/board/list?moimNo=${param.moimNo}" checked>카테고리</option>
							<option value="/moim/board/list?moimNo=${param.moimNo}">ALL</option>
							<option
								value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=공지사항">공지사항</option>


							<option
								value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=가입인사">가입인사</option>
							<option
								value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=모임후기">모임후기</option>
							<option
								value="/moim/board/list?moimNo=${param.moimNo}&sortByCategory=자유롭게">자유롭게</option>
					</select> <script>
						// 카테고리가 변경될 때마다 선택된 옵션의 링크로 이동
						document.getElementById('categorySelect')
								.addEventListener('change', function() {
									window.location.href = this.value;
								});
					</script></th>

				</tr>
			</thead>

			<tbody id="boardTable">
				<c:forEach items="${boardList}" var="boardList">
					<tr class="text-center table- row"
						onClick="location.href='${pageContext.request.contextPath}/moim/board/detail?moimBoardNo=${boardList.moimBoardNo}'"
						style="cursor: pointer;">

						<td class="col-2 text-primary fw-bold">${boardList.moimBoardNo}</td>
						<td class="col-2 text-primary fw-bold">${boardList.memberNick}</td>
						<td class="col-2 text-primary fw-bold">${boardList.moimBoardTitle}<c:if
								test="${boardList.moimBoardReplyCount>0}">
							<small>[${boardList.moimBoardReplyCount}]</small>
								</c:if>
						</td>

						<td class="col-4 text-primary fw-bold">${boardList.moimBoardTime}
						  <fmt:formatDate
								value="${boardList.moimBoardTime}" pattern="a h:mm" type="date" />
						</td>
						<td class="col-2 text-primary fw-bold">${boardList.moimBoardCategory}</td>

					</tr>
				</c:forEach>
			</tbody>

		</table>

	</div>
	</div>
	
	
	<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<div class="col-1 offset-5">
			<c:if test="${!boardVO.first}">
				<a
					href="${pageContext.request.contextPath}/moim/board/list?moimNo=${moimNo}&${boardVO.prevQueryString}">
					<i class="fa-solid fa-angle-left text-primary fw-bold"></i>
				</a>
			</c:if>
		</div>
		<!-- 숫자 버튼 -->
		<div class="col-1">
			<c:forEach var="i" begin="${boardVO.begin}" end="${boardVO.end}"
				step="1">
				<c:choose>
					<c:when test="${boardVO.page == i}">
						<a class="on text-primary fw-bold">${i}</a>
					</c:when>
					<c:otherwise>
						<a
							href="${pageContext.request.contextPath}/moim/board/list?moimNo=${moimNo}&${boardVO.getQueryString(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<!-- 다음 버튼 -->
		<div class="col-1">
			<c:if test="${!boardVO.last}">
				<a
					href="${pageContext.request.contextPath}/moim/board/list?moimNo=${moimNo}&${boardVO.nextQueryString}">
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</c:if>
		</div>
	</div>

	<!-- 검색기능 -->


	<div align="center" class="row mt-5 ">
		<div class="col-2 offset-2 p-0">
			<form action="list" method="get">
				<input type="hidden" value="${moimNo}" name="moimNo">
				<c:choose>
					<c:when test="${param.type == 'member_nick'}">
						<select name="type" required="required"
							class="form-select text-primary fw-bold">
							<option value="moim_board_title">제목</option>
							<option value="member_nick" selected="selected">닉네임</option>
							<option value="moim_board_content">내용</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="type" required="required"
							class="form-select text-primary fw-bold">
							<option value="moim_board_title" selected="selected">제목</option>
							<option value="member_nick">닉네임</option>
							<option value="moim_board_content">내용</option>
						</select>
					</c:otherwise>
				</c:choose>
		</div>
		<div class="col-4 p-0">
			<input class="form-control text-primary  fw-bold" type="search"
				name="keyword" required="required" placeholder="검색어를 입력해주세요">
		</div>
		<div class="col-1 ">
			<button class="btn btn-primary w-100 " type="submit"
				style="height: 44px">
				<i class="fa-solid fa-magnifying-glass fa-flip fa-xl"></i>
			</button>
			</form>
		</div>

	</div>
	
	
	
	
</body>
</html>

<jsp:include page="../template/Footer.jsp"></jsp:include>