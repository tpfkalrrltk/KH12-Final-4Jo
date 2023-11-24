<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="container-fluid">
	<div class="row"><div class="col-md-8 offset-md-2">
		<div class="p-5 bg-primary text-light rounded">
			<h1>리그수정 <i class="fa-regular fa-pen-to-square"></i></h1>
			<hr>
			<div>
				${leagueDto.leagueTitle} 
			</div>
			<div class="row text-end">
				<div class="col">
					<a href="leagueGuide?leagueNo=${leagueDto.leagueNo}" class="btn btn-info">돌아가기</a>
				</div>
			</div>
		</div>		
		
		<form method="post">
		<div class="row mt-5"><div class="col">
		<div class="input-group">
			<span class="input-group-text">기본정보</span>
			<select class="form-select" name="eventNo">
				<option value="">종목선택</option>
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
			<select class="form-select location-depth1">
				<option value="">시/도</option>
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
			<select class="form-select" name="locationNo">
				<option value="${leagueDto.locationNo}">${locationDto.locationDepth2}</option>
			</select>
		</div>
		</div></div>
		
		<div class="row mt-2"><div class="col">
			<div class="input-group">
				<span class="input-group-text">리그시작일</span>
				<input type="date" class="form-control" name="leagueStart" value="${leagueDto.leagueStart}">
				<span class="input-group-text">리그종료일</span>
				<input type="date" class="form-control" name="leagueEnd" value="${leagueDto.leagueEnd}">
			</div>
		</div></div>
		
		<div class="row mt-2"><div class="col">
			<div class="input-group">
				<span class="input-group-text">최대 참여 가능 팀</span>
				<input type="number" class="form-control" name="leagueTeamCount" min="1" value="${leagueDto.leagueTeamCount}">
				<span class="input-group-text">로스터 정원</span>
				<input type="number" class="form-control" name="leagueRoasterCount" min="1" value="${leagueDto.leagueRoasterCount}">
				<span class="input-group-text">참가비</span>
				<input type="number" class="form-control" name="leagueEntryFee" min="0" value="${leagueDto.leagueEntryFee}">
			</div>
		</div></div>
		
		
		<input type="hidden" name="leagueNo" value="${leagueDto.leagueNo}">
		<div class="row mt-4"><div class="col">
			<label class="form-label">이름</label>
			<input name="leagueTitle" class="form-control" value="${leagueDto.leagueTitle}">
		</div></div>
		<div class="row mt-4"><div class="col">
			<label class="form-label">내용</label>
		    <textarea class="form-control" name="leagueDetail">${leagueDto.leagueDetail}</textarea>
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
			<button type="submit" class="btn btn-primary btn-lg w-100 ">수정</button>        
		</div></div>
		</form>
	</div></div>
</div>
<script>
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
	
	$("[name=leagueDetail]").summernote({
	  	tabsize: 2,
		height: 240,
		fontNames: ['NotoSansKR'],
        fontNamesIgnoreCheck: ['NotoSansKR'],
	    toolbar: [
	          ['style', ['style']],
	          ['font', ['bold', 'underline', 'clear']],
	          ['color', ['color']],
	          ['para', ['ul', 'ol', 'paragraph']],
	          ['table', ['table']],
	          ['insert', ['link']],
	          ['view', ['codeview', 'help']]
	        ]
	  });
			
</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>