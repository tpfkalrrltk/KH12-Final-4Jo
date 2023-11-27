<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<h1 class="display-5 fw-bold">항소 목록</h1>

			</div>
		</div>



		<div class="container-fluid">

			<form action="">
				<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
					<div class="col">
						번호 : <input class="form-control fw-bold text-primary"
							name="appealNo" value="${AdminAppealSearchVO.appealNo}">
					</div>
						<div class="col">
						아이디 : <input class="form-control fw-bold text-primary"
							name="memberEmail" value="${AdminAppealSearchVO.memberEmail}">
					</div>

					<div class="col">
						제목 : <input class="form-control fw-bold text-primary"
							name="appealReason" value="${AdminAppealSearchVO.appealReason}">
					</div>

					<div class="col">
						항소날짜 : <input class="form-control fw-bold text-primary"
							type="date" name="appealTimeStart"
							value="${AdminAppealSearchVO.appealTimeStart}"> ~ <input
							class="form-control fw-bold text-primary" type="date"
							name="appealTimeEnd" value="${AdminAppealSearchVO.appealTimeEnd}">
					</div>

				</div>




				<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">



					<div class="col">
						신고 사유 : <select class="form-select col  fw-bold text-primary"
							name="appealCategoryList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option class="fw-bold bg-primary text-light">회원</option>
							<option class="fw-bold bg-primary text-light">모임</option>
							<option class="fw-bold bg-primary text-light">댓글</option>
							<option class="fw-bold bg-primary text-light">정모</option>
							<option class="fw-bold bg-primary text-light">게시글</option>
						</select>
					</div>



					<div class="col">
						정렬순서 : <select class="form-select col  fw-bold text-primary"
							name="orderList">
							<option value="" class="fw-bold bg-primary text-light">==Select==</option>
							<option value="appeal_no asc"
								class="fw-bold bg-primary text-light">번호(오름차순)</option>
							<option value="appeal_no desc"
								class="fw-bold bg-primary text-light">번호(내림차순)</option>
							<option value="appeal_reason asc"
								class="fw-bold bg-primary text-light">항소사유(오름차순)</option>
							<option value="appeal_reason desc"
								class="fw-bold bg-primary text-light">항소사유(내림차순)</option>
							<option value="appeal_time asc"
								class="fw-bold bg-primary text-light">항소시간(오름차순)</option>
							<option value="appeal_time desc"
								class="fw-bold bg-primary text-light">항소시간(내림차순)</option>

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
					<th class="col-1  fw-bold">번호</th>
					<th class="col-3  fw-bold">항소 사유</th>
					<th class="col-2  fw-bold">항소 아이디</th>
					<th class="col-3  fw-bold">항소 제목</th>
					<th class="col-3  fw-bold">항소 시간</th>


				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminAppealList}" var="adminAppealList">
					<tr class="text-center table- row"
						onClick="location.href='${pageContext.request.contextPath}/appeal/detail?appealNo=${adminAppealList.appealNo}'"
						style="cursor: pointer;">
						<td class="col-1 text-primary fw-bold">
							${adminAppealList.appealNo}</td>
						<td class="col-3  text-primary fw-bold">${adminAppealList.appealCategory}</td>
						<td class="col-2  text-primary fw-bold">${adminAppealList.memberEmail}</td>
						<td class="col-3  text-primary fw-bold">${adminAppealList.appealReason}</td>
						<td class="col-3  text-primary fw-bold">${adminAppealList.appealTime}
							<fmt:formatDate value="${adminAppealList.appealTime}"
								pattern="a h:mm" type="date" />
						</td>

					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>