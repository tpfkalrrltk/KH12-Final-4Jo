<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/adminHeader.jsp"></jsp:include>
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





<body>
	<div class="container ">

		<div class="row mt-5 p-5">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">모임 관리</h1>

			</div>
		</div>



		<div class="container-fluid">

			<form action="">
				<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
					<div class="col">
						번호 : <input class="form-control fw-bold text-primary"
							name="moimNo" value="${adminMoimSearchVO.moimNo}">
					</div>
					<div class="col">
						모임 명 : <input class="form-control fw-bold text-primary"
							name="moimTitle" value="${adminMoimSearchVO.moimTitle}">
					</div>
					<div class="col">
						인원 : <input class="form-control fw-bold text-primary"
							name="moimMemberCount" value="${adminMoimSearchVO.moimMemberCount}">
					</div>
					<div class="col">
						생성시간 : <input class="form-control fw-bold text-primary"
							type="date" name="moimTimeStart"
							value="${adminMoimSearchVO.moimTimeStart}"> ~ <input
							class="form-control fw-bold text-primary" type="date"
							name="moimTimeEnd"
							value="${adminMoimSearchVO.moimTimeEnd}">
					</div>

				</div>




				<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">



					<div class="col">
						여성전용 : <select class="form-select col  fw-bold text-primary"
							name="moimGenderCheckList">
							<option value="">==Select==</option>
							<option>Y</option>
							<option>N</option>
						</select>
					</div>
					<div class="col">
						등급 업그레이드 유무: <select class="form-select col  fw-bold text-primary"
							name="moimUpgradeList">
							<option value="">==Select==</option>
							<option>Y</option>
							<option>N</option>
						</select>
					</div>
					<div class="col">
						상태: <select class="form-select col  fw-bold text-primary"
							name="moimStateList">
							<option value="">==Select==</option>
							<option>모집중</option>
							<option>정지</option>
						</select>
					</div>
					
					<div class="col">
						정렬순서 : <select class="form-select col  fw-bold text-primary"
							name="orderList">
							<option value="">==Select==</option>
							<option value="moim_no asc">번호(오름차순)</option>
							<option value="moim_no desc">번호(내림차순)</option>
							<option value="moim_title asc">모임 명(오름차순)</option>
							<option value="moim_title desc">모임 명(내림차순)</option>
							<option value="moim_member_count asc">인원(오름차순)</option>
							<option value="moim_member_count desc">인원(내림차순)</option>
							<option value="moim_time asc">생성일(오름차순)</option>
							<option value="moim_time desc">생성일(내림차순)</option>

						</select>
					</div>
					<div class="row mt-3">
						<div
							class="col-2 offset-10 text-center bg-primary rounded-3  text-light p-0">
							<button type="submit" class="text-light bg-primary"
								style="border: 0">
								<h7 class="display-4"> <i
									class="fa-solid fa-magnifying-glass fa-flip " id="addIcon"></i>
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
					<th class="col-2  fw-bold">번호</th>
					<th class="col-2  fw-bold">모임 명</th>
					<th class="col-2  fw-bold">상태</th>
					<th class="col-1  fw-bold">여성전용</th>
					<th class="col-2  fw-bold">인원</th>
					<th class="col-2  fw-bold">생성일</th>
					<th class="col-1  fw-bold">등급 유무</th>
				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminMoimList}" var="AdminMoimList">
					<tr class="text-center table- row">
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/moim/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">
								${AdminMoimList.moimNo}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimTitle}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimState}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimGenderCheck}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimMemberCount}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimTime}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMoimList.moimNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMoimList.moimUpgrade}</a></td>


					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>