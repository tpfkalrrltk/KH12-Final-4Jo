<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<%@ include file="template/adminHeader.jsp"%>

<%--
<c:choose>
	<c:when test="${sessionScope.level =='관리자' }">
		<%@ include file="template/adminHeader.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="template/Header.jsp"%>
	</c:otherwise>
</c:choose> 
--%>



<script>
	$(function() {

		let keyframes = [ {
			opacity : 1,
			transform : "translate(0px, 0)"
		}, {
			opacity : 0.2,
			transform : "translate(-50px, 0)"
		}, {
			opacity : 1,
			transform : "translate(0px, 0)"
		} ];
		let options = {
			delay : 0000,
			duration : 3000,
			easing : "ease-in-out",
			iterations : Infinity,
			fill : "forwards"
		};
		document.querySelector("#Premium").animate(keyframes, options);
		document.querySelector("#NowMoim").animate(keyframes, options);
		document.querySelector("#GenderCheck").animate(keyframes, options);


		let mainFrames = [ {
			opacity : 1,
			//background-color:  #4582EC,
			transform : "translate(0, 30px)"
		}, {
			opacity : 0.2,
			//background-color:  #FFFFFF,
			transform : "translate(0, 0px)"
		}, {
			opacity : 1,
			//background-color:  #4582EC,
			transform : "translate(0px, 30px)"
		} ];
		let mainOptions = {
			delay : 0000,
			duration : 2500,
			easing : "ease-in",
			iterations : Infinity,
			fill : "forwards"
		};

		document.querySelector("#main-text1").animate(mainFrames, mainOptions);
		document.querySelector("#main-text2").animate(mainFrames, mainOptions);
		document.querySelector("#directionality").animate(mainFrames,
				mainOptions);
	});

	$(function() {
		$(".btn-join").click(function(e) {

			// 모임 번호 가져오기
			var moimNo = $(this).data("moim-no");
			console.log(moimNo);
			$.ajax({
				url : "http://localhost:8080/rest/moim/member/join",
				method : "post",
				data : {
					moimNo : moimNo
				},
				success : function(response) {
					// 서버에서 받은 응답(response)에 따라 화면 처리
					console.log(response);
					// 예시: 성공 시 alert 창 띄우기
					if (response === "notLoggedIn") {
						$(".modal-body").text("로그인하세요.");
						Modal.show();
						// 다른 화면 처리 로직을 여기에 추가
					} else if (response === "memberNotFound") {
						$(".modal-body").text("로그인하세요.");
						Modal.show();
						// 실패 시 처리 로직을 여기에 추가
					} else if (response === "moimNotFound") {
						$(".modal-body").text("존재하지 않는 모임입니다.");
						Modal.show();
						// 실패 시 처리 로직을 여기에 추가
					} else if (response === "over") {
						$(".modal-body").text("가입할 수 있는 모임 개수가 초과되었습니다.");
						Modal.show();
						// 실패 시 처리 로직을 여기에 추가
					} else if (response === "joined") {
						$(".modal-body").text("이미 가입한 모임");
						Modal.show();
						// 실패 시 처리 로직을 여기에 추가
					} else if (response === "genderCheck") {
						$(".modal-body").text("여성회원만 가입 가능");
						Modal.show();
						// 실패 시 처리 로직을 여기에 추가
					} else {
						// 실패 시 처리 로직을 여기에 추가
						$(".modal-body").text("가입이 완료되었습니다.");
						Modal.show();
					}
				},
				error : function(error) {
					alert("에러가 발생했습니다.");
				}
			});
		});

		var Modal = new bootstrap.Modal(document.getElementById('myModal'));

		$("#myModal").on('hidden.bs.modal', function() {
			location.reload();
		});
	});
</script>




	<div class="container-fluid ">



			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light "
				id="Premium">
				<h1 class="display-5 fw-bold">검색 결과</h1>

			</div>
		</div>



		<div class="row align-items-center m-5">

			<c:forEach var="homeMoimSearchList" items="${homeMoimSearchList}"
				varStatus="loopStatus">
				<div class="col pe-0 ">
					<div class="card border-primary mb-3 w-100 Premium bg-primary"
						style="max-width: 400px;">
						<div class="card-header bg-light text-primary fw-bold ">Moim
							No.${homeMoimSearchList.moimNo}</div>
						<div class="card-body ">
							<div class="text-center">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${homeMoimSearchList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${homeMoimSearchList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>
							<c:choose>
								<c:when test="${homeMoimSearchList.moimTitle.length() >=14}">
									<h4 class="card-title text-light bg-primary">${homeMoimSearchList.moimTitle.substring(0, 14)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-light bg-primary">${homeMoimSearchList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>


							<c:choose>
								<c:when test="${homeMoimSearchList.moimContent.length() >=14}">
									<p class="card-text lead text-light bg-primary">${homeMoimSearchList.moimContent.substring(0, 14)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead text-light bg-primary">${homeMoimSearchList.moimContent}</p>
								</c:otherwise>
							</c:choose>


							<div class="container">
								<div class="row">
									<div class="col-6 offset-6 ">
										<p class="card-text text-end text-light  ">
											<small class="memberCount"> 현재 인원
												${homeMoimSearchList.memberCount}
									 / ${homeMoimSearchList.moimMemberCount}
										</small>

									</div>
								</div>
							</div>


							<a
								class="btn btn-light text-primary btn-lg fw-bold premium-btn btn-join"
								role="button" data-moim-no="${homeMoimSearchList.moimNo}">Join</a>

						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		</div>
		<div class="row contaner-fluid  auto-width m-5">
			</c:if>
			</c:forEach>

		</div>



		

		</div>




	</div>
</div>


<div class="modal" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body text-black"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>



<%@ include file="template/Footer.jsp"%>