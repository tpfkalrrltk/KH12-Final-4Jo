<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<span class="m-5 p-5"></span>
<div class="row"><div class="col-md-8 offset-md-2 mt-5">
<h1 class="m-5 p-5">리그 목록</h1>
	<div class="row">
		<div class="col">
			<a href="leagueInsert">리그등록</a>
		</div>
	</div>
<div class="row">
	<div class="col">
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>종목</th>
					<th>관리자</th>
					<th>제목</th>
					<th>상태</th>
					<th>지역</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="leagueDto" items="${list}">
					<tr>
						<td>${leagueDto.leagueNo}</td>
						<td>${leagueDto.eventName}</td>
						<td>${leagueDto.leagueManager}</td>
						<td>${leagueDto.leagueTitle}</td>
						<td>${leagueDto.leagueStatus}</td>
						<td>${leagueDto.locationDepth1}-${leagueDto.locationDepth2}</td>
						<td>
							<a href="deleteLeague?leagueNo=${leagueDto.leagueNo}">삭제</a>
							<a href="editLeague?leagueNo=${leagueDto.leagueNo}">수정</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<form>
	<div class="row">
		<div class="col">
			리그번호 <input type="number" class="form-control" name="leagueNo">
			종목 <select class="form-select" name="eventName">
					<option value="">종목선택</option>
					<c:forEach var="eventDto" items="${eventList}">
						<option value="${eventDto.eventNo}">${eventDto.eventName}</option>
					</c:forEach>
				</select>
			제목 <input type="text" class="form-control" name="leagueTitle">
			상태 <select class="form-select" name="leagueStatus">
					<option value="">리그상태</option>
					<option value="접수중">접수중</option>
					<option value="접수마감">접수마감</option>
					<option value="대기상태">대기상태</option>
					<option value="진행중">진행중</option>
					<option value="종료됨">종료됨</option>
			</select>
			시/도 
			<select class="form-select" name="locationDepth1">
				<option value="">시/도</option>
				<c:forEach var="locationDto" items="${locationList}">
					<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
				</c:forEach>
			</select>
			구/시
			<select class="form-select" name="locationDepth2">
				<option value="">시/도</option>
			</select>
			<button class="btn btn-primary">검색</button>
		</div>
	</div>
</form>
</div></div>

<script>
	$("[name=locationDepth1]").change(function(e){
		var locationDepth1 = e.target.value;
		console.log(locationDepth1)
		$.ajax({
			url:"http://localhost:8080/rest/location/depth2List",
			type:"post",
			data:{locationDepth1:locationDepth1},
			success:function (data){
				var select = $("[name=locationDepth2]");
				
				select.empty();
				select.append('<option value="">구/시 선택</option>');
				$.each(data, function(index, locationDto){
					var depth2Value = locationDto.locationDepth2;
					select.append('<option value="' + depth2Value + '">' + depth2Value + '</option>');
				});
			},
			error:function(){
				alert('주소 로딩중 서버 에러 발생');
			}
		});
	});
		
</script>