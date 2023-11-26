<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<style>
a{
	text-decoration:none;
}
.cursor{
	cursor:pointer;
}
</style>

<div class="container-fluid">
	<div class="row"><div class="col-md-8 offset-md-2">
		<div class="p-5 bg-primary text-light rounded">
			<h1>
				<a href="leagueList" class="text-light">
					리그 목록 
					<i class="fa-solid fa-trophy"></i>
				</a>
			</h1>
			<hr>
			<div class="text-end">
				<a href="/" class="btn btn-outline-success bg-light">홈으로</a>
				<c:if test="${sessionScope.level=='관리자'}">
					<a href="leagueInsert" class="btn btn-info">리그등록</a>
				</c:if>
			</div>
		</div>
		
		<form>
		<div class="row mt-5"><div class="col">
			<div class="input-group">
				<span class="input-group-text">리그검색</span>
				<select class="form-select" name="eventName">
					<option value="">종목</option>
					<c:forEach var="eventDto" items="${eventList}">
						<c:choose>
							<c:when test="${vo.eventName==eventDto.eventName}">
								<option value="${eventDto.eventName}" selected>${eventDto.eventName}</option>
							</c:when>
							<c:otherwise>
								<option value="${eventDto.eventName}">${eventDto.eventName}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<select class="form-select" name="leagueStatus">
		            <option value="">리그상태</option>
				    <c:choose>
				        <c:when test="${vo.leagueStatus eq '접수중'}">
				            <option value="접수중" selected>접수중</option>
				        </c:when>
				        <c:otherwise>
				            <option value="접수중">접수중</option>
				        </c:otherwise>
				    </c:choose>
				    <c:choose>
				        <c:when test="${vo.leagueStatus eq '접수마감'}">
				            <option value="접수마감" selected>접수마감</option>
				        </c:when>
				        <c:otherwise>
				            <option value="접수마감">접수마감</option>
				        </c:otherwise>
				    </c:choose>
				
				    <c:choose>
				        <c:when test="${vo.leagueStatus eq '대기상태'}">
				            <option value="대기상태" selected>대기상태</option>
				        </c:when>
				        <c:otherwise>
				            <option value="대기상태">대기상태</option>
				        </c:otherwise>
				    </c:choose>
				
				    <c:choose>
				        <c:when test="${vo.leagueStatus eq '진행중'}">
				            <option value="진행중" selected>진행중</option>
				        </c:when>
				        <c:otherwise>
				            <option value="진행중">진행중</option>
				        </c:otherwise>
				    </c:choose>
				
				    <c:choose>
				        <c:when test="${vo.leagueStatus eq '종료됨'}">
				            <option value="종료됨" selected>종료됨</option>
				        </c:when>
				        <c:otherwise>
				            <option value="종료됨">종료됨</option>
				        </c:otherwise>
				    </c:choose>
				</select>
				<select class="form-select" name="locationDepth1">
					<option value="">시/도</option>
					<c:forEach var="locationDto" items="${locationList}">
						<c:choose>
							<c:when test="${vo.locationDepth1 eq locationDto.locationDepth1}">
								<option value="${locationDto.locationDepth1}" selected>${locationDto.locationDepth1}</option>
							</c:when>
							<c:otherwise>
								<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<select class="form-select" name="locationDepth2">
					<option value="">시/군/구</option>
				</select>
				<input type="text" class="form-control" name="leagueTitle" placeholder="제목검색" value="${vo.leagueTitle}">
				<button class="btn btn-primary">검색</button>
			</div>
		</div></div>
		</form>
		
		<div class="row mt-5">
			<div class="col">
				<table class="table table-hover text-center">
					<thead>
						<tr class="table-secondary">
							<th width="5%">번호</th>
							<th width="10%">종목</th>
							<th width="35%">제목</th>
							<th width="10%">상태</th>
							<th width="15%">지역</th>
							<th width="15%">참가요강</th>
							<c:if test="${sessionScope.level=='관리자'}">
								<th width="10%" class="text-info">접수</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="leagueDto" items="${list}">
							<tr>
								<td>${leagueDto.leagueNo}</td>
								<td>${leagueDto.eventName}</td>
								<td><a class="alert-link" href="leagueDetail?leagueNo=${leagueDto.leagueNo}">${leagueDto.leagueTitle}</a></td>
								<td>${leagueDto.leagueStatus}</td>
								<td>${leagueDto.locationDepth1}-${leagueDto.locationDepth2}</td>
								<td><a href="leagueGuide?leagueNo=${leagueDto.leagueNo}" class="alert-link">
									<i class="fa-solid fa-arrow-up-right-from-square"></i>
									참가요강</a></td>
								<c:if test="${sessionScope.level=='관리자'}">
									<td>
										<div class="edit-application text-info cursor fw-bold" data-league-no="${leagueDto.leagueNo}">
											<i class="fa-regular fa-pen-to-square"></i>관리
										</div>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row mt-5"><div class="col">
			<nav aria-label="Page navigation">
	            <ul class="pagination justify-content-center">
	                <c:if test="${!vo.isFirst()}">
	                    <li class="page-item">
	                        <a class="page-link" href="leagueList?page=${vo.page - 1}${vo.generateQueryString()}" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
	                </c:if>
	
	                <c:forEach var="i" begin="${vo.begin}" end="${vo.end}">
	                	<c:choose>
	                		<c:when test="${vo.page==i}">
	                			<li class="page-item">
			                        <a class="page-link active" href="leagueList?page=${i}${vo.generateQueryString()}">${i}</a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" href="leagueList?page=${i}${vo.generateQueryString()}">${i}</a>
			                    </li>
	                		</c:otherwise>
	                	</c:choose>
	                </c:forEach>
	
	                <c:if test="${!vo.isLast()}">
	                    <li class="page-item">
	                        <a class="page-link" href="leagueList?page=${vo.page + 1}${vo.generateQueryString()}" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
	                </c:if>
	            </ul>
	        </nav>
		</div></div>			
		
		<c:if test="${empty list}">
			<div class="row text-warning"><div class="col">
				<h2>검색결과가 존재하지 않습니다</h2>
			</div></div>
		</c:if>	
	</div></div>
