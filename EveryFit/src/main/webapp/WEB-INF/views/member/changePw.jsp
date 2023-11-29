<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>

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
					<label>현재 비밀번호</label>

				</div>
				<div class="col-md-4 offset-md-4 text-start">
					<input type="password" class="form-control" name="memberPw">
				</div>

				<div class="col-md-4 offset-md-4 text-start mt-3">
					<label>변경하실 비밀번호</label>

				</div>
				<div class="col-md-4 offset-md-4 text-start">
					<input type="password" class="form-control" name="changePw"
						id="passwordInput"> 
						<!-- <input class="form-check-input"
						type="checkbox" id="showPassword1"> 비밀번호 표시 -->
				</div>

				<div class="col-md-4 offset-md-4 text-start mt-3">
					<label>비밀번호 확인</label>

				</div>
				<div class="col-md-4 offset-md-4 text-start">
					<input type="password" class="form-control" id="passwordInputCheck">
					<!-- <input class="form-check-input" type="checkbox" id="showPassword2">
					비밀번호 표시 -->
				</div>

				<div class="col-md-4 offset-md-4 text-start mt-5">
					<button type="submit" class="btn btn-primary w-100">변경하기</button>
				</div>

			</div>
		</div>
	</div>
</form>

<script>
	/* 비밀번호 보기  */
	 /* $(document).ready(function() {
		console.log("Script is running!");

		$("#showPassword1").change(function() {
			console.log("Checkbox 1 changed!"); // 추가
			var passwordInput = $("#passwordInput");
			if (this.checked) {
				console.log("Checkbox 1 is checked!"); // 추가
				passwordInput.attr("type", "text");
			} else {
				console.log("Checkbox 1 is unchecked!"); // 추가
				passwordInput.attr("type", "password");
			}
		});

		$("#showPassword2").change(function() {
			console.log("Checkbox 2 changed!"); // 추가
			var passwordInputCheck = $("#passwordInputCheck");
			if (this.checked) {
				console.log("Checkbox 2 is checked!"); // 추가
				passwordInputCheck.attr("type", "text");
			} else {
				console.log("Checkbox 2 is unchecked!"); // 추가
				passwordInputCheck.attr("type", "password");
			}
		});
	});  */
</script>
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>
