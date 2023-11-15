<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<style>
.jungmo-image {
	width: 200px;
}
.member-profile {
	width: 50px;
}

</style>

<title>모임 상세페이지</title>

<div class="container-fluid mb-5 pb-5">
	<div class="row">
		<div class="col-md-10 offset-md-1">
			<div class="jumbotron mt-5">
				<h1 class="display-4 bg-primary rounded text-light p-3">${moimDto.moimTitle}</h1>
				<p class="lead">${moimDto.moimContent}</p>
				<hr class="my-4" />
				<p>구현중입니다</p>
					<div class="row mt-4">
						<c:choose>
							<c:when test="${profile == null}">
								<img src="/images/user.png" class="rounded profile-image">
							</c:when>
							<c:otherwise>
								<img src="/rest/attach/download?attachNo=${profile}"
									class="rounded profile-image">
							</c:otherwise>
						</c:choose>

						<!--  라벨을 만들고 파일선택창을 숨김 -->
						<label> <input type="file" class="profile-chooser"
							accept="image/*"> <i class="fa-solid fa-user fa-2x"></i>
						</label> <i class="fa-solid fa-trash-can fa-2x profile-delete"></i> <br>
					</div>
			</div>


			<div class="card border-primary mb-3 items-center" style="max-width: 50rem;">
				<div class="card-body">


		${profile}
		${moimDto}
		<h1>모임 상세(사진, 모임명, 설명)</h1>
		${moimDto.moimNo} ${locationDto.locationDepth1}
		${locationDto.locationDepth2} ${eventDto.eventName}
		
		<h1>회원목록</h1>
		<c:forEach var="moimMemberDto" items="${memberList}">
		<div class="card-body">
		<c:choose>
			<c:when test="${moimMemberDto.attachNo} != null">
			<img src="/rest/attach/download?attachNo=${moimMemberDto.attachNo}">
			</c:when>
			<c:otherwise>
			<img class="member-profile rounded-circle bg-primary" src="/images/user.png">
			</c:otherwise>
		</c:choose>
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
		${moimMemberDto.memberNick}
		${moimMemberDto.memberBlock}
		</div>
	</c:forEach>
			<hr>
				<a class="btn btn-primary" href="jungmo/create?moimNo=${moimDto.moimNo}">정모등록</a>
				<a class="btn btn-primary" href="edit?moimNo=${moimDto.moimNo}">모임수정</a>

			<hr>
			<h1>정모 List</h1>
			<!-- 			<button type="button" class="load-list">목록불러오기</button> -->
			<!-- 			<div class="list-group"></div> -->
			<h3 class="card-header">Card header</h3>
			<c:forEach var="jungmoList" items="${jungmoTotalList}">
				<div class="card mb-3">
					<div class="card-body">
					<div class="col-4">
						<img class="jungmo-image" src="/rest/attach/download?attachNo=${jungmoList.jungmoListVO.jungmoImageAttachNo}">
					</div>
					<div class="col-8">
<%-- 						${jungmoList} --%>
						정모번호 : ${jungmoList.jungmoListVO.jungmoNo}
						정모명 : ${jungmoList.jungmoListVO.jungmoTitle}
						상태 : ${jungmoList.jungmoListVO.jungmoStatus}
						인원 : ${jungmoList.jungmoListVO.memberCount} / ${jungmoList.jungmoListVO.jungmoCapacity}
					
					<a class="btn btn-primary" href="jungmo/join?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light">참가</a>
					<a class="btn btn-warning" href="jungmo/exit?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light">취소</a>
					<a class="btn btn-warning" href="jungmo/cancel?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}" class="text-light">정모취소</a>
                        
                        <div class="row">
                        <div class="col">
                        	<c:forEach var="jungmoMember" items="${jungmoList.jungmoMemberList}">
		                    <div class="card-body">
							<div class="col-4">
                       	 		<c:choose>
                       	 		<c:when test="${jungmoMember.attachNo} != null">
                       	 		<img src="/rest/attach/download?attachNo=${jungmoMember.attachNo}">
                       	 		</c:when>
 								<c:otherwise>
                       	 		<img class="member-profile rounded-circle bg-primary" src="/images/user.png">
 								</c:otherwise>
                       	 		</c:choose>
                       	 		${jungmoMember.memberEmail}      
                   	 		</div>
                  	 		</div>                 	 		
                    		</c:forEach>
                        </div>
                        </div>

					</div>
					</div>
				</div>
			</c:forEach>
		</div>

	</div>
