<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>

<style>
</style>


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
								class="form-control" value="${memberDto.memberEmail}"
								placeholder="testuser@kh.com">
						</div>

						<div class="col-md-4 offset-md-4 text-center">
							<label>비밀번호</label><input type="text" class="form-control"
								placeholder="Default input" name="memberPw">
						</div>

						<div class="col-md-4 offset-md-4 text-center">
							<label> 닉네임 <i class="fa-solid fa-asterisk red"></i>
							</label> <input type="text" name="memberNick" class="form-control"
								value="${memberDto.memberNick}" required>
						</div>

						<div class="col-md-4 offset-md-4 text-center">
							<label>연락처</label> <input type="tel" name="memberContact"
								class="form-control" value="${memberDto.memberContact}"
								placeholder="- 제외하고 입력">
						</div>
						<div class="col-md-4 offset-md-4 text-center">
							<label>생년월일</label> <input type="date" name="memberBirth"
								class="form-control" value="${memberDto.memberBirth}">
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
						<div class="col-md-4 offset-md-4 text-center">
							<label> 비밀번호 확인 <i class="fa-solid fa-asterisk red"></i>
							</label> <input type="password" name="memberPw" required
								class="form-control">
						</div>
						<div class="col-md-4 offset-md-4 text-center">
							<button type="submit" class="btn btn-info mt-4 btn-lg">정보변경</button>
						</div> 
						


					<%-- 	<c:if test="${param.error != null}">
							<div class="col-md-4 offset-md-4 form-control">
								<h3>입력하신 비밀번호가 일치하지 않습니다</h3>
							</div>
						</c:if> --%>
					</div>


				</div>
			</div>
		</div>

	</div>
</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>