<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
</style>

<script>
	$(function() {
		//검색버튼, 우편번호 입력창, 기본주소 입력창을 클릭하면 검색 실행
		$(".post-search").click(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					//document.querySelector("[name=memberPost]").value = data.zonecode;
					$("[name=memberPost]").val(data.zonecode);
					//document.querySelector("[name=memberAddr1]").value = addr;
					$("[name=memberAddr1]").val(addr);
					// 커서를 상세주소 필드로 이동한다.
					//document.querySelector("[name=memberAddr2]").focus();
					$("[name=memberAddr2]").focus();
				}
			}).open();
		});
	});
	$("#password-check").blur(function() {
		var originPw = $("[name=memberPw]").val();
		var checkPw = $(this).val();
		$(this).removeClass("success fail fail2");
		if (originPw.length == 0) {//미입력이면
			$(this).addClass("fail2");
			status.pwCheck = false;
		} else if (originPw == checkPw) {//일치하면
			$(this).addClass("success");
			status.pwCheck = true;
		} else {//비밀번호 불일치
			$(this).addClass("fail");
			status.pwCheck = false;
		}
	});
</script>

<!-- ---------------------------------------------------------------------------------------- -->


<form class="join-form was-validated" action="" method="post"
	autocomplete="off" novalidate>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h2>join</h2>
							</div>


							<div class="col-md-4 offset-md-4 text-start">
								<span>email<i class="fa-solid fa-asterisk red"></i></span>
								<div class="d-flex mt-2">
									<div>



										<input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
										<div class="success-feedback">합격</div>
										<div class="fail-feedback">불합격</div>
										<div class="fail2-feedback">이미사용중인아이디</div>
									</div>
									<div class="ms-3">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-success">인증</button>
									</div>
								</div>
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								<!-- 가입하기 버튼 눌렀을 때 비밀번호가 정규표현식에 맞지 않으면 제대로 입력하라고 알림창 띄우기 -->
								<span>비밀번호<i class="fa-solid fa-asterisk red"></i></span> <input
									type="password" name="memberPw" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								<label> 비밀번호 확인 <i class="fa-solid fa-asterisk red"></i>
								</label> <input type="password" required class="form-control"
									name="memberPwConfirm" id="passwordConfirm">
							</div>



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