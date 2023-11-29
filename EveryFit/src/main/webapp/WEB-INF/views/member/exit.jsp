<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
<jsp:include page="../template/Header.jsp"></jsp:include>



<form action="exit" method="post" autocomplete="off">
	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-md-10 offset-md-1">
				<div class="container text-center mt-5">
					<div class="row">
						<div class="col align-self-start" style="margin-top: 30px;">
							<div class="col-md-4 offset-md-4 mt-5 text-start">
								<div class="col-md-4 offset-md-4 mb-5">
									<h4>회원탈퇴</h4>
								</div>
								<input class="form-control mt-4" type="password" name="memberPw"
									required placeholder="비밀번호" value="">
							</div>
							<br> <br>
							<div class="col-md-4 offset-md-4 mt-5 text-start">
								<button class="btn btn-primary w-100" type="submit">회원 탈퇴</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</form>

<script>

	
</script>

<jsp:include page="../template/Footer.jsp"></jsp:include>
