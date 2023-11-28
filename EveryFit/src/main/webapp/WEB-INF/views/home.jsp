x<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<c:choose>
	<c:when test="${sessionScope.level =='관리자' }">
		<%@ include file="template/adminHeader.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="template/Header.jsp"%>
	</c:otherwise>
</c:choose>




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

		var nystories = document.querySelector("p").offsetTop;
		window.onscroll = function() {
			if (window.pageYOffset > 0) {
				var opac = (window.pageYOffset / nystories);
				console.log(opac);
				document.body.style.background = "linear-gradient(rgba(255, 255, 255, "
						+ opac
						+ "), rgba(255, 255, 255, "
						+ opac
						+ ")), url(https://cdn.spotoday.kr/news/photo/202205/4846_3187_4414.jpg) no-repeat";
			}
		}

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
<style>
body {
	font-family: Calluna, Arial, sans-serif;
	background: linear-gradient(rgba(255, 255, 255, 0),
		rgba(255, 255, 255, 0)),
		url(https://cdn.spotoday.kr/news/photo/202205/4846_3187_4414.jpg);
	background-repeat: no-repeat;
	background-attachment: fixed !important;
	background-size: 100% !important;
	background-position: center top !important;
	padding: 1rem;
	padding-top: 45%;
	color: #fff;
}
.profile-image {
	object-fit:cover; 
}
.card {
	height: 450px; 
/* 	max-height: 600px; */
}
.card-body {
	font-size:15px;
}
.card-text-leader {
	font-size:15px;
}
.card-title {
	font-size:15px;
}
.card-text {
	font-size:15px;
}

</style>






<div class="m-3 p-3">
	<h1 id="main-text1"
		style="font-size: 4rem; text-shadow: 0 0 5px rgba(0, 0, 0, 0.5); line-height: 1; position: absolute; top: 500px; left: 300px; font-weight: 100; font-weight: bolder;">
		EVERY FIT</h1>
	<h2 id="main-text2"
		style="text-align: center; text-transform: uppercase; margin-bottom: 0; bottom: 150px; left: 850px; position: absolute">Scroll</h2>
	<span id="directionality"
		style="display: block; margin: 0; text-align: center; font-size: 3rem; bottom: 80px; left: 890px; position: absolute">▼</span>


	<div class="container-fluid">

		<div class="row mt-5 p-5 ">

			<div
				class="col-5 col-sm-7 col-md-4 col-lg-4 offset-4 offset-sm-1 offset-md-3 p-5 m-4 bg-primary rounded-3  text-light "
				id="Premium">
				<h1 class="display-5 fw-bold">Premium</h1>

			</div>
		</div>



		<div class="row align-items-center m-5 p-5">


			<c:forEach var="PremiumMoimList" items="${PremiumMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0 ">
					<div class="card border-primary mb-3 w-100 Premium bg-primary"
						style="max-width: 400px;">
						<div class="card-header bg-light text-primary fw-bold w-100">${PremiumMoimList.moimTitle}</div>
						<div class="card-body  w-100 h-100">
							<div class="text-start">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${PremiumMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${PremiumMoimList.moimNo}"
									class="rounded profile-image " width="100%" height="200px">
								</a>
							</div>
							<c:choose>
								<c:when test="${PremiumMoimList.moimTitle.length() >=7}">
									<h4 class="card-title text-light bg-primary">${PremiumMoimList.moimTitle.substring(0, 7)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-light bg-primary">${PremiumMoimList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>


							<c:choose>
								<c:when test="${PremiumMoimList.moimContent.length() >=40}">
									<p class="card-text lead text-light bg-primary">${PremiumMoimList.moimContent.substring(0, 40)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead text-light bg-primary">${PremiumMoimList.moimContent}</p>
								</c:otherwise>
							</c:choose>


							<div class="container">
								<div class="row">
									<div class="col-6 offset-6 ">
										<p class="card-text text-end text-light  ">
											<small class="memberCount"> 현재 인원
												${PremiumMoimList.memberCount} /
												${PremiumMoimList.moimMemberCount} </small>
									</div>
								</div>
							</div>


							<a
								class="btn btn-light text-primary btn-md fw-bold premium-btn btn-join"
								role="button" data-moim-no="${PremiumMoimList.moimNo}">Join</a>

						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
			</c:if>
			</c:forEach>
		</div>
		

		</div>


		<div class="row contaner-fluid  auto-width m-5 p-5">
<c:if test="${sessionScope.name !=null }">
<div class="row mt-5 p-5">
			<div class="col-4 col-sm-7 col-md-4 col-lg-4 offset-4 offset-sm-1 offset-md-3 offset-4 p-5 m-4 bg-primary rounded-3  text-light"
				id="myMoim">
				<h1 class="display-5 fw-bold">내가 가입한 모임</h1>

			</div>


			<div class="row align-items-center m-5">


			<c:forEach var="myMoimList" items="${myMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0">
					<div class="card border-primary mb-3 w-100"
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light fw-bold  ">${myMoimList.moimTitle}</div>
						<div class="card-body ">


							<div class="text-start">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${myMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${myMoimList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>


							<c:choose>
								<c:when test="${myMoimList.moimTitle.length() >=7}">
									<h4 class="card-title text-primary">${myMoimList.moimTitle.substring(0, 7)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-primary">${myMoimList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${myMoimList.moimContent.length() >=40}">
									<p class="card-text lead">${myMoimList.moimContent.substring(0, 40)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead">${myMoimList.moimContent}</p>
								</c:otherwise>
							</c:choose>




							<div class="container">
								<div class="row">
									<div class="col-6 offset-6 p-0">
										<p class="card-text text-end ">
											<small >현재 인원 ${myMoimList.memberCount}	 / ${myMoimList.moimMemberCount}
										</small>
											</p>


										</div>
									</div>
								</div>

							<a class="btn btn-primary btn-md fw-bold New-btn btn-join">Join</a>

						</div>
					</div>
					<!-- Start a new row after every 3rd product -->
					<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
			</div>
			<div class="row contaner-fluid  auto-width m-5">
		</c:if>
		</c:forEach>


	</div>

	</c:if>


	<c:if test="${sessionScope.name !=null }">
		<div class="row mt-5 p-5">
			<div
				class="col-4 col-sm-7 col-md-4 col-lg-4 offset-4 offset-sm-1 offset-md-3 offset-4 p-5 m-4 bg-primary rounded-3  text-light"
				id="myMoim">
				<h1 class="display-5 fw-bold">내가 찜한 모임</h1>
			</div>
		</div>


		<div class="row align-items-center m-5">

			<c:forEach var="myLikeMoimList" items="${myLikeMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0">
					<div class="card border-primary mb-3 w-100"
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light fw-bold  ">${myLikeMoimList.moimTitle}
							</div>
						<div class="card-body ">


							<div class="text-start">
								<a
									href="${pageContext.request.contextPath}/moim/detail?moimNo=${myLikeMoimList.moimNo}">
									<img
									src="${pageContext.request.contextPath}/image?moimNo=${myLikeMoimList.moimNo}"
									class="rounded profile-image" width="100%" height="200px">
								</a>
							</div>


							<c:choose>
								<c:when test="${myLikeMoimList.moimTitle.length() >=7}">
									<h4 class="card-title text-primary">${myLikeMoimList.moimTitle.substring(0, 7)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-primary">${myLikeMoimList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${myLikeMoimList.moimContent.length() >=40}">
									<p class="card-text lead">${myLikeMoimList.moimContent.substring(0, 40)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead">${myLikeMoimList.moimContent}</p>
								</c:otherwise>
							</c:choose>




							<div class="container">
								<div class="row">
									<div class="col-6 offset-6 p-0">
										<p class="card-text text-end ">
											<small>현재 인원 ${myLikeMoimList.memberCount} /
												${myLikeMoimList.moimMemberCount}
										</p>
										</small>

									</div>
								</div>
							</div>

							<a class="btn btn-primary btn-md fw-bold New-btn btn-join"
								role="button" data-moim-no="${myLikeMoimList.moimNo}">Join</a>
						</div>
					</div>
				</div>
				<!-- Start a new row after every 3rd product -->
				<c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
		<div class="row contaner-fluid  auto-width m-5">
	</c:if>
	</c:forEach>

		</div>

</div>

</c:if>




<div class="row mt-5 p-5">
	<div
		class="col-4 col-sm-7 col-md-4 col-lg-4 offset-4 offset-sm-1 offset-md-3 offset-4 p-5 m-4 bg-primary rounded-3  text-light"
		id="NowMoim">
		<h1 class="display-5 fw-bold">최근 생성된 모임</h1>
	</div>
</div>


<div class="row align-items-center m-5">


			<c:forEach var="NewMoimList" items="${NewMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0">
					<div class="card border-primary mb-3 w-100"
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light fw-bold  ">${NewMoimList.moimTitle}</div>
						<div class="card-body ">



					<div class="text-center">
						<a
							href="${pageContext.request.contextPath}/moim/detail?moimNo=${NewMoimList.moimNo}">
							<img
							src="${pageContext.request.contextPath}/image?moimNo=${NewMoimList.moimNo}"
							class="rounded profile-image" width="100%" height="200px">
						</a>
					</div>



							<c:choose>
								<c:when test="${NewMoimList.moimTitle.length() >=7}">
									<h4 class="card-title text-primary">${NewMoimList.moimTitle.substring(0, 7)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-primary">${NewMoimList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${NewMoimList.moimContent.length() >=40}">
									<p class="card-text lead">${NewMoimList.moimContent.substring(0, 40)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead">${NewMoimList.moimContent}</p>
								</c:otherwise>
							</c:choose>





					<div class="container">
						<div class="row">
							<div class="col-6 offset-6 p-0">
								<p class="card-text text-end ">
									<small>현재 인원 ${NewMoimList.memberCount} /
										${NewMoimList.moimMemberCount}
								</p>
								</small>

							</div>


							<a class="btn btn-primary btn-md fw-bold New-btn btn-join"
								role="button" data-moim-no="${NewMoimList.moimNo}">Join</a>

						</div>
					</div>

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


<div class="row mt-5 p-5">
	<div
		class="col-4  col-sm-7 col-md-4 col-lg-4 offset-4 offset-sm-1 offset-md-3 offset-4 p-5 m-4 bg-primary rounded-3  text-light"
		id="GenderCheck">
		<h1 class="display-5 fw-bold">여성전용 모임</h1>
	</div>
</div>


<div class="row align-items-center m-5">


			<c:forEach var="GenderCheckMoimList" items="${GenderCheckMoimList}"
				varStatus="loopStatus" end="7">
				<div class="col pe-0  ">
					<div class="card border-primary mb-3 w-100 "
						style="max-width: 400px;">
						<div class="card-header bg-primary text-light  fw-bold ">${GenderCheckMoimList.moimTitle}</div>
						<div class="card-body ">



					<div class="text-center">
						<a
							href="${pageContext.request.contextPath}/moim/detail?moimNo=${GenderCheckMoimList.moimNo}">
							<img
							src="${pageContext.request.contextPath}/image?moimNo=${GenderCheckMoimList.moimNo}"
							class="rounded profile-image" width="100%" height="200px">
						</a>
					</div>


							<c:choose>
								<c:when test="${GenderCheckMoimList.moimTitle.length() >=7}">
									<h4 class="card-title text-primary">${GenderCheckMoimList.moimTitle.substring(0, 7)}..</h4>
								</c:when>
								<c:otherwise>
									<h4 class="card-title text-primary">${GenderCheckMoimList.moimTitle}</h4>
								</c:otherwise>
							</c:choose>


							<c:choose>
								<c:when test="${GenderCheckMoimList.moimContent.length() >=40}">
									<p class="card-text lead">${GenderCheckMoimList.moimContent.substring(0, 40)}...</p>
								</c:when>
								<c:otherwise>
									<p class="card-text lead">${GenderCheckMoimList.moimContent}</p>
								</c:otherwise>
							</c:choose>





					<div class="container">
						<div class="row">
							<div class="col-6 offset-6 p-0">
								<p class="card-text text-end ">
									<small>현재 인원 ${GenderCheckMoimList.memberCount} /
										${GenderCheckMoimList.moimMemberCount}
								</p>
								</small>

							</div>



							<a class="btn btn-primary btn-md fw-bold Gender-btn btn-join"
								role="button" data-moim-no="${GenderCheckMoimList.moimNo}">Join </a>

						</div>
					</div>


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