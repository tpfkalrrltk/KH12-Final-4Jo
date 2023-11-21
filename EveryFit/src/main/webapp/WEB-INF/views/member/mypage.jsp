<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="../template/Header.jsp"></jsp:include>



<style>
.box {
	margin: 20px;
	padding: 30px;
	border: 1px solid orange;
	border-radius: 14px;
}

a {
	text-decoration: none;
	color: white;
}
</style>



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

	/* imgae */
	$(function() {
		//파일이 바뀌면 프로필을 업로드하고 이미지 교체
		$(".profile-chooser").change(
				function() {
					//선택된 파일이 있는지 확인하고 없으면 중단
					//var input = document.querySelector(".profile-chooser");
					//var input = $(".profile-chooser")[0];
					var input = this;
					if (input.files.length == 0)
						return;

					//ajax로 multipart 업로드
					var form = new FormData();
					form.append("attach", input.files[0]);

					$.ajax({
						url : window.contextPath + "/rest/member/upload",
						method : "post",
						processData : false,
						contentType : false,
						data : form,
						dataType : "json",
						success : function(response) {
							//응답 형태 - { "attachNo" : 7 }
							console.log(response);

							//프로필 이미지 교체
							$(".profile-image").attr(
									"src",
									"/rest/member/download?attachNo="
											+ response.attachNo);
						},
						error : function() {
							window.alert("통신 오류 발생\n잠시 후 다시 시도해주세요");
						},
					});
				});
		//삭제아이콘을 누르면 프로필이 제거되도록 구현
		$(".profile-delete").click(function() {
			//확인창
			var choice = window.confirm("정말 프로필을 지우시겠습니까?");
			if (choice == false)
				return;

			//삭제요청
			$.ajax({
				url : window.contextPath + "/rest/member/delete",
				method : "post",
				success : function(response) {
					$(".profile-image").attr("src", "/images/user.png");
				},
			});
		});
	});
</script>

<!-- ---------------------------------------------------------------------------------------- -->


<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">



			<div class="container text-center mt-5 box">
				<div class="row">
					<div class="col align-self-start">
						<div>
							<c:choose>
								<c:when test="${profile == null }">

									<img src="/images/profile.png"
										class="image image-circle image-border profile-image"
										style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">
								</c:when>
								<c:otherwise>
									<img src="/rest/attach/download?attachNo=${profile}"
										class="image image-circle image-border profile-image"
										style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">
								</c:otherwise>
							</c:choose>
							<div class="d-flex flex-column mb-3">
								<div class="row">
									<label> <input type="file" class="profile-chooser "
										accept="image/*" style="display: none;"> <i
										class="fa-solid fa-camera blue fa-2x"></i> <i
										class="ms-2 fa-solid fa-trash-can red fa-2x profile-delete"></i>
									</label>
								</div>
							</div>
						</div>
						<div class="mt-2"></div>
					</div>


					<div class="col align-self-center">

						<div>${memberDto.memberNick}</div>
						<div>내 모임 : ${memberDto.memberMoimCount} 개</div>
					</div>
					<div class="col align-self-end">
						<div>
							<button class="btn btn-success">
								<a href="#">프리미엄 회원권</a>
							</button>
						</div>

						<div>
							<button class="btn btn-info mt-2">
								<a href="/member/change">프로필 등록/수정</a>
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


			<div class="container text-center mt-5 box">
				<div class="d-flex">
					<label>소개</label> <label style="margin-left: 10px;">모임</label> <label
						style="margin-left: 10px;">정모</label> <label
						style="margin-left: 10px;">리그</label>


					<div class="text-success">
						<hr>
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


