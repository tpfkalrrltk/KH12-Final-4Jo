<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록해보기</title>
</head>
<body>
<h1>모임등록</h1>
<form method="post" autocomplete="off">
	지역번호<input type="text" name="locationNo">
	종목번호<input type="text" name="eventNo">
	모임명<input type="text" name="moimTitle">
	모임설명<input type="text" name="moimContent">
	<input type="hidden" name="moimMemberCount" value=30>
	성별체크여부<input type="text" name="moimGenderCheck">
	<input type="number" name="chatRoomNo" value=1>
	
	<button type="submit">등록</button>
</form>
</body>
</html>