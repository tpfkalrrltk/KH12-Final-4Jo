<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<style>
	.img-box{
		height: 50px;
		width: 50px;
	}
</style>

<div class="container-fluid">
	<div class="row"><div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1">
		<div class="p-5 bg-primary text-light rounded mb-5">
			<h1>
				${leagueDto.leagueTitle}
		        <i class="fa-solid fa-ranking-star"></i>
			</h1>
			<hr>
			${sessionScope.level}
			<div class="row mt-4 text-center">
				<div class="col">
					<a href="leagueDetail?leagueNo=${leagueDto.leagueNo}" class="btn btn-lg btn-dark w-100">순위</a>
				</div>
				<div class="col">
					<a class="btn btn-lg btn-dark w-100 disabled">경기</a>
				</div>
			</div>
			<div class="row mt-4 text-end"><div class="col">
				<c:if test="${sessionScope.level=='관리자'}">
					<button class="btn btn-info insert-btn">경기등록</button>
				</c:if>
				<a href="leagueList" class="btn btn-outline-success bg-light">목록으로</a>
			</div></div>
		</div>
		
		<c:if test="${sessionScope.level=='관리자' && leagueDto.leagueStatus=='접수마감'}">
			<div class="row text-end"><div class="col"></div><div class="col input-group">
				<label class="input-group-text">경기자동생성</label>
				<select class="form-select" name="isDouble">
					<option value="">리그방식 선택</option>
					<option value="false">싱글라운드</option>
					<option value="true">더블라운드</option>
				</select>
				<button class="btn btn-info auto-match-btn" data-league-no="${param.leagueNo}">생성</button>
			</div></div>
		</c:if>
		
		
		
		<c:forEach var="matchDto" items="${leagueMatchList}">
			<div class="row mt-5 p-3 border border-light rounded shadow-sm"><div class="col">
				<div class="row text-center">
					<div class="col-2">
						<a href="leagueTeamDetail?leagueTeamNo=${matchDto.leagueMatchHome}">
							<img src="/league/leagueTeamImage?leagueTeamNo=${matchDto.leagueMatchHome}" class="rounded w-100 m-2">
						</a>
					</div>
					<div class="col">
						<div class="row m-2"><div class="col">
							<c:choose>
								<c:when test="${matchDto.parsedLeagueMatchDate==null}">
									아직 경기 일정이 없습니다
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${matchDto.parsedLeagueMatchDate}" pattern="yyyy-MM-dd"/>
								</c:otherwise>
							</c:choose>
						</div></div>
						<div class="row m-2"><div class="col">
							${matchDto.leagueMatchLocation}
						</div></div>
						<div class="row m-2"><div class="col">
							<c:choose>
								<c:when test="${matchDto.leagueMatchHomeScore == null && matchDto.leagueMatchAwayScore == null}">
									<h2><fmt:formatDate value="${matchDto.parsedLeagueMatchDate}" pattern="hh:mm"/>(경기전)</h2>									
								</c:when>
								<c:otherwise>
									<h2>${matchDto.leagueMatchHomeScore} : ${matchDto.leagueMatchAwayScore}</h2>
								</c:otherwise>
							</c:choose>
						</div></div>
					</div>
					<div class="col-2">
						<a href="leagueTeamDetail?leagueTeamNo=${matchDto.leagueMatchAway}">
							<img src="/league/leagueTeamImage?leagueTeamNo=${matchDto.leagueMatchAway}" class="rounded w-100 m-2">
						</a>
					</div>
					<div class="row"><div class="col">
						<h5>${matchDto.homeTeamName} vs ${matchDto.awayTeamName}</h5>
					</div></div>
					<div class="row"><div class="col">
						<button class="btn btn-info me-1 edit-btn" data-league-match-no="${matchDto.leagueMatchNo}">경기수정</button>
						<button class="btn btn-info ms-1 result-btn" data-league-match-no="${matchDto.leagueMatchNo}">결과등록</button>
					</div></div>
				</div>
			</div></div>
		</c:forEach>
		
	</div></div>
</div>


