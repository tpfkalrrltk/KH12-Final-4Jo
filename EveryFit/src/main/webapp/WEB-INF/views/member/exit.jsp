<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<h2>회원 탈퇴</h2>

	<h3>정말 탈퇴하시겠습니까?</h3>
	
	<c:if test="${param.error != null}">
	<h3>비밀번호가 일치하지 않습니다</h3>
	</c:if>
	
	<form action="exit" method="post">
		<input type = "password" name = "memberPw" required placeholder="비밀번호" >
		<br><br>	
	
	<button>yes</button>
	
	
	</form>