<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../template/Header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>
a {
	text-decoration: none;
	color: black;
}

/* 성공/실패에 대한 스타일 구현 */
.success-feedback {
	color: #00b894;
	display: none;
}

.fail-feedback, .fail2-feedback {
	color: #d63031;
	display: none;
}

.success ~ .success-feedback {
	display: block;
}

.fail ~ .fail-feedback {
	display: block;
}

.fail2 ~ .fail2-feedback {
	display: block;
}

.success {
	/* important는 우선순위를 최상위로 올린다 */
	border-color: #00b894 !important;
	background-image: url("./image/valid.png");
	background-repeat: no-repeat;
	background-position-x: right;
	background-position-y: center;
	background-size: 1em;
}

.fail, .fail2 {
	border-color: #d63031 !important;
	background-image: url("./image/invalid.png");
	background-repeat: no-repeat;
	background-position-x: right;
	background-position-y: center;
	background-size: 1em;
}

.alert-danger {
	display: none;
}
</style>




<!-- 황민하 지금 보안관련 기능 추가중 -->
<div class="duplicate-login-alert">
	<c:if test="${DUPLICATE_LOGIN eq 'true'}">
		<script>
			alert("다른 기기에서 로그인되어 현재 로그인이 종료되었습니다.")
		</script>
	</c:if>
</div>




<form action="login" method="post" autocomplete="off">

	<div class="alert alert-danger" role="alert">A simple primary
		alert—check it out!</div>

	<div class="container-fluid mt-2">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">



							<div class="col-md-4 offset-md-4 mt-5">
								<input type="text" name="memberEmail" class="form-control"
									placeholder="email" value="${cookie.saveId.value}">

							</div>

							<div class="col-md-4 offset-md-4 mt-2">
								<input type="password" name="memberPw" class="form-control"
									placeholder="pw" id="passwordInput">
							</div>




							<!-- 자동로그인  -->
							<div class="col-md-4 offset-md-4 mt-2 text-start">
								<div class="form-check">
									<c:choose>
										<c:when test="${cookie.saveId != null }">
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin" checked>
											<label class="form-check-label" for="flexCheckDefault">
												아이디 저장 </label>
										</c:when>
										<c:otherwise>
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin">
											<label class="form-check-label" for="flexCheckDefault">
												아이디 저장 </label>
										</c:otherwise>
									</c:choose>
								</div>
								<input class="form-check-input" type="checkbox"
									id="showPassword"> 비밀번호 표시
							</div>
						</div>





						<button type="button" class="btn btn-link mt-3"
							data-bs-target="#findPw">

							<a href="${pageContext.request.contextPath}/member/findPw"
								class="text-primary" style="text-decoration: none;">비밀번호를
								잊으셨나요?</a>
						</button>

						<button type="button" class="btn btn-link">
							<a href="${pageContext.request.contextPath}/member/join"
								class="text-primary">회원가입</a>

						</button>


						<!-- 여기까지  -->


						<div class="col-md-4 offset-md-4 mt-3 ">
							<button type="submit" class="btn btn-primary"
								style="width: 350px;">login</button>
						</div>

						
					</div>
				</div>
			</div>
		</div>
</form>


<script>
	/* 임시비밀번호  */
	/* 	$("#checkEmail").click(function() {
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
	 }); */

	/* 피드백  */
	/*  $(function(){
	    //$("[name=memberId]").on("blur", function(){});
	    $("[name=memberEmail]").blur(function(){
	        var regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	    });
	    $("[name=memberPw]").blur(function(){
	        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
	        var isValid = regex.test($(this).val());
	        $(this).removeClass("success fail");
	        $(this).addClass(isValid ? "success" : "fail");
	    });
	    $("#password-check").blur(function(){
	        var originPw = $("[name=memberPw]").val();
	        var checkPw = $(this).val();

	        $(this).removeClass("success fail fail2");
	        if(originPw.length == 0) {//비밀번호 미입력
	            $(this).addClass("fail2");
	        }
	        else if(originPw == checkPw) {//비밀번호 일치
	            $(this).addClass("success");
	        }
	        else {//비밀번호 불일치
	            $(this).addClass("fail");
	        }
	    });
	}); */

	/* 비밀번호 보기  */
	$(document).ready(function() {
		console.log("Script is running!");

		$("#showPassword").change(function() {
			console.log("Checkbox changed!"); // 추가
			var passwordInput = $("#passwordInput");
			if (this.checked) {
				console.log("Checkbox is checked!"); // 추가
				passwordInput.attr("type", "text");
			} else {
				console.log("Checkbox is unchecked!"); // 추가
				passwordInput.attr("type", "password");
			}
		});
	});

</script>


<jsp:include page="../template/Footer.jsp"></jsp:include>