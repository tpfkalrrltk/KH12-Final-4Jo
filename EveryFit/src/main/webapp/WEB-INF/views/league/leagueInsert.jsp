<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="row">
	<div class="col">
		<c:choose>
			<c:when test="${leagueDto==null}">
				<h1>리그등록</h1>
			</c:when>
			<c:otherwise>
				<h1>${leagueDto.leagueNo}번 리그 수정</h1>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<form method="post">
	<div class="row mt-4"><div class="col">
		<label class="form-label">종목</label>
		<c:choose>
			<c:when test="">
			
			</c:when>
		</c:choose>
		
        <select class="form-select" name="eventNo">
			<option value="">종목선택</option>
			<c:forEach var="eventDto" items="${eventList}">
				<option value="${eventDto.eventNo}">${eventDto.eventName}</option>
			</c:forEach>
		</select>
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">시/도</label>
		<select class="form-select location-depth1">
			<option value="">시/도</option>
			<c:forEach var="locationDto" items="${locationList}">
				<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
			</c:forEach>
		</select>
		<label class="form-label">구/시 선택</label>
		<select class="form-select" name="locationNo">
			<option value="">시/도</option>
		</select>
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">제목</label>
        <input class="form-control" name="leagueTitle">
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">내용</label>
        <textarea class="form-control" name="leagueDetail" rows="5"></textarea>
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">참가비</label>
        <input type="number" class="form-control" name="leagueEntryFee">
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">리그시작</label>
        <input type="date" class="form-control" name="leagueStart">
    </div></div>
    <div class="row mt-4"><div class="col">
		<label class="form-label">리그마감</label>
        <input type="date" class="form-control" name="leagueEnd">
    </div></div>
    <div class="row mt-4"><div class="col">
        <button type="submit" class="btn btn-primary">리그등록</button>
    </div></div>
</form>



<script>
	$(".location-depth1").change(function(e){
		var locationDepth1 = e.target.value;
		console.log(locationDepth1)
		$.ajax({
			url:"http://localhost:8080/rest/location/depth2List",
			type:"post",
			data:{locationDepth1:locationDepth1},
			success:function (data){
				var select = $("[name=locationNo]");
				
				select.empty();
				select.append('<option value="">구/시 선택</option>');
				$.each(data, function(index, locationDto){
					var depth2Value = locationDto.locationDepth2;
					var locationNo = locationDto.locationNo;
					select.append('<option value="' + locationNo + '">' + depth2Value + '</option>');
				});
			},
			error:function(){
				alert('주소 로딩중 서버 에러 발생');
			}
		});
	});
		
</script>