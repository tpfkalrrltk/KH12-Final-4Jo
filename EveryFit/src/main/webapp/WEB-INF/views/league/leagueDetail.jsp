<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<style>
a{
	text-decoration:none;
}
</style>
<div class="container-fluid">
	<div class="row"><div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1">
		<div class="p-5 bg-primary text-light rounded">
        	<h1>
        		${leagueDto.leagueTitle}
        		<i class="fa-solid fa-ranking-star"></i>
        	</h1>
        	<hr>
        	<div class="row mt-4 text-center">
				<div class="col">
					<a class="btn btn-lg btn-dark w-100 disabled">순위</a>
				</div>
				<div class="col">
					<a href="leagueMatch?leagueNo=${leagueDto.leagueNo}" class="btn btn-lg btn-dark w-100">경기</a>
				</div>
			</div>
			<div class="row mt-4"><div class="col">
	        	<div class="text-end">
	        		<c:if test="${sessionScope.level=='관리자'}">
				        <button type="button" class="btn btn-info" id="loadLeagueTeamList">신청팀 관리</button>
	        		</c:if>
	        		<a href="leagueList" class="btn btn-outline-success bg-light">목록으로</a>
	        	</div>
        	</div></div>
      	</div>
      	
	    <div class="row mt-5">
	      <div class="col">
	        <table class="table table-hover text-center">
	          <thead>
	            <tr class="table-secondary">
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
	              <tr style="height: 30px;">
	                <td>${vo.leagueTeamRank}</td>
	                <td>
	                	<a href="leagueTeamDetail?leagueTeamNo=${vo.leagueTeamNo}">
		                	${vo.leagueTeamName}
		               		<img style="height: 35px; width: 35px;" class="rounded" src="/league/leagueTeamImage?leagueTeamNo=${vo.leagueTeamNo}">
	               		</a> 
	                </td>
	                <td>${vo.leagueTeamMatchCount}</td>
	                <td>${vo.leagueTeamWin}</td>
	                <td>${vo.leagueTeamDraw}</td>
	                <td>${vo.leagueTeamLose}</td>
	                <td>${vo.leagueTeamG}</td>
	                <td>${vo.leagueTeamD}</td>
	                <td>${vo.leagueTeamGD}</td>
	                <td>${vo.leagueTeamPoint}</td>
	              </tr>
	            </c:forEach>
	          </tbody>
	        </table>
	      </div>
		</div>
	
	</div></div>

</div>

<!-- 미승인 팀목록 모달 -->
<div class="modal" id="teamListModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">팀목록</h4>
      </div>
      <div class="modal-body">
      	<table class="table table-hover text-center">
			<thead>
				<tr class="table-secondary">
					<th>번호</th>
					<th>팀이름</th>
					<th>모임번호</th>
					<th>승인관리</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="closeTeamListModal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>

	function loadLeagueTeamList(leagueNo, successCallback, errorCallback){
	  $.ajax({
	    type: "POST",
	    url: "http://localhost:8080/rest/league/loadLeagueTeamList",
	    data: { leagueNo: leagueNo},
	    success: function(response) {
	      if (typeof successCallback === 'function') {
	        successCallback(response);
	      }
	    },
	    error: function(error){
	      if (typeof errorCallback === 'function') {
	        errorCallback(error);
	      }
	      else{
	        alert("오류발생", error);
	      }
	    }
	  });
	};
	
	$("#loadLeagueTeamList").click(function(){
	  var leagueNo = ${leagueDto.leagueNo};
	  updateTeamListModal(leagueNo);
	});
	
	function updateTeamListModal(leagueNo){
		loadLeagueTeamList(leagueNo, function(response){
			var tbody = $("#teamListModal tbody");
			tbody.empty();
			$.each(response, function(index, leagueTeamDto){
				var row = $("<tr>");
				row.append('<td>' + leagueTeamDto.leagueTeamNo + '</td>');
	            row.append('<td>' + leagueTeamDto.leagueTeamName + '</td>');
	            var moimNoCell = $('<td>');
	            var moimNoLink = $('<a>')
	                .attr('href', '/moim/detail?moimNo=' + leagueTeamDto.moimNo)
	                .text(leagueTeamDto.moimNo)
	                .addClass("alert-link text-warning");
	            moimNoCell.append(moimNoLink);
	            row.append(moimNoCell);
	           
	            var approveButton = $("<button>")
	            .text(leagueTeamDto.leagueTeamStatus === 'N' ? "승인" : "승인취소")
	            .addClass("updateStatus btn btn-info")
	            .data("league-team-no", leagueTeamDto.leagueTeamNo);

	            var buttonCell = $("<td>").append(approveButton);
	            row.append(buttonCell);
	            
	            tbody.append(row);            
			})
			 $("#teamListModal").modal('show');
		});
	}
	
	$("#closeTeamListModal").click(function(){
	  $("#teamListModal").modal('hide');  
	});
	
	$("#teamListModal").on('hidden.bs.modal', function (e) {
	  location.reload();
	});
	
	$("#teamListModal .modal-body").on("click", ".updateStatus", function () {
	  var leagueTeamNo = $(this).data("league-team-no");
	   
	  $.ajax({
	    type: "POST",
	    url: "http://localhost:8080/rest/league/updateLeagueTeamStatus",
	    data: { leagueTeamNo: leagueTeamNo },
	    success: function(response) {
	      alert("완료되었습니다.");
	      updateTeamListModal(${leagueDto.leagueNo});
	    },
	    error: function(error) {
	      alert("오류가 발생하였습니다.", error);
	    }
	  }); 
	});


</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>
