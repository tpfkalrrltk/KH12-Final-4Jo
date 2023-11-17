<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<div class="row">
	<div class="col-md-8 offset-md-2">

		<div class="row">
			<div class="col">
				<h1>경기 일정</h1>
			</div>
		</div>

		<div class="row">
			<div class="col">
				<button class="btn btn-primary insert-btn">경기등록</button>
			</div>
		</div>
		
		<c:forEach var="matchDto" items="${leagueMatchList}">
		<div class="row">
			<div class="col">
				${matchDto}
			</div>
		</div>
		</c:forEach>
	</div>
</div>

<!-- 경기 등록 모달 -->
<div class="modal" id="matchInsertModal" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">경기등록</h4>
			</div>
			<div class="modal-body">
				<form class="leagueMatchForm">
					<input type="hidden" name="leagueNo" value="${param.leagueNo}">
					<div class="row">
						<div class="col">
							<label class="form-label">홈팀</label> <input class="form-control"
								name="leagueMatchHome">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">어웨이팀</label> <input
								class="form-control" name="leagueMatchAway">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">경기일정</label> <input
								type="datetime-local" class="form-control"
								name="leagueMatchDate">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">장소</label> <input class="form-control"
								name="leagueMatchLocation">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<button type="button" class="btn btn-primary match-submit-btn">등록</button>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					id="closeMatchInsertModal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
$(".insert-btn").click(function(){
	$("#matchInsertModal").modal('show');
});

$("#closeMatchInsertModal").click(function(){
	$("#matchInsertModal").modal('hide');  
	location.reload();
});

$(".match-submit-btn").click(function(){
	var formData = $(".leagueMatchForm").serialize();
	console.log(formData);
	$.ajax({
		type:"post",
		url:"http://localhost:8080/leagueMatch/",
		data:formData,
		success:function(response){
			alert("등록되었습니다.");
			 $(".leagueMatchForm input:not([type='hidden'])").val('');
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	});
});


</script>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%>