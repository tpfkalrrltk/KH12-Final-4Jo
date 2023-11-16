<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>   
<div class="row"><div class="col-md-8 offset-md-1">

<div class="row"><div class="col">
	<h1>리그참여신청</h1>
</div></div>

<form method="post">
<input type="hidden" name="leagueNo" value="${param.leagueNo}">
<input type="hidden" name="moimNo" value="${param.moimNo}">
<div class="row"><div class="col">
	<lable class="form-label">팀이름</lable>
	<input type="text" class="form-control" name="leagueTeamName">
</div></div>
<div class="row"><div class="col">
	<c:forEach var="memberDto" items="${memberList}">
		<div class="form-check">
		<input class="form-check-input" id="flexCheckChecked" type="checkbox" name="memberEmail" 
			value="${memberDto.memberEmail}" onchange="updateCheckedCount()">
		<label class="form-check-label" for="flexCheckChecked">
          ${memberDto.memberEmail}
        </label> 
		</div>		
	</c:forEach>
</div></div>
<div class="row"><div class="col">
	<label id="checkedCount">0</label> / <label id="roasterCount">${leagueDto.leagueRoasterCount}</label>
</div></div>
<div class="row mt-2"><div class="col">
	<button id="button-add" type="submit" class="btn btn-primary" disabled>로스터 등록 및 참가신청</button>
</div></div>
</form>


</div></div>



<script>
    function updateCheckedCount() {
        // 이름이 "memberEmail"인 모든 체크박스 가져오기
        var checkboxes = document.querySelectorAll('input[name="memberEmail"]:checked');
		var roasterCount = ${leagueDto.leagueRoasterCount};
        var count = checkboxes.length;
		
        if (count === roasterCount) {
            // 버튼 활성화
            $('#button-add').prop('disabled', false);
        } else {
            // 버튼 비활성화
            $('#button-add').prop('disabled', true);
        }
        // 라벨에서 개수 업데이트
        document.getElementById('checkedCount').innerText = count;
    }
</script>



<%@ include file="/WEB-INF/views/template/Footer.jsp"%> 