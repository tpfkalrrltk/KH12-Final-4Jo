<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<div class="row"><div class="col-md-8 offset-md-2">
<div class="row mt-4 text-center"><div class="col">
	<h1>${leagueDto.leagueTitle}</h1>
</div></div>
<div class="row mt-4 text-center">
	<div class="col">
		매니저 : ${leagueDto.leagueManager}
	</div>
</div>
<div class="row mt-4"><div class="col">
	<img src="/league/leagueImage?leagueNo=${leagueDto.leagueNo}">
</div></div>
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
<div class="row mt-4"><div class="col">
	<a href="leagueList" class="btn btn-secondary">목록으로</a>
</div></div>
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
				
				var moimList = response;
				console.log(moimList);

                // 모달을 만들고 목록을 모달에 추가
                var modalContent = '<div id="moim-list-modal" class="modal fade" role="dialog">';
                modalContent += '<div class="modal-dialog">';
                modalContent += '<div class="modal-content">';
                modalContent += '<div class="modal-header">';
                modalContent += '<h4 class="modal-title">모임 선택</h4>';
                modalContent += '</div>';
                modalContent += '<div class="modal-body">';

                // 각 팀에 대한 목록을 모달에 추가
                for (var i = 0; i < moimList.length; i++) {
                	modalContent += '<div class="card border-primary mb-3" style="max-width: 20rem;">';
                	modalContent += '<div class="card-header">' + '모임번호 : '+ moimList[i].moimNo + '</div>';
                    modalContent += '<div class="card-body text-center">';
                    modalContent += '<h4 class="card-title">모임 이름 : ' + moimList[i].moimTitle +'</h4>';
                    if(moimList[i].moimMemberLevel=='모임장'){
                    modalContent += '<a href="leagueTeamInsert?leagueNo=' + ${leagueDto.leagueNo} + '&moimNo=' + moimList[i].moimNo + 
                    				'" class="btn btn-primary">신청</a>';
                    }
                    else{
                    	modalContent += '<button class="btn btn-primary" disabled>모임장만 신청 가능합니다</button>';	
                    }
                    modalContent += '</div></div>';
                }

                modalContent += '</div>';
                modalContent += '<div class="modal-footer">';
                modalContent += '<button type="button" class="btn btn-secondary modal-close">닫기</button>';
                modalContent += '</div>';
                modalContent += '</div>';
                modalContent += '</div>';
                modalContent += '</div>';

                // 모달을 body에 추가
                $('body').append(modalContent);

                // 모달을 보여줌
                $('#moim-list-modal').modal('show');
                $('.modal-close').click(function(){
                	$('#moim-list-modal').modal('hide');
                });
			},
			error:function(error){
				alert("오류발생");
			}
		});
	});
	
});
</script>