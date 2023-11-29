<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>
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

<script>
$(function() {
let mainFrames = [ {
	opacity : 1,
	
	transform : "translate(0, 30px)"
}, {
	opacity : 0.2,

	transform : "translate(0, 0px)"
}, {
	opacity : 1,

	transform : "translate(0px, 30px)"
} ];
let mainOptions = {
	delay : 0000,
	duration : 1500,
	easing : "ease-in",
	iterations : 1,
	fill : "forwards"
};

document.querySelector("#main-text").animate(mainFrames, mainOptions);

});
</script>





<body>
	<div class="container ">

		<div class="row mt-5 p-5" id="main-text">
			<div class="col-4 offset-4 p-2 m-4 bg-primary rounded-3  text-light"
				onload="hello()">
				<h1 class="display-5 offset-1 fw-bold fst-italic">Free Board</h1>
			</div>
		</div>






		<div class="row">



			<div
				class="col-2 offset-8 text-center bg-primary rounded-5  text-light me-5">
				<a href="${pageContext.request.contextPath}/freeBoard/photoList"
					class="text-light" style="text-decoration: none">
					<h4>
						<i class="fa-regular fa-image"></i> Photo List
					</h4>
				</a>
			</div>


			<div class="col-1  text-center bg-primary rounded-5  text-light">
				<a href="${pageContext.request.contextPath}/freeBoard/add"
					class="text-light" style="text-decoration: none">
					<h4>
						<i class="fa-solid fa-plus" id="addIcon"></i>
					</h4>
				</a>
			</div>




			<table class="table table-hover row">
				<thead>
					<tr class=" table-primary text-center row mt-4">
						<th class="col-2  fw-bold">번호</th>
						<th class="col-2  fw-bold">카테고리</th>
						<th class="col-4  fw-bold">제목</th>
						<th class="col-2  fw-bold">닉네임</th>
						<th class="col-2  fw-bold">작성시간</th>
					</tr>
				</thead>

				<tbody>



					<c:forEach items="${FreeBoardList}" var="FreeBoardList">

						<tr class="text-center table- row"
							onClick="location.href='${pageContext.request.contextPath}detail?freeBoardNo=${FreeBoardList.freeBoardNo}'"
							style="cursor: pointer;">

							<td class="col-2 text-primary fw-bold">${FreeBoardList.freeBoardNo}</td>
							<td class="col-2 text-primary fw-bold">${FreeBoardList.freeBoardCategory}</td>
							<td class="col-4 text-primary fw-bold text-start">
								${FreeBoardList.freeBoardTitle} <c:if
									test="${FreeBoardList.freeBoardReplyCount>0}">
									<small>[${FreeBoardList.freeBoardReplyCount}]</small>
								</c:if> </a>
							</td>

							<c:choose>
								<c:when test="${FreeBoardList.memberNick==null}">
									<td class="col-2 text-primary fw-bold">--탈퇴한 회원--</td>
								</c:when>

								<c:otherwise>
									<td class="col-2 text-primary fw-bold">${FreeBoardList.memberNick}</td>
								</c:otherwise>
							</c:choose>
							<td class="col-2 text-primary fw-bold">${FreeBoardList.freeBoardTime}
								<fmt:formatDate value="${FreeBoardList.freeBoardTime}"
									pattern="a h:mm" type="date" />
							</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>

		</div>
	</div>
	</div>




	<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<div class="col-1 offset-5">
			<c:if test="${!boardVO.first}">
				<a
					href="${pageContext.request.contextPath}/freeBoard/list?${boardVO.prevQueryString}">
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
							href="${pageContext.request.contextPath}/freeBoard/list?${boardVO.getQueryString(i)}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<!-- 다음 버튼 -->
		<div class="col-1">
			<c:if test="${!boardVO.last}">
				<a
					href="${pageContext.request.contextPath}/freeBoard/list?${boardVO.nextQueryString}">
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</c:if>
		</div>
	</div>

	<!-- 검색기능 -->


	<div align="center" class="row mt-5 ">
		<div class="col-2 offset-2 p-0">
			<form action="list" method="get">

				<c:choose>
					<c:when test="${param.type == 'member_nick'}">
						<select name="type" required="required"
							class="form-select text-primary fw-bold">
							<option value="free_board_title">제목</option>
							<option value="member_nick" selected="selected">닉네임</option>
							<option value="free_board_content">내용</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="type" required="required"
							class="form-select text-primary fw-bold">
							<option value="free_board_title" selected="selected">제목</option>
							<option value="member_nick">닉네임</option>
							<option value="free_board_content">내용</option>
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
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>