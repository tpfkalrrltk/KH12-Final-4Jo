<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
a {
	text-decoration: none;
	color: black;
}
</style>





<form action="login" method="post" autocomplete="off">



	<div class="container-fluid mt-2">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h3>login</h3>
							</div>

							<div class="col-md-4 offset-md-4">
								<input type="text" name="memberEmail" class="form-control"
									placeholder="email" value="${cookie.saveId.value}">
							</div>

							<div class="col-md-4 offset-md-4 mt-2">
								<input type="password" name="memberPw" class="form-control"
									placeholder="pw">
							</div>




							<!-- 자동로그인  -->

							<div class="col-md-4 offset-md-4 mt-2 text-start">
								<div class="form-check">
									<c:choose>
										<c:when test="${cookie.saveId != null }">
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin" checked>
											<label class="form-check-label" for="flexCheckDefault">
												로그인 상태 유지 </label>
										</c:when>
										<c:otherwise>
											<input class="form-check-input" type="checkbox" value="ok"
												id="flexCheckDefault" name="autoLogin">
											<label class="form-check-label" for="flexCheckDefault">
												아이디 저장 </label>
										</c:otherwise>
									</c:choose>
								</div>
							</div>


							<div class="col-md-4 offset-md-4 mt-2">
								<span><a href="#">아이디 찾기</a> </span> | <span><a
									href="/member/findPw">비밀번호 찾기</a></span> | <span><a
									href="/member/join">회원가입</a></span>
							</div>


							<div class="col-md-4 offset-md-4 mt-5 ">
								<button type="submit" class="btn btn-success" style="width:350px;">login</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</form>


<jsp:include page="../template/Footer.jsp"></jsp:include>