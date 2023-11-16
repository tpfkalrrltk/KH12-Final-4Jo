<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>

<style>
a {
	text-decoration: none;
	color: black;
}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10 offset-md-1">

			<div class="container text-center">
				<div class="row">
					<div class="col align-self-start">
						<h4>환영합니다</h4>
						<button class="btn btn-info mt-5">
							<a href="/member/login">로그인</a>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../template/Footer.jsp"></jsp:include>