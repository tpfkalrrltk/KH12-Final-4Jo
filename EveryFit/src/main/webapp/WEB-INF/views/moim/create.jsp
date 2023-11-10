<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>


<title>등록해보기</title>

<h1>모임등록</h1>
<div class="card border-primary mb-3" style="max-width: 20rem;">

  <div class="card-body">

	<div class="row mt-4">
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
  </div>
</div>


<form method="post" autocomplete="off">
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
	모임명<input type="text" name="moimTitle">
	모임설명<input type="text" name="moimContent">
	<input type="hidden" name="moimMemberCount" value=30>
	성별체크여부<input type="text" name="moimGenderCheck">
	<input type="number" name="chatRoomNo" value=1>
	
	<button type="submit">등록</button>
</form>


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
 </script> 