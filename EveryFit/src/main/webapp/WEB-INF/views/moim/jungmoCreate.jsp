<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

			<div class="card border-primary mb-3" style="max-width: 20rem;">


<div class="container-fluid mt-4">
	<div class="row mt-4">
		<div class="col-10 offset-1">
			<h1>정모등록</h1>
			<div>
				<form method="post" autocomplete="off" enctype="multipart/form-data" >
				
					<input type="file" class="profile-chooser" 
					name="attach" 
					accept="image/*" multiple>
					정모명<input type="text" name="jungmoTitle"> 
					<input type="hidden" name="moimNo" >
					정모주소<input type="text" name="jungmoAddr"> 링크<input
						type="text" name="jungmoAddrLink"> 인원<input type="text"
						name="jungmoCapacity"> 가격<input type="number"
						name="jungmoPrice"> 일정<input type="datetime-local"
						name="jungmoDto.jungmoScheduleStr">채팅방<input type="number"
						name="chatRoomNo" value=1>
					<button type="submit" class="save-btn">등록하기</button>
				</form>
			</div>
		</div>
	</div>
</div>

<script>

	//현재 페이지의 URL 가져오기
	var currentUrl = location.search;
	var moimNo = currentUrl.replace(/\D/g, '');

    $('input[name="moimNo"]').val(moimNo);

console.log(moimNo);

</script>