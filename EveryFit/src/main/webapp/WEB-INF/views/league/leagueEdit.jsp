<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="row mt-4"><div class="col">
	<h1>${leagueDto.leagueNo}번 리그 수정</h1>       
</div></div>
<form method="post">
<input type="hidden" name="leagueNo" value="${leagueDto.leagueNo}">
<div class="row mt-4"><div class="col">
	<label class="form-label">종목</label>
	<select name="eventNo" class="form-select">
		<c:forEach var="event" items="${eventList}">
			<c:choose>
				<c:when test="${leagueDto.eventNo==event.eventNo}">
					<option value="${event.eventNo}" selected>${event.eventName}</option>					
				</c:when>
				<c:otherwise>
					<option value="${event.eventNo}">${event.eventName}</option>	
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</select> 
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">시/도</label>
	<select class="form-select location-depth1">
		<c:forEach var="location" items="${locationList}">
			<c:choose>
				<c:when test="${leagueDto.locationNo==location.locationNo}">
					<option value="${location.locationDepth1}" selected>${location.locationDepth1}</option>					
				</c:when>
				<c:otherwise>
					<option value="${location.locationDepth1}">${location.locationDepth1}</option>	
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</select> 
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">시/구</label>
	<select class="form-select" name="locationNo">
		<option value="${leagueDto.locationNo}">${locationDto.locationDepth2}</option>
	</select>
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">이름</label>
	<input name="leagueTitle" class="form-control" value="${leagueDto.leagueTitle}">
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">내용</label>
    <textarea class="form-control" name="leagueDetail" rows="5">${leagueDto.leagueDetail}</textarea>
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">참가비</label>
	<input type="number" name="leagueEntryFee" class="form-control" value="${leagueDto.leagueEntryFee}">
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">리그시작</label>
    <input type="date" class="form-control" name="leagueStart" value="${leagueDto.leagueStart}">
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">리그마감</label>
    <input type="date" class="form-control" name="leagueEnd" value="${leagueDto.leagueEnd}">
</div></div>
<div class="row mt-4"><div class="col">
	<label class="form-label">리그상태</label>
	<select class="form-select" name="leagueStatus" id="leagueStatusSelect">
		<option value="대기상태">대기상태</option>
		<option value="접수중">접수중</option>
		<option value="접수마감">접수마감</option>
		<option value="진행중">진행중</option>
		<option value="종료됨">종료됨</option>
	</select>
</div></div>
<div class="row mt-4"><div class="col">
	<button type="submit" class="btn btn-primary">수정</button>        
</div></div>
</form>


<script>
$(function(){
	var leagueStatusSelect = document.getElementById("leagueStatusSelect");
	for (var i = 0; i < leagueStatusSelect.options.length; i++) {
	    if (leagueStatusSelect.options[i].value === "${leagueDto.leagueStatus}") {
	        leagueStatusSelect.options[i].selected = true;
	        break;
	    }
	}
	
	function loadLoactionList(e){
		var locationDepth1 = e.target.value;
	    $.ajax({
	        url: "http://localhost:8080/rest/location/depth2List",
	        type: "post",
	        data: { locationDepth1: locationDepth1 },
	        success: function (data) {
	            var select = $("[name=locationNo]");
	
	            select.empty();
	            select.append('<option value="">구/시 선택</option>');
	            $.each(data, function (index, locationDto) {
	                var depth2Value = locationDto.locationDepth2;
	                var locationNo = locationDto.locationNo;
	                select.append('<option value="' + locationNo + '">' + depth2Value + '</option>');
	            });
	        },
	        error: function () {
	            alert('주소 로딩 중 서버 에러 발생');
	        }
	    });
	}


	$(".location-depth1").change(loadLoactionList);
});
	
		
</script>