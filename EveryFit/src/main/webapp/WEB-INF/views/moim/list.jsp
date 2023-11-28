<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/Header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>

<script>
	window.onscroll = function() {
		scrollRotate();
	};

	function scrollRotate() {
		let image = document.getElementById("addIcon");
		image.style.transform = "rotate(" + window.pageYOffset / 1 + "deg)";
	}
</script>


<script>
$(function() {
let mainFrames = [ {
	opacity : 0.1,
	
	transform : "translate(-500px, -500px)"
}, {
	opacity : 0.2,

	transform : "translate(0px, 0px)"
}, {
	opacity : 0.5,

	transform : "translate(0px, 20px)"
},
{
	opacity : 1,

	transform : "translate(0px, 30px)"
}];
let mainOptions = {
	delay : 0000,
	duration : 1500,
	easing : "ease-in",
	iterations : 1,
	fill : "forwards"
};

document.querySelector("#main-text").animate(mainFrames, mainOptions);

});
</script>





<body>
	<div class="container ">
	
	<div class="container-fluid mb-5" id="main-text">

			<form action="">
				<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
				
					<div class="col">
						모임 명 : <input class="form-control fw-bold text-primary"
							name="moimTitle" value="${adminMoimSearchVO.moimTitle}">
					</div>
					<div class="col">
						인원 : <input class="form-control fw-bold tet-primary"
							name="moimMemberCount"
							value="${adminMoimSearchVO.moimMemberCount}">
					</div>
					<div class="col">
						생성시간 : <input class="form-control fw-bold text-primary"
							type="date" name="moimTimeStart"
							value="${adminMoimSearchVO.moimTimeStart}"> ~ <input
							class="form-control fw-bold text-primary" type="date"
							name="moimTimeEnd" value="${adminMoimSearchVO.moimTimeEnd}">
					</div>

				</div>




				<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">



					<div class="col">
						여성전용 : <select class="form-select col  fw-bold text-primary"
							name="moimGenderCheckList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option class="fw-bold bg-primary text-light">Y</option>
							<option class="fw-bold bg-primary text-light">N</option>
						</select>
					</div>
					<div class="col">
						등급 업그레이드 유무: <select class="form-select col  fw-bold text-primary"
							name="moimUpgradeList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option class="fw-bold bg-primary text-light">Y</option>
							<option class="fw-bold bg-primary text-light">N</option>
						</select>
					</div>
					<div class="col">
						상태: <select class="form-select col  fw-bold text-primary"
							name="moimStateList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option class="fw-bold bg-primary text-light">모집중</option>
							<option class="fw-bold bg-primary text-light">정지</option>
						</select>
					</div>

					<div class="col">
						정렬순서 : <select class="form-select col  fw-bold text-primary"
							name="orderList">
							<option value="">==Select==</option>
							<option value="moim_no asc" class="fw-bold bg-primary text-light">번호(오름차순)</option>
							<option value="moim_no desc"
								class="fw-bold bg-primary text-light">번호(내림차순)</option>
							<option value="moim_title asc"
								class="fw-bold bg-primary text-light">모임 명(오름차순)</option>
							<option value="moim_title desc"
								class="fw-bold bg-primary text-light">모임 명(내림차순)</option>
							<option value="moim_member_count asc"
								class="fw-bold bg-primary text-light">인원(오름차순)</option>
							<option value="moim_member_count desc"
								class="fw-bold bg-primary text-light">인원(내림차순)</option>
							<option value="moim_time asc"
								class="fw-bold bg-primary text-light">생성일(오름차순)</option>
							<option value="moim_time desc"
								class="fw-bold bg-primary text-light">생성일(내림차순)</option>

						</select>
					</div>
					<div class="row mt-3">
						<div
							class="col-2 offset-10 text-center bg-primary rounded-3  text-light p-0">
							<button type="submit" class="text-light bg-primary"
								style="border: 0">
								<h7 class="display-4"> <i
									class="fa-solid fa-magnifying-glass" id="addIcon"></i>
								</h7>
							</button>
						</div>
					</div>
				</div>
		</div>
		</form>
	


		<table class="table table-hover row ms-1">
			<thead>
				<tr class=" table-primary text-center row mt-4">

					<th class="col-2  fw-bold">모임 명</th>
					<th class="col-1  fw-bold">상태</th>
					<th class="col-6  fw-bold">소개글</th>
					<th class="col-1  fw-bold">인원</th>
					<th class="col-2  fw-bold">생성일</th>

				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminMoimList}" var="AdminMoimList">
					<tr class="text-center  row "
						onClick="location.href='${pageContext.request.contextPath}/moim/detail?moimNo=${AdminMoimList.moimNo}'">

						<td class="col-2 text-primary fw-bold">${AdminMoimList.moimTitle}</td>
						<td class="col-1 text-primary fw-bold">${AdminMoimList.moimState}</td>
							<c:choose>
								<c:when test="${AdminMoimList.moimContent.length() >=40}">
									<td class="col-6 text-primary fw-bold">${AdminMoimList.moimContent.substring(0, 40)}...</td>
								</c:when>
								<c:otherwise>
									<td class="col-6 text-primary fw-bold">${AdminMoimList.moimContent}</td>
								</c:otherwise>
							</c:choose>
						
						

						<td class="col-1 text-primary fw-bold">${AdminMoimList.moimMemberCount}</td>
						<td class="col-2 text-primary fw-bold">${AdminMoimList.moimTime}</td>




					</tr>

				</c:forEach>
			</tbody>

		</table>




		


	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>