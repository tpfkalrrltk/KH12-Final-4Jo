<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 상세페이지</title>
</head>
<body>
	<!-- 수정, 정모등록 등 비동기로 구현할 예정임 -->
	<h1>모임 상세(사진, 모임명, 설명)</h1>
	${moimDto}
	<h1>회원목록</h1>
	<c:forEach var="moimMemberDto" items="${memberList}" >
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
	</c:forEach>
	<hr>
	<h1>정모 List</h1>
	<hr>
</body>
</html>