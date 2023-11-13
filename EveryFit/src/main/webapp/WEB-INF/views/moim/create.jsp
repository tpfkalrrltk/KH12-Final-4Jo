<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>


<title>등록해보기</title>

<c:choose>
	<c:when test="${moimDto != null}">
		<h1>모임수정</h1>
	</c:when>
	<c:otherwise>
		<h1>모임등록</h1>
	</c:otherwise>
</c:choose>
<div class="container-fluid col-8 offset-2">
<div class="row mt-4">
<div class="card border-primary mb-3" style="max-width: 100rem;">

<div class="row mt-4">
	<c:if test="${profile != null}">
	<img src="/rest/attach/download?attachNo=${profile}"
			class="rounded profile-image">		
	</c:if>
<!--  라벨을 만들고 파일선택창을 숨김 -->
<form method="post" enctype="multipart/form-data" autocomplete="off">
	<div class="row mt-4">
		<label>
		<input type="file" class="profile-chooser" 
		name="attach" 
		accept="image/*" multiple>

		<i class="fa-solid fa-user fa-2x"></i>
		</label>
		<i class="fa-solid fa-trash-can fa-2x profile-delete"></i>
		<br>
	</div>

     지역
	<select name="locationNo">
	    <c:forEach var="location" items="${locationList}">
	        <option value="${location.locationNo}">
	            ${location.locationDepth1} - ${location.locationDepth2}
	        </option>
	    </c:forEach>
	</select>
	
     <br>
     종목 
     <select name="eventNo">
         <c:forEach var="event" items="${eventList}">
             <option value="${event.eventNo}">${event.eventName}</option>
         </c:forEach>
     </select>
	모임명<input type="text" name="moimTitle" placeholder="${moimDto.moimTitle}">
	모임설명<input type="text" name="moimContent" placeholder="${moimDto.moimContent}">
	<input type="hidden" name="moimMemberCount" value=30>
	
	여성전용 <input type="checkbox" name="moimGenderCheck">
	<input type="hidden" name="chatRoomNo" value="${moimDto.chatRoomNo}">
	<button type="submit">등록</button>
</form>
</div>
</div>
</div>
</div>


<script>
// //변경버튼을 누르면 프로필을 업로드하고 이미지 교체
// //파일이 바뀌면 프로필을 업로드하고 이미지 교체
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

	$("[name=locationDepth1]").change(function(e){
		var locationDepth1 = e.target.value;
		console.log(locationDepth1)
		$.ajax({
			url:"http://localhost:8080/rest/location/depth2List",
			type:"post",
			data:{locationDepth1:locationDepth1},
			success:function (data){
				var select = $("[name=locationDepth2]");
				
				select.empty();
				select.append('<option value="">구/시 선택</option>');
				$.each(data, function(index, locationDto){
					var depth2Value = locationDto.locationDepth2;
					select.append('<option value="' + depth2Value + '">' + depth2Value + '</option>');
				console.log(depth2Value);
				});
			},
			error:function(){
				alert('주소 로딩중 서버 에러 발생');
			}
		});
	});
	
	$("[name=moimGenderCheck]").click(function(e){
	    var isChecked = $(this).prop("checked");

	    // 체크박스를 클릭하여 선택되었다면
	    if (isChecked) {
	        $(this).val(1);
	    } else {
	    	$(this).val(2);
	    }
	});
 </script> 