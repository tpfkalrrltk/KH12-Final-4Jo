<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>



<form id="updatePassword" action="" method="post" autocomplete="off">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4 offset-md-4">
			
			<div class="col-md-4 offset-md-4 text-center">
				<h5>비밀번호 찾기</h5>
			</div>
			
				<div class="mt-4">
					<label>이메일</label> <input type="text" name="memberEmail"
						class="form-control" required>
				</div>
			</div>
			<div class="col-md-4 offset-md-4 mt-3">
				<div class="d-flex flex-row">
					<div class="col-md-4 offset-md-4">
						<button type="submit" class="btn btn-primary btn-resetPw ms-2 w-100">인증번호 보내기
							</button>


					</div>
				</div>
			</div>

			<div class="col-md-4 offset-md-4">
				<label>인증번호</label> <input type="text"
					class="form-control cert-input">
				<div class="ms-3  ">
					<label class="cert-result"></label>
					<div class="col-md-4 offset-md-4 ">
						<button class="btn btn-primary btn-cert w-100" type="button" style="width:100px">확인</button>
					</div>
				</div>
			</div>
		
	
	<div class="col-md-4 offset-md-4 mt-5">
          <label>이메일</label>
        </div>
        <div class="col-md-4 offset-md-4 text-start">
          <input type="text" class="form-control w-100"  />
        </div>
	
	<div class="col-md-4 offset-md-4 mt-3">
          <label>변경할 비밀번호</label>
        </div>
        <div class="col-md-4 offset-md-4 text-start">
          <input type="password" class="form-control w-100" name="findPw"/>
        </div>

        <div class="col-md-4 offset-md-4 mt-3 ">
          <label>변경할 비밀번호 확인</label>
        </div>
        <div class="col-md-4 offset-md-4 text-start">
          <input type="password" class="form-control w-100" />
        </div>

        <div class="col-md-4 offset-md-4 text-start mt-5">
    <button type="submit" class="btn btn-primary w-100" >변경하기</button>
</div>
</div>
</div>
</form>

<script>
	/* 인증번호  */
	$(function() {
		//처음 로딩아이콘 숨김
		$(".btn-resetPw").find(".fa-spinner").hide();
		$(".cert-wrapper").hide();

		// 인증번호 보내기 버튼을 누르면 
		// 서버로 비동기 통신을 보내 인증 메일 발송 요청
		$(".btn-resetPw").click(function() {
			var email = $("[name=memberEmail]").val();
			if (email.length == 0)
				return;

			$(".btn-resetPw").prop("disabled", true);
			$(".btn-resetPw").find(".fa-spinner").show();
			$(".btn-resetPw").find("span").text("이메일 발송중");
			$.ajax({
				url : window.contextPath + "/rest/cert/resetPw",
				method : "post",
				data : {
					certEmail : email
				},
				success : function() {
					$(".btn-resetPw").prop("disabled", false);
					$(".btn-resetPw").find(".fa-spinner").hide();
					$(".btn-resetPw").find("span").text("보내기");
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
						url : window.contextPath + "/rest/cert/resetPwCheck",
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
								
								 // 인증 성공 시 비밀번호 변경 페이지로 이동
				                window.location.href = window.contextPath + "/member/memberChangePw"; // 실제 경로로 변경
				                
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
	
	
	
	
</script>
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>