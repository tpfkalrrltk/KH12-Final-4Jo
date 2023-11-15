<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="row"><div class="col-md-8 offset-md-2">
	<div class="row"><div class="col">
		<h1>${leagueDto.leagueTitle} 상세</h1>
	</div></div>
	<hr>
	<div class="row"><div class="col">
		<h3>승인 대기중인 팀목록</h3>
	</div></div>
	<div class="row"><div class="col">
	<c:forEach var="dto" items="${nonApproveList}">
	<div>
		${dto.leagueTeamNo}
		${dto.moimNo}
		${dto.leagueTeamStatus}
		<button type="button" class="updateStatus" data-league-team-no="${dto.leagueTeamNo}">상태수정</button>
	</div>
	</c:forEach>		
	</div></div>

	<div class="row mt-4"><div class="col">
		<h3>리그 순위</h3>
	</div></div>
	
	<div class="row"><div class="col">
		<table class="table">
			<thead>
				<tr>
					<th>순위</th>
					<th>팀</th>
					<th>경기수</th>
					<th>승</th>
					<th>무</th>
					<th>패</th>
					<th>득점</th>
					<th>실점</th>
					<th>득실차</th>
					<th>승점</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="vo" items="${rankList}">
				<tr>
					<td>${vo.leagueTeamRank}</td>
					<td>${vo.leagueTeamNo}</td>
					<td>${vo.leagueTeamMatchCount}</td>
					<td>${vo.leagueTeamWin}</td>
					<td>${vo.leagueTeamLose}</td>
					<td>${vo.leagueTeamDraw}</td>
					<td>${vo.leagueTeamG}</td>
					<td>${vo.leagueTeamD}</td>
					<td>${vo.leagueTeamGD}</td>
					<td>${vo.leagueTeamPoint}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		
			
		
	</div></div>

</div></div>


<script>
$(document).on("click", ".updateStatus", function(){
	var leagueTeamNo = $(this).data("league-team-no");
   
    $.ajax({
        type: "POST",
        url: "http://localhost:8080/rest/league/updateLeagueTeamStatus",
        data: { leagueTeamNo: leagueTeamNo },
        success: function(response) {
            alert("업데이트 성공");
            var updatedTeam = $(`.updateStatus[data-league-team-no=leageuTeamNo]`).closest('div');
            updatedTeam.remove();
        },
        error: function(error) {
            alert("업데이트 실패", error);
        }
    });	
});

</script>


<%@ include file="/WEB-INF/views/template/Footer.jsp"%> 