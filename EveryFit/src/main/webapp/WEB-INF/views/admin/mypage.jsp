<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/adminHeader.jsp"></jsp:include>









<script>
	$(function() {
		$(".open-modal-btn").click(
				function() {
					//$("#exampleModal").modal("show");//표시
					//$("#exampleModal").modal("hide");//숨김

					var modal = new bootstrap.Modal(document
							.querySelector("#exampleModal"));
					modal.show();
				});
	});

	/* 비밀번호 변경  */
	$(document).ready(function() {
		$("#changePasswordButton").click(function() {
			var newPassword = prompt("새로운 비밀번호를 입력하세요:");
			if (newPassword !== null && newPassword !== "") {
				changePassword(newPassword);
			}
		});

		function changePassword(newPassword) {
			// 서버로 비밀번호 변경 요청을 보내는 AJAX 호출
			$.ajax({
				url : "/changePassword", // 비밀번호 변경을 처리하는 서버 엔드포인트 URL
				type : "POST", // HTTP POST 요청
				data : {
					newPassword : newPassword
				}, // 변경할 비밀번호
				success : function(response) {
					alert("비밀번호가 성공적으로 변경되었습니다.");
				},
				error : function(xhr, status, error) {
					console.error("비밀번호 변경 실패: " + error);
				}
			});
		}
	});
</script>

<style>
.box {
	margin: 20px;
	padding: 30px;
	border: 1px solid black;
	border-radius: 14px;
}

a {
	text-decoration: none;
	color: white;
}
</style>


<!-- ---------------------------------------------------------------------------------------- -->


<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">


			<div class="col-7 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">${adminMemberTarget.memberEmail}
					정보</h1>

			</div>

			<div class="container text-center mt-5 box bg-primary">
				<div class="row ">
					<div class="col align-self-start">
						<div class="mt-5">
							<img src="/images/profile.jpg"
								style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden;">
						</div>
						<div class="mt-2">
							<i class="fa-brands fa-mailchimp" style="color: #3f82ec;"></i>

						</div>
					</div>


					<div class="col align-self-center text-start text-light fw-bold">
						<div>E-mail : ${adminMemberTarget.memberEmail}</div>
						<div>Password : ${adminMemberTarget.memberPw}</div>
						<div>Name : ${adminMemberTarget.memberName}</div>
						<div>Nickname : ${adminMemberTarget.memberNick}</div>
						<div>Gender : ${adminMemberTarget.memberGender}</div>
						<div>Phone number : ${adminMemberTarget.memberContact}</div>
						<div>Birth : ${adminMemberTarget.memberBirth}</div>
						<div>Level : ${adminMemberTarget.memberLevel}</div>




					</div>
					<div class="col align-self-end">
						<div>
							<button class="btn btn-success w-100">
								<a href="#">프리미엄 회원권</a>
							</button>
						</div>

						<div>
							<button class="btn btn-info mt-2 w-100">
								<a href="/member/change">회원 정보 수정</a>
							</button>
						</div>

						<div>
							<!-- 	
						 Button trigger modal
							<button type="button" class="btn btn-info mt-2"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								프로필 등록/수정</button>
 -->
							<!-- Modal -->
							<%-- <div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h1 class="modal-title fs-5" id="exampleModalLabel">회원정보
												등록/수정</h1>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div>
												email<input value="${memberDto.memberEmail}" disabled>
											</div>

											<div>
												pw<input type="password" value="${memberDto.memberPw}" disabled>
												<button class="btn btn-warning" id="changePasswordButton">변경</button>
											</div>

											<div>
												name<input value="${memberDto.memberName}" disabled>
											</div>

											<div>
												nick<input value="${memberDto.memberNick}" disabled>
											</div>

											<div>
												gender<input  value="${memberDto.membergender}">
											</div>

											<div>
												contact<input value="${memberDto.memberContact}" disabled>
											</div>

											<div>
												birth<input type="date" value="${memberDto.memberBirth}" disabled>
											</div>



										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>  --%>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
</div>





<%-- <table>
		<tr>
		
			<th>email</th>
			<td>${memberDto.memberEmail}</td>
			
			<th>pw</th>
			<td>${memberDto.memberPw}</td>
			
			<th>name</th>
			<td>${memberDto.membername}</td>
			
			<th>nick</th>
			<td>${memberDto.memberNick}</td>
			
			<th>gender</th>
			<td>${memberDto.membeGgender}</td>
			
			<th>contact</th>
			<td>${memberDto.memberContact}</td>
			
			<th>birth</th>
			<td>${memberDto.memberBirth}</td>
		
		</tr>
	</table> --%>




<jsp:include page="../template/Footer.jsp"></jsp:include>


