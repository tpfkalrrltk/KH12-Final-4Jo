<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
.box {
	margin: 20px;
	padding: 30px;
	border: 1px solid orange;
	border-radius: 14px;
}
</style>

<form action="changePw" method="post" autocomplete="off">
<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">
			
			<div class="col-md-4 offset-md-4 text-center">
				<h4>비밀번호 변경</h4>
			</div>

			<div class="col-md-4 offset-md-4 text-start mt-5">
				<label>비밀번호</label>
			</div>
			<div class="col-md-4 offset-md-4 text-start">
				<input type="password" class="form-control" name="memberPw">
			</div>

			<div class="col-md-4 offset-md-4 mt-3 text-start">
				<label>비밀번호 확인</label>
			</div>
			<div class="col-md-4 offset-md-4 text-start">
				<input type="password" class="form-control" name="changePwCheck">
			</div>
			
			<div class="col-md-4 offset-md-4 text-start mt-5">
				<button type="submit" class="btn btn-primary w-100">변경하기</button>
			</div>
			
		</div>
	</div>
</div>
</form>
<jsp:include page="../template/Footer.jsp"></jsp:include>
