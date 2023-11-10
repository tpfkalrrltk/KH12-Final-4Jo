<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>


<div class="row mt-4">
	<h1>안보임</h1>
</div>
<div class="container-fluid mt-4">
	<div class="row mt-4">
		<div class="col-10 offset-1">
			<h1>정모등록</h1>
			<div>
				<form method="post" autocomplete="off">
					정모명<input type="text" name="jungmoTitle"> 
					<input type="hidden" name="moimNo" value=1>
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
// var currentUrl = location.search;

// URLSearchParams 객체 생성
// var urlParams = new URLSearchParams(currentUrl);

// 원하는 파라미터 값 가져오기
// $('input[name="moimNo"]').val(moimNo);
// 가져온 값 확인 (콘솔에 출력)
console.log(moimNo);

</script>