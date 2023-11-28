<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
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



<div class="container-fluid">

<form action="">
<div class="row bg-primary rounded-top-3  text-light fw-bold pt-3">
<div class="col">이메일 : <input class="form-control fw-bold text-primary" 
 name="memberEmail" value="${adminMemberSearchVO.memberEmail}"></div>
<div class="col">이름 : <input class="form-control fw-bold text-primary" 
name="memberName" value="${adminMemberSearchVO.memberName}" ></div>
<div class="col">닉네임 : <input class="form-control fw-bold text-primary" 
name="memberNick" value="${adminMemberSearchVO.memberNick}"></div>
<div class="col">전화번호 : <input class="form-control fw-bold text-primary"
name="memberContact" value="${adminMemberSearchVO.memberContact}"></div>
<div class="col">생년월일 : <input class="form-control fw-bold text-primary" type="date"
name="memberbirthBegin" value="${adminMemberSearchVO.memberBirthBegin}"> ~
<input class="form-control fw-bold text-primary"  type="date"
name="memberbirthEnd" value="${adminMemberSearchVO.memberBirthEnd}">
</div>

</div>




<div class="row bg-primary rounded-bottom-3 text-light fw-bold pb-3">



<div class="col">
성별 : <select  class="form-select col  fw-bold text-primary" name="memberGenderList">
<option value="" class="fw-bold bg-primary text-light">==Select==</option>
<option class="fw-bold bg-primary text-light">M</option>
<option class="fw-bold bg-primary text-light">F</option>
</select></div>
<div class="col">
등급 : <select  class="form-select col  fw-bold text-primary" name="memberLevelList">
<option value="" class="fw-bold bg-primary text-light">==Select==</option>
<option class="fw-bold bg-primary text-light">일반</option>
<option class="fw-bold bg-primary text-light">프리미엄</option>
<option class="fw-bold bg-primary text-light">관리자</option>
</select>
</div>
<div class="col">
정렬순서 : <select  class="form-select col  fw-bold text-primary" name="orderList">
<option value="" class="fw-bold bg-primary text-light">==Select==</option>
<option value="member_email asc" class="fw-bold bg-primary text-light">이메일</option>
<option value="member_name asc" class="fw-bold bg-primary text-light">이름</option>
<option value="member_nick asc" class="fw-bold bg-primary text-light">닉네임</option>
<option value="member_contact asc" class="fw-bold bg-primary text-light">전화번호</option>
<option value="member_birth asc" class="fw-bold bg-primary text-light">생년월일</option>
<option value="member_level asc" class="fw-bold bg-primary text-light">등급</option>
</select>
</div>
	<div class="row mt-3">
			<div
				class="col-2 offset-10 text-center bg-primary rounded-3  text-light p-0">
				<button type="submit" class="text-light bg-primary" style="border: 0"> <h7
						class="display-4">
					<i class="fa-solid fa-magnifying-glass fa-flip " id="addIcon"></i>
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
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>