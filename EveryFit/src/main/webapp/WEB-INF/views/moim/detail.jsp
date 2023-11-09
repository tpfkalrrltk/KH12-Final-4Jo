<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 상세페이지</title>
</head>

<script>
$(function(){
	//변경버튼을 누르면 프로필을 업로드하고 이미지 교체
	//파일이 바뀌면 프로필을 업로드하고 이미지 교체
	$(".profile-chooser").change(function(){
		//선택된 파일이 있는지 확인하고 없으면 중단
// 		var input = document.querySelector(".profile-chooser");
		var input = this;
		if(input.files.length == 0) return;
		
		//ajax로 multipart 업로드
		var form = new FormData();
		form.append("attach", input.files[0]);
		
		$.ajax({
			url:window.contextPath+"/rest/member/upload",
			method:"post",
			processData:false,
			contentType:false,
			data:form,
			success:function(response){
				//응답 형태 - { "attachNo" : 7 }
				//프로필 이미지 교체
				$(".profile-image").attr("src", 
					"/rest/member/download?attachNo="+response.attachNo);
			},
			error:function(){
				window.alert("통신 오류 발생\n잠시 후 다시 시도해주세요");
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
			url:window.contextPath+"/rest/member/delete",
			method:"post",
			success:function(response){
				$(".profile-image").attr("src", "/images/user.png");
			},
		});
	});
	
});
</script>

<body>
	<div class="row mv-30">
		<c:choose>
			<c:when test="${profile == null}">
				<img src="/images/user.png" width="150" height="150"
					class="image image-circle image-border profile-image">
			</c:when>
			<c:otherwise>
				<img src="/rest/member/download?attachNo=${profile}" width="150" height="150"
				class="image image-circle image-border profile-image">
			</c:otherwise>
		</c:choose>
		
		<!--  라벨을 만들고 파일선택창을 숨김 -->
<!-- 		<label> -->
		<input type="file" class="profile-chooser" accept="image/*">

		<i class="fa-solid fa-user fa-2x"></i>
<!-- 		</label> -->
		<i class="fa-solid fa-trash-can fa-2x profile-delete"></i>
		<br>
	</div>


	<!-- 수정, 정모등록 등 비동기로 구현할 예정임 -->
	<h1>모임 상세(사진, 모임명, 설명)</h1>
	${moimDto}
	<h1>회원목록</h1>
	<c:forEach var="moimMemberDto" items="${memberList}" >
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
	</c:forEach>
	<hr>
	<h1>정모등록(modal로 구현 예정)-비동기</h1>
	<div>
		정모번호는 어떻게 넣음?
		정모명<input type="text" name="jungmoTitle">
		<input type="text" name="jungmoAddr">
		<input type="text" name="jungmoAddrLink">
		<input type="text" name="jungmoCapacity">
		<input type="number" name="jungmoPrice">
		<input type="datetime-local" name="jungmoSchedule">
		<input type="text" name="jungmoStatus">
		채팅방번호는 어떻게 넣음?
	</div>
	<h1>정모수정(modal로 구현 예정)-비동기</h1>
	<div>
		<input type="text" name="jungmoNo">
		<input type="text" name="jungmoTitle">
		<input type="text" name="jungmoAddr">
		<input type="text" name="jungmoAddrLink">
		<input type="text" name="jungmoCapacity">
		<input type="number" name="jungmoPrice">
		<input type="datetime-local" name="jungmoSchedule">
		<input type="text" name="jungmoStatus">
		<a href="#">xx채팅방으로 보내기</a>
	</div>
	
	<hr>
	<h1>정모 List</h1>
	<hr>
	
</body>
</html>