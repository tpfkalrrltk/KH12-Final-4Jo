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


<style>
img:hover{
opacity: 0.7
}
</style>

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


			<div
				class="col-2 offset-8 text-center bg-primary rounded-5  text-light me-5  mb-5">
				<a href="/moim/board/list?moimNo=${param.moimNo}" class="text-light"
					style="text-decoration: none">
					<h4 class="">
						<i class="fa-solid fa-pencil "></i> Text List
					</h4>
				</a>
			</div>


			<div class="col-1 mb-5  text-center bg-primary rounded-5  text-light">
				<a href="/moim/board/add?moimNo=${param.moimNo}" class="text-light "
					style="text-decoration: none">
					<h4>
						<i class="fa-solid fa-plus mt-2" id="addIcon"></i>
					</h4>
				</a>
			</div>



		</div>

	</div>

	<div class="container-fluid">
		<div class="col text-center">
			<c:forEach items="${boardList}" var="boardList"
				varStatus="loopStatus">

				<c:if test="${boardList.attachNo>0}">



					<div class=" m-0 p-0 text-start d-inline"
						onClick="location.href='${pageContext.request.contextPath}/moim/board/detail?moimBoardNo=${boardList.moimBoardNo}'"
						style="cursor: pointer;">

						<img alt="" src="${pageContext.request.contextPath}/moimBoard/rest/attach/download?attachNo=${boardList.attachNo}" width="300px" height="300px"
							class="mt-2 object-fit-cover">

					</div>

				</c:if>



				<c:if test="${loopStatus.index % 6 == 5 or loopStatus.last}">
		</div>	</div>
		<div class="row">
			<div class="col  text-center">
				</c:if>

				</c:forEach>
			</div>
		</div>


		<div class="container mt-5">


			<div class="row page-navigator mv-30">
				<!-- 이전 버튼 -->
				<div class="col-1 offset-5">
					<c:if test="${!boardVO.first}">
						<a
							href="${pageContext.request.contextPath}/moim/board/photoList?moimNo=${param.moimNo}&${boardVO.prevQueryString}">
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
									href="${pageContext.request.contextPath}/moim/board/photoList?moimNo=${param.moimNo}&${boardVO.getQueryString(i)}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<!-- 다음 버튼 -->
				<div class="col-1">
					<c:if test="${!boardVO.last}">
						<a
							href="${pageContext.request.contextPath}/moim/board/photoList?moimNo=${param.moimNo}&${boardVO.nextQueryString}">
							<i class="fa-solid fa-angle-right"></i>
						</a>
					</c:if>
				</div>
			</div>

			
					
				</div>

			</div>

		</div>
</body>
</html>

<jsp:include page="../template/Footer.jsp"></jsp:include>