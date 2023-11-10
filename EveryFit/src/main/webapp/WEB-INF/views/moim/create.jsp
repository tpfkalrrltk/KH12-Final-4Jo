<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>


<title>등록해보기</title>

<h1>모임등록</h1>
<form method="post" autocomplete="off">
     지역
<select name="locationNo">
    <c:forEach var="location" items="${locationList}">
        <option value="${location.locationNo}">
            ${location.locationDepth1} - ${location.locationDepth2}
        </option>
    </c:forEach>
</select>
     <br>
     종목
     <select name="eventNo">
         <c:forEach var="event" items="${eventList}">
             <option value="${event.eventNo}">${event.eventName}</option>
         </c:forEach>
     </select>
	모임명<input type="text" name="moimTitle">
	모임설명<input type="text" name="moimContent">
	<input type="hidden" name="moimMemberCount" value=30>
	성별체크여부<input type="text" name="moimGenderCheck">
	<input type="number" name="chatRoomNo" value=1>
	
	<button type="submit">등록</button>
</form>
