<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>









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
						
			
							<c:choose>
								<c:when test="${profile == null }">
									<div class="p-2">
										<img src="${pageContext.request.contextPath}/images/profile.png"
											class="image image-circle image-border profile-image"
											style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">
									</div>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${profile}"
										class="image image-circle image-border profile-image"
										style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">

								</c:otherwise>
						</c:choose>
						
						
						<div class="mt-2">
							<i class="fa-brands fa-mailchimp" style="color: #3f82ec;"></i>

						</div>
					</div>


					<div class="col align-self-center text-start text-light fw-bold">

						<div class="row">
							<div class="text-warning col-3">E-mail :</div>
							<div class=" col-8">${adminMemberTarget.memberEmail}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Password :</div>
							<div class=" col-8">${adminMemberTarget.memberPw}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Name :</div>
							<div class=" col-8">${adminMemberTarget.memberName}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Nickname :</div>
							<div class=" col-8">${adminMemberTarget.memberNick}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Gender :</div>
							<div class=" col-8">${adminMemberTarget.memberGender}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3 pe-0">Phone Number :</div>
							<div class=" col-8">${adminMemberTarget.memberContact}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Birth :</div>
							<div class=" col-8">${adminMemberTarget.memberBirth}</div>
						</div>

						<div class="row">
							<div class="text-warning col-3">Level :</div>
							<div class=" col-8">${adminMemberTarget.memberLevel}</div>
						</div>
						
							<div class="row">
							<div class="text-warning col-3">차단여부 :</div>
							<div class=" col-8">${adminMemberTarget.memberBlock}</div>
						</div>

						<c:choose>
							<c:when test="${adminMemberTarget.memberBlock =='N'}">
					</div>
					<div class="col align-self-end">
						<div>
							<button class="btn btn-danger w-100 fw-bold">
								<a
									href="${pageContext.request.contextPath}/admin/member/block?memberEmail=${adminMemberTarget.memberEmail}">회원
									차단</a>
							</button>
						</div>
						</c:when>
						<c:otherwise>
					</div>
					<div class="col align-self-end">
						<div>
							<button class="btn btn-warning w-100 fw-bold">
								<a
									href="${pageContext.request.contextPath}/admin/member/cancel?memberEmail=${adminMemberTarget.memberEmail}">차단
									해제</a>
							</button>
						</div>
						</c:otherwise>
						</c:choose>





					</div>
					<div class="col align-self-end">
						<div>
							<button class="btn btn-success w-100 fw-bold">
								<a href="${pageContext.request.contextPath}/pay?productNo=1">프리미엄 회원권</a>
							</button>
						</div>

						<div>
							<button class="btn btn-info mt-2 w-100  fw-bold">
								<a href="${pageContext.request.contextPath}/member/change">회원 정보 수정</a>
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




<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>