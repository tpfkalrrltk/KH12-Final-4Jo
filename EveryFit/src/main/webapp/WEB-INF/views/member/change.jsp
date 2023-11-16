<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>



<style>
a {
	text-decoration: none;
	color: white;
}
</style>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
</script>

<form action="change" method="post" autocomplete="off">
	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5">
					<div class="row">
						<div class="col align-self-start" style="margin-top: 30px;">

							<div class="row">
								<div class="col">
									<h1>개인정보 변경</h1>
								</div>
							</div>


							<div class="col-md-4 offset-md-4 text-center">
								<label>이메일</label> <input type="email" name="memberEmail"
									class="form-control" value="${memberDto.memberEmail}" disabled>
							</div>

							<label>비밀번호</label>
							<div class="col-md-4 offset-md-4 text-center d-flex flex-row">

								<div>
									<input type="password" class="form-control" name="memberPw"
										value="${memberDto.memberPw}" disabled>
								</div>
								<div>
									<button id="examplModal" class="btn btn-success ms-3">변경</button>
								</div>
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								<label> 닉네임 </label> <input type="text" name="memberNick"
									class="form-control" value="${memberDto.memberNick}" required>
							</div>

							<div class="col-md-4 offset-md-4 text-center">
								<label>연락처</label> <input type="tel" name="memberContact"
									class="form-control" value="${memberDto.memberContact}">
							</div>
							<div class="col-md-4 offset-md-4 text-center">
								<label>생년월일</label> <input type="date" name="memberBirth"
									class="form-control" value="${memberDto.memberBirth}" disabled>
							</div>
							<%-- <div class="col-md-4 offset-md-4 text-center">
								<label class="mb-10" style="display: block;">주소</label> <input
									type="text" class="form-control" name="memberPost"
									placeholder="우편번호" style="width: 8em;"
									value="${memberDto.memberPost}">
								<button type="button" class="btn">우편번호 찾기</button>
								<input type="text" class="form-control mt-10"
									name="memberAddr1" placeholder="기본주소"
									value="${memberDto.memberAddr1}"> <input type="text"
									class="form-control mt-10" name="memberAddr2"
									placeholder="상세주소" value="${memberDto.memberAddr2}">
							</div> --%>

							<!-- 삭제할거임 		
							<div class="col-md-4 offset-md-4 text-center">
							<label> 비밀번호 확인 <i class="fa-solid fa-asterisk red"></i>
							</label> <input type="password" name="memberPwRe" required
								class="form-control">
						</div> -->
							<div class="col-md-4 offset-md-4 text-center mt-4">
								<button class="btn btn-danger">
									<a href="/member/exit">회원탈퇴</a>
								</button>

								<button type="submit" class="btn btn-info"
									style="margin-left: 10px;">정보변경</button>
							</div>



							<%-- <c:if test="${param.error != null}">
							<div class="col-md-4 offset-md-4 form-control">
								<h3>입력하신 비밀번호가 일치하지 않습니다</h3>
							</div>
						</c:if>  --%>
						</div>




						<button type="button" class="btn btn-info mt-2"
							data-bs-toggle="modal" data-bs-target="#exampleModal">
							비밀번호 변경</button>


						<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호변경</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">

										<div class="container text-center mt-4">
											<div>
												기존비밀번호<input type="password" value="${memberDto.memberPw}">
											</div>
											<div>
												바꿀비밀번호<input type="password" value="${memberDto.memberPw}">
											</div>
											<div>
												바꾼비밀번호확인<input type="password" value="${memberDto.memberPw}">
											</div>
											<div>
												<button type="button" class="btn btn-secondary mt-3"
													data-bs-dismiss="modal">Close</button>
												<button class="btn btn-warning mt-3 ms-3" id="changePasswordButton">변경</button>
											</div>
										</div>
									</div>
								</div>

							</div>


						</div>
					</div>
				</div>

			</div>
		</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>