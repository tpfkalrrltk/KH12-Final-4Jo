<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>



<style>
a {
	text-decoration: none;
	color: white;
}
</style>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>



<form action="change" method="post" autocomplete="off">
	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5">
					<div class="row">
						<div class="col align-self-start" style="margin-top: 30px;">

							<div class="row">
								<div class="col">
									<h1>개인정보 변경</h1>
								</div>
							</div>


							<div class="col-md-4 offset-md-4 mt-5 text-start">
								<label>이메일</label> <input type="email" name="memberEmail"
									class="form-control" value="${memberDto.memberEmail}" disabled>
							</div>
							<div class="mt-3">
								<label>비밀번호</label>
								<div class="col-md-4 offset-md-4 text-start d-flex flex-row">


									<div>
										<input type="password" class="form-control " name="memberPw"
											value="${memberDto.memberPw}" disabled>

									</div>
									<button type="button" class="btn btn-primary ms-2 ">
										<a href="${pageContext.request.contextPath}/member/changePw">비밀번호 변경</a>
									</button>

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-4 offset-md-4 text-start">
					<label> 닉네임 </label> <input type="text" name="memberNick"
						class="form-control" value="${memberDto.memberNick}" required>
				</div>


				<div class="col-md-4 offset-md-4 text-start">
					<label>연락처</label> <input type="tel" name="memberContact"
						class="form-control" value="${memberDto.memberContact}">
				</div>
				<div class="col-md-4 offset-md-4 text-start">
					<label>생년월일</label> <input type="date" name="memberBirth"
						class="form-control" value="${memberDto.memberBirth}" disabled>
				</div>


				<div class="col-md-4 offset-md-4 text-center mt-4">
					<!-- <button class="btn btn-danger"> -->
						<a href="${pageContext.request.contextPath}/member/exit" class="btn btn-danger">회원탈퇴</a>
					<!-- </button> -->

					<button type="submit" class="btn btn-primary"
						style="margin-left: 10px;">정보변경</button>

				</div>




			</div>





		</div>
	</div>

</form>

<script>

	</script>
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>