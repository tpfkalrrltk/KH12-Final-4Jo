<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>

<div>
	<h3>login</h3>
</div>



<form action="login" method="post" autocomplete="off">



	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h3>login</h3>
							</div>

							<div class="col-md-4 offset-md-4">
								<input type="text" name="memberEmail" class="form-control" placeholder="email">
							</div>
							
							<div class="col-md-4 offset-md-4 mt-2">
								 <input type="password" name="memberPw" class="form-control" placeholder="pw">
							</div>
							
							<div class="col-md-4 offset-md-4 mt-2">
								 <span>아이디 찾기 </span> |
								 <span>비밀번호 찾기</span> |
								<span>회원가입</span>
							</div>
							
							
							<div class="mt-5">
								<button type="submit" class="btn btn-success">login</button>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</form>

<jsp:include page="../template/Header.jsp"></jsp:include>