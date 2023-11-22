<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="row">
  <div class="col-md-8 offset-md-2">
    <div class="row">
      <div class="col">
        <h1>${leagueDto.leagueTitle} 상세</h1>
      </div>
    </div>
    <hr>
    <div class="row text-end">
      <div class="col p-1">
        <button type="button" class="btn btn-primary" id="loadLeagueTeamList">신청팀 관리</button>
        <a class="btn btn-secondary" href="leagueMatch?leagueNo=${leagueDto.leagueNo}">경기일정관리</a>
      </div>
    </div>
    <div class="row mt-4">
      <div class="col">
        <h3>리그 순위</h3>
      </div>
    </div>
    
    <div class="row">
      <div class="col">
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
                <td>
                	<div>
                	${vo.leagueTeamName}
                		<img class="rounded" src="/image?moimNo=${vo.moimNo}" height="30" width="30">
	               	</div>
                </td>
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
      </div>
    </div>
  </div>
</div>

<!-- 미승인 팀목록 모달 -->
<div class="modal" id="teamListModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">팀목록</h4>
      </div>
      <div class="modal-body">
        
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
  updateTeamListAndModal(leagueNo);
});

function updateTeamListAndModal(leagueNo) {
  loadLeagueTeamList(leagueNo, function (response) {
    $("#teamListModal .modal-body").empty();

    // 받아온 리스트를 모달 내용에 추가
    $.each(response, function (index, leagueTeamDto) {
      // 리스트 항목을 생성하고 추가
      var listItem = $("<p>").text(
        "팀 번호: " +
        leagueTeamDto.leagueTeamNo +
        ", 팀 이름: " +
        leagueTeamDto.leagueTeamName +
        ", 모임 번호: " +
        leagueTeamDto.moimNo +
        ", 팀 상태: " +
        leagueTeamDto.leagueTeamStatus
      );
      var approveButton = $("<button>")
        .text(leagueTeamDto.leagueTeamStatus === 'N' ? "승인" : "승인취소")
        .addClass("updateStatus")
        .data("league-team-no", leagueTeamDto.leagueTeamNo);
      

      listItem.append(approveButton);
      $("#teamListModal .modal-body").append(listItem);
    });
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
      alert("업데이트 성공");
      updateTeamListAndModal(${leagueDto.leagueNo});
    },
    error: function(error) {
      alert("업데이트 실패", error);
    }
  }); 
});


</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>
