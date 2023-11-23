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
				<h1 class="display-5 fw-bold">신고 목록</h1>

			</div>
		</div>



		<div class="container-fluid">

			<form action="">
				<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
					<div class="col">
						번호 : <input class="form-control fw-bold text-primary"
							name="reportNo" value="${adminReportSearchVO.reportNo}">
					</div>
					
					<div class="col">
						제목 : <input class="form-control fw-bold text-primary"
							name="reportReason" value="${adminReportSearchVO.reportReason}">
					</div>

					<div class="col">
						신고날짜 : <input class="form-control fw-bold text-primary"
							type="date" name="reportTimeStart"
							value="${adminReportSearchVO.reportTimeStart}"> ~ <input
							class="form-control fw-bold text-primary" type="date"
							name="reportTimeEnd" value="${adminReportSearchVO.reportTimeEnd}">
					</div>

				</div>




				<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">



					<div class="col">
						신고 사유 : <select class="form-select col  fw-bold text-primary"
							name="reportCategoryList">
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
							<option value="report_no asc" class="fw-bold bg-primary text-light">번호(오름차순)</option>
							<option value="report_no desc" class="fw-bold bg-primary text-light">번호(내림차순)</option>
							<option value="report_reason asc" class="fw-bold bg-primary text-light">신고사유(오름차순)</option>
							<option value="report_reason desc" class="fw-bold bg-primary text-light">신고사유(내림차순)</option>
							<option value="report_time asc" class="fw-bold bg-primary text-light">신고시간(오름차순)</option>
							<option value="report_time desc" class="fw-bold bg-primary text-light">신고시간(내림차순)</option>

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
					<th class="col-3  fw-bold">신고 사유</th>
					<th class="col-5  fw-bold">신고 제목</th>
					<th class="col-3  fw-bold">신고 시간</th>


				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminReportList}" var="AdminReportList">
					<tr class="text-center table- row"
					 onClick="location.href='${pageContext.request.contextPath}/admin/report/detail?reportNo=${AdminReportList.reportNo}'"
						style="cursor: pointer;" >
						<td class="col-1 text-primary fw-bold">
								${AdminReportList.reportNo}</td>
						<td class="col-3  text-primary fw-bold">${AdminReportList.reportCategory}</td>
						<td class="col-5  text-primary fw-bold">${AdminReportList.reportReason}</td>
						<td class="col-3  text-primary fw-bold">${AdminReportList.reportTime}
						<fmt:formatDate
								value="${AdminReportList.reportTime}" pattern="a h:mm" type="date" />
						</td>

					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>