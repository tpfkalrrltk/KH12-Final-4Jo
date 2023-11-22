<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>

</style>

<form action="" method="post" autocomplete="off">
<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">
			
			<div class="col-md-4 offset-md-4 text-center">
				<h4>비밀번호 변경</h4>
			</div>

			
			<div class="col-md-4 offset-md-4 text-start">
				<input type="hidden" name="originPw" class="form-control" value="${memberDto.memberPw}" >
				
			</div>

			<div class="col-md-4 offset-md-4 text-start mt-3">
				<label>비밀번호</label>
			</div>
			<div class="col-md-4 offset-md-4 text-start">
				<input class="form-control" name="changePw">
			</div>

			<div class="col-md-4 offset-md-4 mt-3 text-start">
				<label>비밀번호 확인</label>
			</div>
			<div class="col-md-4 offset-md-4 text-start">
				<input class="form-control" name="changePwCheck">
			</div>
			
			<div class="col-md-4 offset-md-4 text-start mt-5">
				<button type="submit" class="btn btn-success w-100">변경하기</button>
			</div>
			
		</div>
	</div>
</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>
