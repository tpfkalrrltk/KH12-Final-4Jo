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
				<h1 class="display-5 fw-bold">정모 관리</h1>

			</div>
		</div>



		<div class="container-fluid">

			<form action="">
				<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
					<div class="col">
						정모 번호 : <input class="form-control fw-bold text-primary"
							name="jungmoNo" value="${adminJungmoSearchVO.jungmoNo}">
					</div>
					<div class="col">
						모임 번호 : <input class="form-control fw-bold text-primary"
							name="moimNo" value="${adminJungmoSearchVO.moimNo}">
					</div>
					<div class="col">
						모임 이름 : <input class="form-control fw-bold text-primary"
							name="jungmoTitle" value="${adminJungmoSearchVO.jungmoTitle}">
					</div>
					<div class="col">
						모임 정원 : <input class="form-control fw-bold text-primary"
							name="jungmoCapacity"
							value="${adminJungmoSearchVO.jungmoCapacity}">
					</div>
					<div class="col">
						회비 : <input class="form-control fw-bold text-primary"
							name="jungmoPrice" value="${adminJungmoSearchVO.jungmoPrice}">
					</div>
					<div class="col">
						생성시간 : <input class="form-control fw-bold text-primary"
							type="date" name="jungmoScheduleStart"
							value="${adminJungmoSearchVO.jungmoScheduleStart}"> ~ <input
							class="form-control fw-bold text-primary" type="date"
							name="jungmoScheduleEnd"
							value="${adminJungmoSearchVO.jungmoScheduleEnd}">
					</div>

				</div>




				<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">





					<div class="col">
						상태: <select class="form-select col  fw-bold text-primary"
							name="jungmoStateList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option class="fw-bold bg-primary text-light">모집중</option>
							<option class="fw-bold bg-primary text-light">취소</option>
						</select>
					</div>

					<div class="col">
						정렬순서 : <select class="form-select col  fw-bold text-primary"
							name="orderList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option value="jungmo_no asc" class="fw-bold bg-primary text-light">정모 번호(오름차순)</option>
							<option value="jungmo_no desc" class="fw-bold bg-primary text-light">정모 번호(내림차순)</option>
							<option value="moim_no asc" class="fw-bold bg-primary text-light">모임 번호(오름차순)</option>
							<option value="moim_no desc" class="fw-bold bg-primary text-light">모임 번호(내림차순)</option>
							<option value="jungmo_title asc" class="fw-bold bg-primary text-light">정모 이름(오름차순)</option>
							<option value="jungmo_title desc" class="fw-bold bg-primary text-light">정모 이름(내림차순)</option>
							<option value="jungmo_capacity asc" class="fw-bold bg-primary text-light">정모 정원(오름차순)</option>
							<option value="jungmo_capacity desc" class="fw-bold bg-primary text-light">정모 정원(내림차순)</option>
							<option value="jungmo_price asc" class="fw-bold bg-primary text-light">정모 회비(오름차순)</option>
							<option value="jungmo_price desc" class="fw-bold bg-primary text-light">정모 회비(내림차순)</option>

							<option value="jungmo_schedule asc" class="fw-bold bg-primary text-light">생성일(오름차순)</option>
							<option value="jungmo_schedule desc" class="fw-bold bg-primary text-light">생성일(내림차순)</option>

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
					<th class="col-1 fw-bold">정모번호</th>
					<th class="col-1  fw-bold">모임번호</th>
					<th class="col-2  fw-bold">정모 이름</th>
					<th class="col-1  fw-bold">정원</th>
					<th class="col-2  fw-bold">상태</th>
					<th class="col-2  fw-bold">생성시간</th>
					<th class="col-2  fw-bold">회비</th>
					<th class="col-1  fw-bold">닉네임</th>
				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminJungmoList}" var="AdminJungmoList">
					<tr class="text-center table- row">
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">
								${AdminJungmoList.jungmoNo}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.moimNo}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.jungmoTitle}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.jungmoCapacity}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.jungmoStatus}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/jungmo/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.jungmoSchedule}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.jungmoPrice}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/member/detail?jungmoNo=${AdminJungmoList.jungmoNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminJungmoList.memberNick}</a></td>


					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>