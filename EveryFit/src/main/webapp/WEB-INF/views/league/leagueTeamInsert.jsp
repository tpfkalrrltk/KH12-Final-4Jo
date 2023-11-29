<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>   

<div class="container-fluid">
	<div class="row"><div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2">
	
		<div class="p-5 bg-primary text-light rounded">
			<h1>리그참가신청 <i class="fa-solid fa-right-to-bracket"></i></h1>
			<hr>
			<span>${leagueDto.leagueTitle}</span>
			<div class="row text-end">
				<div class="col">
					<a href="${pageContext.request.contextPath}/league/leagueGuide?leagueNo=${leagueDto.leagueNo}" class="btn btn-outline-success bg-light">돌아가기</a>
				</div>
			</div>
		</div>
		
		<div class="preview-wrapper col-4 offset-4 mt-5">
			<img id="preview" class="w-100 rounded">
		</div>

		<div class="row mt-5"><div class="col">
			<form method="post" id="insertLeaueTeamForm" enctype="multipart/form-data">
				<input type="hidden" name="leagueNo" value="${param.leagueNo}">
				<input type="hidden" name="moimNo" value="${param.moimNo}">
				
				<div class="row mt-2"><div class="col">
					<label class="form-label">로고 이미지</label>
					<input type="file" accept="image/*" class="form-control" name="attach" onchange="checkForm()">
				</div></div>
				
				<div class="row"><div class="col">
					<label class="form-label">팀이름</label>
					<input type="text" class="form-control" name="leagueTeamName" onchange="checkForm()"
						placeholder="한글, 영어, 숫자 3~10글자">
				</div></div>
				
				<div class="row mt-4 text-center"><div class="col">
					<c:forEach var="memberDto" items="${memberList}">
						<div class="input-group">
							<div class="input-group-text">
								<input class="form-check-input" id="${memberDto.memberEmail}" type="checkbox" name="memberEmail" 
									value="${memberDto.memberEmail}" onchange="checkForm()">
							</div>
						<label class="form-control" for="${memberDto.memberEmail}">
				        	${memberDto.memberNick} - [ ${memberDto.memberEmail} ]
				        </label> 
						</div>		
					</c:forEach>
				</div></div>
				<div class="row mt-4 text-end me-5"><div class="col">
					<label id="checkedCount">0</label> / <label id="roasterCount">${leagueDto.leagueRoasterCount}명</label>
				</div></div>
				<div class="row mt-4"><div class="col">
					<button id="button-add" type="submit" class="btn btn-primary w-100" disabled>로스터 등록 및 참가신청</button>
				</div></div>
			</form>
		</div></div>

</div></div>


</div>
<script>
	checkForm();
    function checkForm() {
        // 이름이 "memberEmail"인 모든 체크박스 가져오기
        var checkboxes = document.querySelectorAll('input[name="memberEmail"]:checked');
		var roasterCount = ${leagueDto.leagueRoasterCount};
        var count = checkboxes.length;
        
        //팀이름 제약조건
        var pattern = /^[a-zA-Z가-힣0-9\s]{3,10}$/;
        var teamName = $("[name=leagueTeamName]").val();
        var checkLeagueTeam = pattern.test(teamName) && teamName.length > 0;
        
        var attachCheck = $("[name=attach]").val().length > 0;
        
        if(checkLeagueTeam){
        	$("[name=leagueTeamName]").addClass("is-valid");
        }
        else{
        	$("[name=leagueTeamName]").removeClass("is-valid");
        }
        
        if (count === roasterCount && checkLeagueTeam && attachCheck) {
            // 버튼 활성화
            $('#button-add').prop('disabled', false);
        } else {
            // 버튼 비활성화
            $('#button-add').prop('disabled', true);
        }
        // 라벨에서 개수 업데이트
        document.getElementById('checkedCount').innerText = count;
    }
    
    $("#button-add").click(function(e){
    	var leagueNo = ${leagueDto.leagueNo};
    	var moimNo = ${moimNo};
    	
    	e.preventDefault();
    	
    	$.ajax({
    		url:window.contextPath + "/rest/league/isTeamRegistered",
			method:"post",
			data:{leagueNo:leagueNo, moimNo:moimNo},
			success:function(response){
			
				if(response!='legal'){
					alert("이미 참가한 모임입니다.");
			    	return;
				}
				else{
					alert("등록되었습니다.");
					$("#insertLeaueTeamForm").submit();
				}
			},
			error:function(error){
				
				alert("오류가 발생되었습니다. 잠시후 다시 시도해주세요.");
				return;
			}
    	});
    });
    	
	$("[name=attach]").change(function(e){
		
		$(".preview-wrapper").empty();
		
		if (this.files && this.files[0]) {
        	var reader = new FileReader();
	
           	// 파일을 읽고 로드되면 미리보기 이미지 업데이트
           	reader.onload = function (e) {
           		$("<img>").attr("id", "preview").attr("src", e.target.result)
           		.addClass("w-100 rounded").appendTo(".preview-wrapper");
           	}
	
           	// 파일 읽기 시작
           	reader.readAsDataURL(this.files[0]);
       	}
	});
	
	$("[name='memberEmail']").change(function(e){
		var memberEmail = $(this).val();
		var leagueNo = $("[name='leagueNo']").val();
		var checkbox = $(this);
		
		$.ajax({
			url:window.contextPath + "/rest/league/checkLeagueRoaster",
			method:"post",
			data:{leagueNo:leagueNo, memberEmail:memberEmail},
			success:function(response){
				if(response==false){
					alert("이미 리그에 등록된 회원입니다.");
					checkbox.prop('checked', false);
					return;
				}
			},
			error:function(err){
		
			},
		});
	});
    	
   
</script>



<%@ include file="/WEB-INF/views/template/Footer.jsp"%> 