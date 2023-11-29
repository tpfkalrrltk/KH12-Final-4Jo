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
	<div class="container">

	<div class="row mt-5 p-5" id="main-text">
				<div class="col-4 offset-4 p-2 m-4 bg-primary rounded-3  text-light" onload="hello()">
				<h1 class="display-5 offset-1 fw-bold fst-italic">Free Board</h1>
			</div>
		</div>

		<div class="row">


			<div
				class="col-2 offset-8 text-center bg-primary rounded-5  text-light me-5  mb-5">
				<a href="${pageContext.request.contextPath}/freeBoard/list" class="text-light"
					style="text-decoration: none">
					<h4 class="">
						<i class="fa-solid fa-pencil "></i> Text List
					</h4>
				</a>
			</div>


			<div class="col-1 mb-5  text-center bg-primary rounded-5  text-light">
				<a href="${pageContext.request.contextPath}/freeBoard/add" class="text-light "
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
			<c:forEach items="${FreeBoardList}" var="FreeBoardList"
				varStatus="loopStatus">

				<c:if test="${FreeBoardList.attachNo>0}">



					<div class=" m-0 p-0 text-start d-inline"
						onClick="location.href='${pageContext.request.contextPath}/freeboard/detail?freeBoardNo=${FreeBoardList.freeBoardNo}'"
						style="cursor: pointer;">

						<img alt="" src="${pageContext.request.contextPath}/rest/freeBoard/attach/download?attachNo=${FreeBoardList.attachNo}" width="300px" height="300px"
							class="mt-2">

					</div>

				</c:if>



				<c:if test="${loopStatus.index % 5 == 4 or loopStatus.last}">
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
							href="${pageContext.request.contextPath}/freeboard/photoList?${boardVO.prevQueryString}">
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
									href="${pageContext.request.contextPath}/freeboard/photoList?${boardVO.getQueryString(i)}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<!-- 다음 버튼 -->
				<div class="col-1">
					<c:if test="${!boardVO.last}">
						<a
							href="${pageContext.request.contextPath}/freeboard/photoList?${boardVO.nextQueryString}">
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

<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>