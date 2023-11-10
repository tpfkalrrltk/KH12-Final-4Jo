<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<title>모임 상세페이지</title>

<div class="m-5 p-5">

  <div class="jumbotron mt-5">
                <h1 class="display-4 bg-primary rounded text-light p-3">모임상세</h1>
                <p class="lead">모임상세/정모등록 페이지입니다</p>
                <hr class="my-4" />
                <p>구현중입니다</p>
            </div>


	<div class="row mv-30">
		<c:choose>
			<c:when test="${profile == null}">
				<img src="/images/user.png" width="150" height="150"
					class="image image-circle image-border profile-image">
			</c:when>
			<c:otherwise>
				<img src="/rest/attach/download?attachNo=${profile}" width="150" height="150"
				class="image image-circle image-border profile-image">
			</c:otherwise>
		</c:choose>
		
		<!--  라벨을 만들고 파일선택창을 숨김 -->
		<label>
		<input type="file" class="profile-chooser" accept="image/*">

		<i class="fa-solid fa-user fa-2x"></i>
		</label>
		<i class="fa-solid fa-trash-can fa-2x profile-delete"></i>
		<br>
	</div>


	<!-- 수정, 정모등록 등 비동기로 구현할 예정임 -->
	<h1>모임 상세(사진, 모임명, 설명)</h1>
	${moimDto.moimNo}
	${locationDto.locationDepth1}
	${locationDto.locationDepth2}
	${eventDto.eventName}
	<h1>회원목록</h1>
	<c:forEach var="moimMemberDto" items="${memberList}" >
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
	</c:forEach>
	<hr>
	<h1>정모등록(modal로 구현 예정)-비동기</h1>
	<div>
		정모명<input type="text" name="jungmoTitle">
		정모명<input type="hidden" name="moimNo" value="${moimDto.moimNo}">
		정모주소<input type="text" name="jungmoAddr">
		링크<input type="text" name="jungmoAddrLink">
		인원<input type="text" name="jungmoCapacity">
		가격<input type="number" name="jungmoPrice">
		일정<input type="datetime-local" name="jungmoSchedule">
		채팅방<input type="number" name="chatRoomNo" value=1>
	<button type="submit" class="save-btn">등록하기</button>
	</div>
	<h1>정모수정(modal로 구현 예정)-비동기</h1>
	
	<hr>
	<h1>정모 List</h1>
	<button type="button" class="load-list">목록불러오기</button>
	<hr>
	
	</div>
	</div>
<script>

	//변경버튼을 누르면 프로필을 업로드하고 이미지 교체
	//파일이 바뀌면 프로필을 업로드하고 이미지 교체
// 	$(".profile-chooser").change(function(){
// 		var input = this;
// 		if(input.files.length == 0) return;
		
// 		//ajax로 multipart 업로드
// 		var form = new FormData();
// 		form.append("attach", input.files[0]);
		
// 		$.ajax({
// 			url:window.contextPath+"/rest/attach/upload",
// 			method:"post",
// 			processData:false,
// 			contentType:false,
// 			data:form,
// 			success:function(response){
// 				//응답 형태 - { "attachNo" : 7 }
// 				//프로필 이미지 교체
// 				$(".profile-image").attr("src", 
// 					"/rest/attach/download?attachNo="+response.attachNo);
// 			},
// 			error:function(){
// 				window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
// 			},
// 		});
		
// 	});
// 	//삭제아이콘을 누르면 프로필이 제거되도록 구현
// 	$(".profile-delete").click(function() {
// 		//확인창
// 		var choice = window.confirm("정말 프로필을 지우시겠습니까?");
// 		if(choice == false) return;
		
// 		//삭제요청
// 		$.ajax({
// 			url:window.contextPath+"/rest/attach/delete",
// 			method:"post",
// 			success:function(response){
// 				$(".profile-image").attr("src", "/images/user.png");
// 			},
// 		});
// 	});
	
	$(".save-btn").click(function() {
        // 입력된 데이터를 JavaScript 객체로 구성
        var requestData = {
            jungmoTitle: $("input[name='jungmoTitle']").val(),
            moimNo: $("input[name='moimNo']").val(),
            jungmoAddr: $("input[name='jungmoAddr']").val(),
            jungmoAddrLink: $("input[name='jungmoAddrLink']").val(),
            jungmoCapacity: $("input[name='jungmoCapacity']").val(),
            jungmoPrice: $("input[name='jungmoPrice']").val(),
            jungmoSchedule: $("input[name='jungmoSchedule']").val()
//             chatRoomNo: $("input[name='chatRoomNo']").val()
            // 다른 필드도 필요한 경우 추가 가능
        };

        // AJAX 요청 보내기
        $.ajax({
            url: "http://localhost:8080/rest/moim/create", // 서버의 엔드포인트 URL
            type: "POST", // HTTP 요청 메서드 (POST를 사용)
            data: JSON.stringify(requestData), // JavaScript 객체를 JSON 문자열로 변환하여 전송
            contentType: "application/json", // 전송 데이터 타입
            success: function(response) {
 				console.log(response);
            },
            error: function(error) {
                window.alert("저장 중 오류가 발생했습니다.");
            }
        });
    });
	
	
    // 정모목록을 로드하는 함수
    function loadJungmoList() {
        
    	var moimNo = ${moimDto.moimNo};
    	
    	console.log(moimNo);
    	
    	$.ajax({
            type: 'POST',
            url: 'http://localhost:8080/rest/moim/list', 
            data: {moimNo: moimNo},
            dataType: 'json',
            success: function (data) {
                displayJungmoList(data);
            },
            error: function () {
                alert('Jungmo 목록을 로드하는 중 오류가 발생했습니다.');
            }
        });
    }

    // 페이지에 Jungmo 목록을 표시하는 함수
    function displayJungmoList(jungmoList) {
        var container = $('.jungmoContainer');
        container.empty(); // 새 항목을 추가하기 전에 컨테이너를 지웁니다

        var ul = $('<ul>');

        $.each(jungmoList, function (index, jungmo) {
            var li = $('<li>').text('제목: ' + jungmo.jungmoTitle + ', 주소: ' + jungmo.jungmoAddr);
            ul.append(li);
        });

        container.append(ul);
    }

    // 버튼 클릭 시 Jungmo 목록 로드
   $('.load-list').click(function () {
       loadJungmoList();
   });

	

</script>
	