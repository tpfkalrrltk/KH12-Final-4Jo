<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
a {
	text-decoration: none;
	color: white;
}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10 offset-md-1">

			<div class="col-md-10 offset-md-4">
				<h3>이메일이 전송되었습니다</h3>

			</div>
			<div class="col-md-5 offset-md-4 mt-3">
				<button class=" btn btn-info" style="width: 250px;">
					<a href="${pageContext.request.contextPath}/">홈</a>
				</button>
				<button class="btn btn-info" style="width: 250px; margin-top: 20px;">
					<a href="${pageContext.request.contextPath}/member/login">로그인</a>
				</button>
			</div>
		</div>
	</div>
</div>


<jsp:include page="../template/Footer.jsp"></jsp:include>