<!-- 경기 수정 모달 -->
<div class="modal" id="matchEditModal" data-bs-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">경기수정</h4>
			</div>
			<div class="modal-body">
				<form class="leagueMatchEditForm">
					<input type="hidden" name="leagueMatchNo" value="">
					<input type="hidden" name="leagueNo" value="">
					<div class="row">
						<div class="col">
							<label class="form-label">홈팀</label>
							<select class="form-select" name="leagueMatchHome">
								<option value="">홈팀선택</option>
								<c:forEach var="leagueTeamDto" items="${leagueTeamList}">
									<option value="${leagueTeamDto.leagueTeamNo}">${leagueTeamDto.leagueTeamName}</option>	
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label"></label>
							<select class="form-select" name="leagueMatchAway">
								<option value="">어웨이팀선택</option>
								<c:forEach var="leagueTeamDto" items="${leagueTeamList}">
									<option value="${leagueTeamDto.leagueTeamNo}">${leagueTeamDto.leagueTeamName}</option>	
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">경기일정</label> 
							<input type="datetime-local" class="form-control"
								name="leagueMatchDate" value="">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">장소</label> 
							<input class="form-control" name="leagueMatchLocation" value="">
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							<button type="button" class="btn btn-primary w-100 match-edit-btn">수정</button>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeModal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 경기 결과 입력 모달 -->
<div class="modal" id="matchResultModal" data-bs-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">경기결과입력</h4>
			</div>
			<div class="modal-body">
				<form class="leagueMatchResultForm">
					<input type="hidden" name="leagueMatchNo" value="">
					<input type="hidden" name="leagueNo" value="">
					<input type="hidden" name="leagueMatchHome" value="">
					<input type="hidden" name="leagueMatchAway" value="">
					<div class="row">
						<div class="col">
							<label class="form-label">홈팀</label> 
							<input class="form-control" name="homeTeamName" value="" disabled>
						</div>
						<div class="col">
							<label class="form-label">홈팀 스코어</label> 
							<input type="number" class="form-control" min="0" 
								name="leagueMatchHomeScore" value="">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">어웨이팀</label> 
							<input class="form-control" name="awayTeamName" value="" disabled>
						</div>
						<div class="col">
							<label class="form-label">어웨이 스코어</label> 
							<input type="number" class="form-control" min="0" 
								name="leagueMatchAwayScore" value="">
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							<button type="button" class="btn btn-primary w-100 match-result-btn">결과등록</button>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeModal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 경기 등록 모달 -->
<div class="modal" id="matchInsertModal" data-bs-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">경기등록</h4>
			</div>
			<div class="modal-body">
				<form class="leagueMatchForm">
					<input type="hidden" name="leagueNo" value="${param.leagueNo}">
					<div class="row">
						<div class="col">
							<label class="form-label">홈팀</label>
							<select class="form-select" name="leagueMatchHome">
								<option value="">홈팀선택</option>
								<c:forEach var="leagueTeamDto" items="${leagueTeamList}">
									<option value="${leagueTeamDto.leagueTeamNo}">${leagueTeamDto.leagueTeamName}</option>	
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label class="form-label">어웨이팀</label> 
							<select class="form-select" name="leagueMatchAway">
								<option value="">어웨이팀선택</option>
								<c:forEach var="leagueTeamDto" items="${leagueTeamList}">
									<option value="${leagueTeamDto.leagueTeamNo}">${leagueTeamDto.leagueTeamName}</option>	
								</c:forEach>
							</select>
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
					<div class="row mt-2">
						<div class="col">
							<button type="button" class="btn btn-primary match-submit-btn w-100">등록</button>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeModal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
	
$(".auto-match-btn").click(function(){
	var leagueNo = $(this).data("league-no");
	var isDouble = $("[name='isDouble']").val();
	console.log(isDouble);
	if(isDouble=="") {
		alert("리그방식을 선택해주세요");
		return;
	}
	
	$.ajax({
		type:"post",
		url:"http://localhost:8080/rest/league/autoMatchInsert/",
		data:{leagueNo:leagueNo, isDouble:isDouble},
		success:function(response){
			alert("생성되었습니다.");
			location.reload();
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	})
	
});
	
	
	
$(".insert-btn").click(function(){
	$("#matchInsertModal").modal('show');
});

$(".closeModal").click(function(){
	location.reload();
});

$(".match-submit-btn").click(function(){
	var homeTeam = $(".leagueMatchForm select[name='leagueMatchHome']").val();
	var awayTeam = $(".leagueMatchForm select[name='leagueMatchAway']").val();
	console.log('hometeam = '+ homeTeam);
	console.log('awayteam = '+ awayTeam);
	var formData = $(".leagueMatchForm").serialize();
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

$(".edit-btn").click(function(e){
	var leagueMatchNo = $(this).data('league-match-no');
	$.ajax({
		type:"post",
		url:"http://localhost:8080/rest/league/findLeagueMatchVO",
		data:{leagueMatchNo:leagueMatchNo},
		success:function(response){
			$("#matchEditModal input").each(function() {
                var inputName = $(this).attr('name');
                $(this).val(response[inputName]);
            });
			
			$("#matchEditModal select").each(function() {
				var selectName = $(this).attr('name');
				var selectedValue = response[selectName];

				$(this).val(selectedValue);
			});
			
			$("#matchEditModal").modal("show");
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	})
});

//경기결과 입력버튼(모달띄우기)
$(".result-btn").click(function(){
	$("#matchResultModal").modal('show');
	var leagueMatchNo = $(this).data('league-match-no');
	$.ajax({
		type:"post",
		url:"http://localhost:8080/rest/league/findLeagueMatchVO",
		data:{leagueMatchNo:leagueMatchNo},
		success:function(response){
			console.log(response);
			$("#matchResultModal input").each(function() {
                var inputName = $(this).attr('name');
                $(this).val(response[inputName]);
            });
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	})
});


$(".match-edit-btn").click(function(){
	var formData = $(".leagueMatchEditForm").serialize();
	var leagueMatchNo = $(".leagueMatchEditForm input[name='leagueMatchNo']").val();
	$.ajax({
		type:"put",
		url:"http://localhost:8080/leagueMatch/" + leagueMatchNo,
		data:formData,
		success:function(response){
			alert("수정되었습니다.");
			location.reload();
			 $(".leagueMatchForm input:not([type='hidden'])").val('');
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	});
});

//경기 결과 등록하기(통신)
$(".match-result-btn").click(function(){
	var formData = $(".leagueMatchResultForm").serialize();
	var leagueMatchNo = $(".leagueMatchResultForm input[name='leagueMatchNo']").val();
	$.ajax({
		type:"put",
		url:"http://localhost:8080/leagueMatch/result/" + leagueMatchNo,
		data:formData,
		success:function(response){
			alert("등록되었습니다.");
			location.reload();
		},
		error:function(error){
			alert("오류가 발생했습니다.")
		}
	});
});
</script>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%>
