<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
a {
	text-decoration: none;
	color: black;
}
</style>


<script>
	/* 임시비밀번호  */
	$("#checkEmail").click(function() {
		const userEmail = $("#userEmail").val();
		const sendEmail = document.forms["sendEmail"];
		$.ajax({
			type : 'post',
			url : 'emailDuplication',
			data : {
				'memberEmail' : userEmail
			},
			dataType : "text",
			success : function(result) {
				if (result == "no") {
					// 중복되는 것이 있다면 no == 일치하는 이메일이 있다!
					alert('임시비밀번호를 전송 했습니다.');
					sendEmail.submit();
				} else {
					alert('가입되지 않은 이메일입니다.');
				}

			},
			error : function() {
				console.log('에러 체크!!')
			}
		})
	});
</script>

<!-- 황민하 지금 보안관련 기능 추가중 -->
<div class="duplicate-login-alert">
	<c:if test="${DUPLICATE_LOGIN eq 'true'}">													
		<script> alert("다른 기기에서 로그인되어 현재 로그인이 종료되었습니다.") </script>											
	</c:if>
</div>




<form action="login" method="post" autocomplete="off">



	<div class="container-fluid mt-2">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h3>login</h3>
							</div>

							<div class="col-md-4 offset-md-4">
								<input type="text" name="memberEmail" class="form-control"
									placeholder="email" value="${cookie.saveId.value}">
									
							</div>

							<div class="col-md-4 offset-md-4 mt-2">
								<input type="password" name="memberPw" class="form-control"
									placeholder="pw">
							</div>




							<!-- 자동로그인  -->
							<div class="col-md-4 offset-md-4 mt-2 text-start">
								<div class="form-check">
									<c:choose>
										<c:when test="${cookie.saveId != null }">
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin" checked>
											<label class="form-check-label" for="flexCheckDefault">
												로그인 상태 유지 </label>
										</c:when>
										<c:otherwise>
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin">
											<label class="form-check-label" for="flexCheckDefault">
												아이디 저장 </label>
										</c:otherwise>
									</c:choose>
								</div>
							</div>

						
							<!-- <div class="col-md-4 offset-md-4 mt-2">
								<span><a href="#">아이디 찾기</a> </span> | <span><a
									href="/member/findPw">비밀번호 찾기</a></span> | <span>-->
							<!-- <a href="/member/join">회원가입</a></span> -->
						</div>


						<!-- 여기서부터 회원정보 찾기 -->

						<!--임시 비번 모달-->
						<!-- <div id="findPw" class="modal fade">
								<div class="modal-dialog modal-dialog-centered modal-login">
									<div class="modal-content">
										<div class="modal-body">

											<div class="container my-auto">
												<div class="row">
													<div class="card z-index-0 fadeIn3 fadeInBottom">
														<div
															class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
															<div
																class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
																<h4
																	class="text-white font-weight-bolder text-center mt-2 mb-0">비밀번호
																	찾기</h4>
															</div>
														</div>
														<div class="card-body">
															<form role="form" class="text-start"
																action="/member/sendEmail" method="post"
																name="sendEmail">
																<p>입력한 이메일로 임시 비밀번호가 전송됩니다.</p>
																<div class="input-group input-group-outline my-3">
																	<label class="form-label">Email</label> <input
																		type="email" id="userEmail" name="memberEmail"
																		class="form-control" required>
																</div>
																<div class="text-center">
																	<button type="button"
																		class="btn bg-gradient-primary w-100 my-4 mb-2"
																		id="checkEmail">비밀번호 발송</button>
																</div>
															</form>
														</div>
													</div>
												</div>
											</div>

										</div>
									</div>
								</div>
							</div> -->
<!-- 						<button type="button" class="btn btn-link mt-3" data-bs-toggle="modal"
							data-bs-target="#findPw"><a href="/#" class="text-info">아이디를 잊으셨나요?</a></button> -->

						<button type="button" class="btn btn-link mt-3" data-bs-target="#findPw">
							<a href="${pageContext.request.contextPath}/member/findPw" class="text-info">비밀번호를 잊으셨나요?</a>
						</button>

						<button type="button" class="btn btn-link">
							<a href="${pageContext.request.contextPath}/member/join" class="text-info">회원가입</a>
						</button>


						<!-- 여기까지  -->


						<div class="col-md-4 offset-md-4 mt-3 ">
							<button type="submit" class="btn btn-success"
								style="width: 350px;">login</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	</div>


</form>


<jsp:include page="../template/Footer.jsp"></jsp:include>