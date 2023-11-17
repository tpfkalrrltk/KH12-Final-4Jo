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
				<h1 class="display-5 fw-bold">회원 관리</h1>

			</div>
		</div>


		<div class="row">



			<div
				class="col-1 offset-10 text-center bg-primary rounded-5  text-light">
				<a href="#" class="text-light" style="text-decoration: none"> <h7
						class="display-4">
					<i class="fa-solid fa-magnifying-glass fa-flip " id="addIcon"></i>
					</h7>
				</a>
			</div>



		</div>



		<table class="table table-hover row">
			<thead>
				<tr class=" table-primary text-center row mt-4">
					<th class="col-2  fw-bold">이메일</th>
					<th class="col-2  fw-bold">이름</th>
					<th class="col-2  fw-bold">닉네임</th>
					<th class="col-1  fw-bold">성별</th>
					<th class="col-2  fw-bold">전화번호</th>
					<th class="col-2  fw-bold">생년월일</th>
					<th class="col-1  fw-bold">등급</th>
				</tr>
			</thead>

			<tbody>



				<c:forEach items="${adminMemberList}" var="AdminMemberList">
					<tr class="text-center table- row">
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">
								${AdminMemberList.memberEmail}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberName}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberNick}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberGender}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberContact}</a></td>
						<td class="col-2"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberBirth}</a></td>
						<td class="col-1"><a
							href="${pageContext.request.contextPath}/admin/member/mypage?memberEmail=${AdminMemberList.memberEmail}"
							style="text-decoration: none" class="text-primary fw-bold">${AdminMemberList.memberLevel}</a></td>


					</tr>

				</c:forEach>
			</tbody>

		</table>

	</div>










</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>