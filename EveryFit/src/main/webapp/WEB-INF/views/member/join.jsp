<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
span {
	color: darkorange;
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
</style>



<!-- ---------------------------------------------------------------------------------------- -->


<form class="join" action="" method="post" autocomplete="off"
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
							<div class="col-md-4 offset-md-4 mt-5 text-start">
								<div class="d-flex mt-2">
									<div class="text-start">
										<label>Email</label> <input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
									</div>
									<div class="ms-3 mt-4">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-primary btn-send">
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
										<button class="btn btn-primary btn-cert" type="button">확인</button>
									</div>
								</div>
							</div>
							<div class="col-md-4 offset-md-4 text-start">
								<label class="cert-result"></label>
							</div>
							<div class="col-md-4 offset-md-4 text-start">
								<!-- 가입하기 버튼 눌렀을 때 비밀번호가 정규표현식에 맞지 않으면 제대로 입력하라고 알림창 띄우기 -->
								<label>비밀번호</label> <input type="password" name="memberPw"
									class="form-control" placeholder="Everyfit1!">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								<label> 비밀번호 확인 </label> <input type="password" required
									class="form-control" 
									id="password-check">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								이름<input type="text" name="memberName" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								닉네임<input type="text" name="memberNick" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								성별<select class="form-select country" name="memberGender">
									<option>성별</option>
									<option >M</option>
									<option >F</option>
								</select>
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								관심종목<select class="form-select">
									<option>종목선택</option>
									<option>육상</option>
									<option>축구</option>
									<option>테니스</option>
									<option>야구</option>
									<option>농구</option>
								</select>
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								전화번호<input type="text" name="memberContact" class="form-control"
									placeholder="- 제외하고 입력">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								생년월일<input type="date" name="memberBirth" class="form-control">
							</div>

						<div class="col-md-4 offset-md-4 text-start mt-3">
						    <input class="form-check-input text-center" type="checkbox" value="" id="flexCheckDefault">
						    <label class="form-check-label" for="flexCheckDefault">
						        전체동의
						    </label>
						</div>


							<div class="mt-4 col-md-4 offset-md-4 text-center"
								style="margin-bottom: 150px;">
								<button type="submit" class="btn btn-primary" style="width: 350px;">회원가입</button>
							</div>
						</div>

						


					</div>
				</div>


			</div>
		</div>
	</div>
</form>

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
					$(".btn-send").find("span").text("보내기");
					window.alert("이메일 확인하세요");

					$(".cert-wrapper").show();
					window.email = email;
				},
			});
		});
		// 확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사 
		$(".btn-cert").click(
				function() {
					//    var email = $("[name=memberEmail]").val();
					var email = window.email;
					var number = $(".cert-input").val();

					if (email.length == 0 || number.length == 0)
						return;

					$.ajax({
						url : "http://localhost:8080/rest/cert/check",
						method : "post",
						data : {
							certEmail : email,
							certNumber : number
						},
						success : function(response) {
							// console.log(response);
							if (response == 'Y') {//인증성공 
								$(".cert-input").removeClass("success fail")
										.addClass("success");
								$(".btn-cert").prop("disabled", true);
								//상태객체에 상태 저장하는 코드
								$(".cert-result").text("인증되었습니다.").css("color",
										"green");
							} else {
								$(".cert-input").removeClass("success fail")
										.addClass("fail");
								//상태객체에 상태 저장하는 코드
								$(".cert-result").text("인증에 실패했습니다.").css(
										"color", "red");
							}
						},
					});
				});
	});
	
	
	/* 옵션값가져오기  */
	$(document).ready(function(){
		  $("#country").change(function(){
		    // Value값 가져오기
		    var val = $("#country :selected").val();
		    // Text값 가져오기
		    var text = $("#country :selected").text();
		    // Index가져오기
		    var index = $("#country :selected").index();
		    
		    $("#value").val(val);
		    $("#text").val(text);
		  });
		});
	
	
	 /* 피드백  */
	 $(function(){
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
    });
	 $("[name=memberName]").blur(function(){
         var regex = /^[가-힣]{2,17}$/;
         var isValid = regex.test($(this).val());
         $(this).removeClass("success fail");
         $(this).addClass(isValid ? "success" : "fail");
     });
	 $("[name=memberNick]").blur(function(){
         var regex = /^[A-Za-z0-9가-힣]{2,10}$/;
         var isValid = regex.test($(this).val());
         $(this).removeClass("success fail");
         $(this).addClass(isValid ? "success" : "fail");
     });
     $("[name=memberBirth]").blur(function(){
         var regex = /(19[0-9]{2}|20[0-9]{2})-(((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((02)-(0[1-9]|1[0-9]|2[0-9])))$/;
         var isValid = regex.test($(this).val());
         $(this).removeClass("success fail");
         $(this).addClass(isValid ? "success" : "fail");
     });
     $("[name=memberContact]").blur(function(){
         var regex = /^01[016789][1-9][0-9]{2,3}[0-9]{4}$/;
         var isValid = regex.test($(this).val());
         $(this).removeClass("success fail");
         $(this).addClass(isValid ? "success" : "fail");
     });
</script>

<jsp:include page="../template/Footer.jsp"></jsp:include>