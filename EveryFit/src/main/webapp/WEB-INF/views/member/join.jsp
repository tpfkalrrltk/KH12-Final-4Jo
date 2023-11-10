<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
</style>

<script>
		 function{
		 $("#id").blur(function() {
		 	let idCheck = /^[a-zA-Z0-9]{8,16}$/;
		 	
		 	if ($("#id").val() == "") {
		         $("#idcheck_blank").css("color", "red");
		         $("#idcheck_blank").text("아이디는 필수 입력");
		         id = false;
		 	}else if(!idCheck.test($("#id").val())) {
		         $("#idcheck_blank").css("color", "red");
		         $("#idcheck_blank").text("영문과 숫자 조합하여 8~16자만 가능");
		         id = false;
		    }else {
		    	$("#idcheck_blank").css("color", "blue");
		    	$("#idcheck_blank").text("괜찮은 아이디입니다. 중복확인을 해보세요");
		    	id = true;
		    }
		 	
		 	if(id == true) {
		 		$("#id_Confirm").show();
		 	}else {
		 		$("#id_Confirm").hide();
		 	}
		 });
		 
		 //////아이디 중복 검사////////
		 $("#id_Confirm").click(function() {
		 	if( $("#id").val() == "" ) {
		 		alert("아이디를 입력해주세요.");
		 	}else {
		 		$.ajax({
		 			url: "idcheck.do",
		 			type: "post",
		 			data: {'m_id':$("#id").val()},
		 			success: function(data) {
						//alert(data);
						if(data = "YES") {
							$("#idcheck_blank").css("color", "blue");
					    	$("#idcheck_blank").text("사용가능한 아이디입니다.");
					    	id_check = true;
						}else {
							$("#idcheck_blank").css("color", "red");
					    	$("#idcheck_blank").text("중복된 아이디입니다.");
					    	id_check = false;
					    	$("#id").val("");
						}
					},
					error: function() {
						alert("e");
					}
		 		});
		 	}
		 });
		 };
		</script>

<!-- ---------------------------------------------------------------------------------------- -->


<form class="join-form" action="" method="post" autocomplete="off">

	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h2>join</h2>
							</div>
							<div class="col-md-4 offset-md-4 text-center">
								name<input type="text" name="memberName" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								email<input type="text" name="memberEmail"
									placeholder="everyfit@every.fit" id="id" class="form-control">
								<button type="button" id="id_Confirm" value="중복확인"
									class="btn btn-success">중복검사</button>
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								<!-- 가입하기 버튼 눌렀을 때 비밀번호가 정규표현식에 맞지 않으면 제대로 입력하라고 알림창 띄우기 -->
								pw<input type="password" name="memberPw" class="form-control">
							</div>

							<!-- <div class="col-md-4 offset-md-4 text-center">
								<label> 비밀번호 확인 <i class="fa-solid fa-asterisk red"></i>
								</label> <input type="password" name="memberPw" required
									class="form-control">
							</div> -->

							<div class="col-md-4 offset-md-4 text-center">
								nick<input type="text" name="memberNick" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								gender<select class="form-select">
									<option>man</option>
									<option>woman</option>
								</select>
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								contact<input type="text" name="memberContact"
									class="form-control" placeholder="- 제외하고 입력">
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								birth<input type="date" name="memberBirth" class="form-control">
							</div>

							<div class="mt-4 col-md-4 offset-md-4 text-center"
								style="margin-bottom: 150px;">
								<button type="submit" class="btn btn-info">join</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>