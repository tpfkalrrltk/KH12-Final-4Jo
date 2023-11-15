<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
span {
	color: darkorange;
}
</style>

<script>
	/* 인증번호  */
	$(function() {
		//처음 로딩아이콘 숨김
		$(".btn-send").find(".fa-spinner").hide();
		$(".cert-wrapper").hide();

		// 인증번호 보내기 버튼을 누르면 
		// 서버로 비동기 통신을 보내 인증 메일 발송 요청
		$(".btn-send").click(function() {
			var email = $("[name=memberEmail]").val();
			if (email.length == 0)
				return;

			$(".btn-send").prop("disabled", true);
			$(".btn-send").find(".fa-spinner").show();
			$(".btn-send").find("span").text("이메일 발송중");
			$.ajax({
				url : "http://localhost:8080/rest/cert/send",
				method : "post",
				data : {
					certEmail : email
				},
				success : function() {
					$(".btn-send").prop("disabled", false);
					$(".btn-send").find(".fa-spinner").hide();
					$(".btn-send").find("span").text("인증번호 보내기");
					//window.alert("이메일 확인하세요");

					$(".cert-wrapper").show();
					window.email = email;
				},
			});
		});
		// 확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사 
		$(".btn-cert").click(
				function() {
					var email = $("[name=memberEmail]").val();
					//  var email = window.email;
					var number = $(".cert-input").val();
					/* console.log("number", number); */

					if (email.length == 0 || number.length == 0)
						return;

					$.ajax({
						url : "http://localhost:8080/rest/cert/check",
						method : "post",
						data : {
							certEmail : email,
							certNumber : number
						},
						async : true, // 비동기화 동작 여부
						dataType : "html", // 전달받을 데이터 타입

						success : function(response) {
							console.log(response);


							if (response) {//인증성공 
								$(".cert-input").removeClass("success fail")
										.addClass("success");
								$(".btn-cert").prop("disabled", true);
								//성공 
								$(".cert-result").text("인증되었습니다.").css("color",
										"green");
							} else {
								$(".cert-input").removeClass("success fail")
										.addClass("fail");
								//실패 
								$(".cert-result").text("인증에 실패했습니다.").css(
										"color", "red");
							}

						},
					});
				});
	});
</script>

<!-- ---------------------------------------------------------------------------------------- -->


<form class="join-form" action="" method="post" autocomplete="off"
	novalidate>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h2>회원가입</h2>
							</div>


							<!-- 이메일 입력 부분 -->
							<div class="col-md-4 offset-md-4 text-start">
								<div class="d-flex mt-2">
									<div class="text-start">
										<label>Email</label> <input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
									</div>
									<div class="ms-3 mt-4">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-success btn-send">
											인증<i class="fa-solid fa-spinner fa-spin"></i>
										</button>

									</div>
								</div>
							</div>

							<!-- 인증번호 입력 부분 -->
							<div class="col-md-4 offset-md-4 text-start d-flex">
								<div class="d-flex ">
									<div class="text-start">

										<label>인증번호</label> <input type="text"
											class="form-control cert-input">

									</div>
									<div class="ms-3 mt-4">
										<button class="btn btn-success btn-cert" type="button">확인</button>
										<div class="cert-result"></div>
									</div>
								</div>
							</div>
							<!-- 시간 표시 부분 -->
							<div id="timerDisplay" style="display: none; color: darkorange;"
								class="col-md-4 offset-md-4 text-start">
								남은 시간: <span id="timer"></span>
								<div>

									<span class="cert-result">실패</span>
								</div>
							</div>

							<!-- 타이머 시간 끝났을때 재전송  -->

							<!-- <div class="col-md-4 offset-md-4 text-start">
								<div class="d-flex mt-2">
									<div class="text-start">
										<label>Email</label> <input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
									</div>
									<div class="ms-3">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-success btn-send">인증</button>
									</div>
								</div>
							</div>

							<div class="col-md-4 offset-md-4 text-start d-flex">
								<div class="d-flex ">
									<div class="text-start">
										<label>인증번호</label> <input class="form-control">
									</div>
								</div>
								<div>
									<button class="btn btn-success">확인</button>
								</div>
							</div> -->

							<div class="col-md-4 offset-md-4 text-start">
								<!-- 가입하기 버튼 눌렀을 때 비밀번호가 정규표현식에 맞지 않으면 제대로 입력하라고 알림창 띄우기 -->
								<label>비밀번호</label> <input type="password" name="memberPw"
									class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								<label> 비밀번호 확인 </label> <input type="password" required
									class="form-control" name="memberPwConfirm"
									id="passwordConfirm">
							</div>



							<div class="col-md-4 offset-md-4 text-start">
								닉네임<input type="text" name="memberNick" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								성별<select class="form-select">
									<option>man</option>
									<option>woman</option>
								</select>
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								전화번호<input type="text" name="memberContact" class="form-control"
									placeholder="- 제외하고 입력">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								생년월일<input type="date" name="memberBirth" class="form-control">
							</div>

							<div class="mt-4 col-md-4 offset-md-4 text-center"
								style="margin-bottom: 150px;">
								<button type="submit" class="btn btn-info">회원가입</button>
							</div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>