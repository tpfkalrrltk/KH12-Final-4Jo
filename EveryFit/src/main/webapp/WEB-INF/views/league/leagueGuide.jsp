<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="row mt-4 text-center"><div class="col">
	<h1>${leagueDto.leagueTitle}</h1>
</div></div>
<div class="row mt-4 text-center">
	<div class="col">
		매니저 : ${leagueDto.leagueManager}
	</div>
	<div class="col">
		
	</div>
</div>
<div class="row mt-4"><div class="col">
	${leagueDto.leagueDetail}       
</div></div>
<div class="row mt-4">
	<div class="col">
		<a class="btn btn-secondary" href="leagueEdit?leagueNo=${leagueDto.leagueNo}">수정</a>
	</div>
	<div class="col">
		<a class="btn btn-danger" href="leagueDelete?leagueNo=${leagueDto.leagueNo}">삭제</a>
	</div>        
</div>
<div class="row mt-4"><div class="col">
	<a class="btn btn-primary" id="enter-btn">리그참여</a>
</div></div>

<script>
$(function(){
	$("#enter-btn").click(function(){
		var leagueNo = ${leagueDto.leagueNo};
		$.ajax({
			url:"http://localhost:8080/rest/league/checkMoim",
			method:"post",
			data:{leagueNo:leagueNo},
			success:function(response){
				console.log(response);
				alert("성공");
			},
			error:function(error){
				alert("오류발생");
			}
		});
	});
	
});
</script>