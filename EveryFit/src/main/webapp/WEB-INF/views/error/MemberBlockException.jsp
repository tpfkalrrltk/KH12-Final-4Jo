<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../template/Header.jsp"%>



<div class="container  bg-primary">
	
	<div class="row mt-5 p-5">
		<div class="col-6 offset-2 p-5 m-4 bg-primary rounded-3  text-light">
			<h1 class="display-5 fw-bold">차단 당한 회원입니다.</h1>
		</div>
		<h6 class="bg-info col-3 p-5 m-4  text-light text-center rounded-3">관리자에게 문의 해주세요
						<a href="${pageContext.request.contextPath}/appeal/add" style="text-decoration: none"
				class="fw-bold text-center text-light  bg-primary mt-4"><h3 class="mt-4 text-center">메세지 보내기</h3></a></h6>
	</div>

<img src="/images/error.jpg" style="max-width: 1200px; max-height: 1200px " class="text-center m-5">

	</div>





<%@ include file="../template/Footer.jsp"%>