</div>

				</div>
			</div>
<body>
	<c:if test="${param.errorFlag != null}">
	    <script>
	    confirm("오류가발생");
	    </script>
	</c:if>
</body>
<script>

// 	$(document).ready(function () {
// 	    loadJungmoList();
// 	});
	    // 클라이언트 측에서 errorFlag를 확인하여 alert를 띄웁니다.

	var moimNo = "${moimDto.moimNo}";
	$(".profile-chooser").change(function(){

		var input = this;
		if(input.files.length == 0) return;
		
		//ajax로 multipart 업로드
		var form = new FormData();
		form.append("attach", input.files[0]);
		form.append("moimNo", moimNo);
		
		$.ajax({
			url:"http://localhost:8080/rest/attach/upload",
			method:"post",
			processData:false,
			contentType:false,
			data:form,
			success:function(response){
				//응답 형태 - { "attachNo" : 7 }
				//프로필 이미지 교체
				$(".profile-image").attr("src", 
					"/rest/attach/download?attachNo="+response.attachNo);
			},
			error:function(){
				window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
			},
		});
		
	});
	//삭제아이콘을 누르면 프로필이 제거되도록 구현
	$(".profile-delete").click(function() {
		//확인창
		var choice = window.confirm("정말 프로필을 지우시겠습니까?");
		if(choice == false) return;
		
		//삭제요청
		$.ajax({
			url:"http://localhost:8080/rest/attach/delete",
			method:"post",
			data:{moimNo: moimNo},
			success:function(response){
				$(".profile-image").attr("src", "/images/user.png");
			},
		});
	});

	//회원 정모 참여
// 	$(".btn-join").click(function() {
		
// 		var myId = "${sessionScope.name}";
// 		var jungmoNo = parseInt($(this).closest(".card").find(".jungmo-no").text().trim(), 10);
		
// 		$.ajax({
// 			url:"http://localhost:8080/rest/moim/join",
// 			method:"post",
// 			contentType:"application/json",
// 			data: JSON.stringify({
// 				memberEmail:myId,
// 				jungmoNo:jungmoNo
// 			}),
// 			success:function(response) {
// 				alert("참가신청이 완료되었습니다.");
// 			}
// 		});		
// 	});
	
	
    // 정모목록을 로드하는 함수
//     function loadJungmoList() {      
//     	var moimNo = "${moimDto.moimNo}";  	    	
//     	$.ajax({
//             type: 'POST',
//             url: 'http://localhost:8080/rest/moim/list', 
//             data: {moimNo: moimNo},
//             dataType: 'json',
//             success: function (data) {     
// 				$.each(data, function(index, data) { 
// 				    var listItem = $("<a>").addClass("list-group-item list-group-item-action flex-column align-items-start");

// 				    var headerDiv = $("<div>").addClass("d-flex w-100 justify-content-between");
// 				    headerDiv.append("<h5 class='mb-1'>" + data.jungmo_title + "</h5>");
// 				    headerDiv.append("<small class='text-muted'>" + data.jungmo_schedule + "</small>");
					
// 				    var image = $("<img>").attr("src", "/rest/attach/download?attachNo="+data.attach_no).addClass("img-fluid rounded "); // 이미지의 경로나 URL을 지정하세요.
// 				    listItem.append(headerDiv);
// 				    listItem.append(image); // 이미지 추가
				    
// 				    listItem.append(headerDiv);
// 				    listItem.append("<p class='mb-1'>" + data.jungmo_addr + "</p>");
// 				    listItem.append("<small>" + data.jungmo_capacity + "</small>");

// 				    $(".list-group").append(listItem);
// 				});
//             },
//             error: function () {
//                 alert('Jungmo 목록을 로드하는 중 오류가 발생했습니다.');
//             }
//         });
//     }

    // 페이지에 Jungmo 목록을 표시하는 함수
//     function displayJungmoList(jungmoList) {
//         var container = $('.jungmoContainer');
//         container.empty(); 

//         var ul = $('<ul>');

//         $.each(jungmoList, function (index, jungmo) {
//             var li = $('<li>').text(${jungmo.jungmo_title});
//             ul.append(li);
//         });

//         container.append(ul);
//     }

    // 버튼 클릭 시 Jungmo 목록 로드
//    $('.load-list').click(function () {
//        loadJungmoList();
//    });

	
</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>