</div>

<!-- 접수 모달 -->
<div class="modal fade" id="applicationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">접수 일정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="appInsert" method="post">
      	<input type="hidden" name="leagueNo">
      	<input type="hidden" id="actionType" name="actionType" value="add">
      	<input type="hidden" id="leagueApplicationNo" name="leagueApplicationNo" value="">
      	<div class="row">
      		<div class="col">
      			<label class="form-label">접수시작</label>
      			<input type="text" name="leagueApplicationStart" id="applicationStart">
      		</div>
      	</div>
      	<div class="row">
      		<div class="col">
      			<label class="form-label">접수마감</label>
      			<input type="text" name="leagueApplicationEnd" id="applicationEnd">
      		</div>
      	</div>
      </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="appBtn">등록</button>
      </div>
    </div>
  </div>
</div>

<script>
$(function(){
	$("[name=locationDepth1]").change(function(e){
		var locationDepth1 = e.target.value;
		if(locationDepth1=="") return;
		$.ajax({
			url:"http://localhost:8080/rest/location/depth2List",
			type:"post",
			data:{locationDepth1:locationDepth1},
			success:function (data){
				var select = $("[name=locationDepth2]");
				
				select.empty();
				select.append('<option value="">시/군/구</option>');
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
	
	var Modal = new bootstrap.Modal(document.getElementById('applicationModal'));
	
	$(".edit-application").click(function(e){
		var leagueNo = $(this).data('league-no');
		loadApplication(leagueNo);	
	});
	
	function loadApplication(leagueNo){
		$.ajax({
			url:"http://localhost:8080/rest/league/findLeagueApplication",
			type:"post",
			data:{leagueNo:leagueNo},
			success:function(data){
				console.log(data);
				if(data==false){
					$("#actionType").val("add");
				}
				else{
					$("#actionType").val("edit");
					$("#leagueApplicationNo").val(data.leagueApplicationNo);
					$("#appInsert input[name='leagueApplicationStart']").val(convertToDefault(data.leagueApplicationStart));
					$("#appInsert input[name='leagueApplicationEnd']").val(convertToDefault(data.leagueApplicationEnd));
				}
				Modal.show();
			},
			error: function(response) {
			    console.log(response);
			}
		})
		$("#appInsert input[name='leagueNo']").val(leagueNo);
	};
	
	$("#applicationModal").on('hidden.bs.modal', function(){
		location.reload();
	});
	
	$("#appBtn").click(function(){
		var applicationStart = $("#appInsert input[name='leagueApplicationStart']").val();
		var applicationEnd = $("#appInsert input[name='leagueApplicationEnd']").val();
		
		if(applicationStart=="" || applicationEnd==""){
			alert('일정이 입력되지 않았습니다.');
			return;
		}
		
		if(applicationStart >= applicationEnd) {
			alert('시작일과 마감일을 확인해주세요');
			return;
		}
		
		Modal.hide();
		
		$("#appInsert input[name='leagueApplicationStart']").val(convertToLocal(applicationStart));
		$("#appInsert input[name='leagueApplicationEnd']").val(convertToLocal(applicationEnd));
		
		var formData = $("#appInsert").serialize();
		
		
		var url = ($("#actionType").val() === "add") ? "http://localhost:8080/rest/league/addLeagueApplication" : "http://localhost:8080/rest/league/updateLeagueApplication";
		$.ajax({
			url:url,
			type:"post", 
			data:formData,
			success:function(data){
				alert("완료되었습니다");
				
			},
			error:function(){
				alert("오류발생")
			}
		});
	});
	
	$("#applicationStart").datetimepicker({
		step:30,
		minDate:0, 
		useCurrent:false, 
		onClose: function(e) {
			console.log(e);
			 $("#applicationEnd").datetimepicker('setOptions', {minDate:e});
		},
	});
	
	
	$("#applicationEnd").datetimepicker({
		step:30,
		useCurrent:false
	});
	
	function convertToLocal(dateTime){
		var dateObject = new Date(dateTime + 'Z');
		var formattedDate = dateObject.toISOString().slice(0, 16);
		return formattedDate;
	}
	
	function convertToDefault(dateTime){
		var dateObject = new Date(dateTime);
	    var utcDate = new Date(dateObject.getUTCFullYear(), dateObject.getUTCMonth(), dateObject.getUTCDate(), dateObject.getUTCHours(), dateObject.getUTCMinutes());
	    var momentDate = moment(utcDate);
	    var resultDate = momentDate.format("Y/MM/DD H:ss");
	    return resultDate;
	}
	
});
</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>