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
							name="moimGenderCheckList">
							<option value="">==Select==</option>
							<option>스팸홍보/도배</option>
							<option>음란물</option>
							<option>불법정보</option>
							<option>청소년 유해물</option>
							<option>욕설/생명경시/혐오</option>
							<option>개인정보노출</option>
							<option>불쾌한표현</option>
						</select>
					</div>



					<div class="col">
						정렬순서 : <select class="form-select col  fw-bold text-primary"
							name="orderList">
							<option value="">==Select==</option>
							<option value="report_no asc">번호(오름차순)</option>
							<option value="report_no desc">번호(내림차순)</option>
							<option value="report_reason asc">신고사유(오름차순)</option>
							<option value="report_reason desc">신고사유(내림차순)</option>
							<option value="report_time asc">신고날짜(오름차순)</option>
							<option value="report_time desc">신고날짜(내림차순)</option>

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
					<th class="col-5  fw-bold">신고 내용</th>
					<th class="col-3  fw-bold">신고 날짜</th>


				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminReportList}" var="AdminReportList">
					<tr class="text-center table- row">
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/report/detail?moimNo=${AdminReportList.reportNo}"
							style="text-decoration: none" class="text-primary fw-bold">
								${AdminReportList.reportNo}</a></td>
						<td class="col-3"><a
							href="${pageContext.request.contextPath}/admin/report/detail?moimNo=${AdminReportList.reportNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminReportList.reportReason}</a></td>
						<td class="col-5"><a
							href="${pageContext.request.contextPath}/admin/report/detail?moimNo=${AdminReportList.reportNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminReportList.reportContent}</a></td>
						<td class="col-3"><a
							href="${pageContext.request.contextPath}/admin/report/detail?moimNo=${AdminReportList.reportNo}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminReportList.moimtime}</a></td>



					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>