
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Every Fit</title>



<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@200&display=swap"
	rel="stylesheet">

<!-- datetimepicker -->	
<link rel="stylesheet" href="/css/jquery.datetimepicker.min.css" />
	
<link rel="preload" href="webfont-path" as="font" crossorigin />
	
<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script>
<script>
  WebFont.load({
    google: {
      families: ['Noto Sans KR', 'Noto Sans KR']
    }
  });
</script>
	
<style>
@font-face {
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
}

#wrapper {
	font-family: 'Noto Sans KR', sans-serif;
}

.dropdown-menu {
	/* 	--bs-body-color: #;  //톱니바퀴안에 글씨색*/
	/* --bs-body-bg: #a2c1f6; */
	--bs-body-bg: #4582ec;
	--bs-tertiary-bg: #5094ed;
	--bs-dropdown-zindex: 1000;
	--bs-dropdown-min-width: 10rem;
	--bs-dropdown-padding-x: 0;
	--bs-dropdown-padding-y: 0.5rem;
	--bs-dropdown-spacer: 0.125rem;
	--bs-dropdown-font-size: 1.1rem;
	--bs-dropdown-color: var(--bs-body-color);
	--bs-dropdown-bg: var(--bs-body-bg);
	--bs-dropdown-border-color: var(--bs-border-color-translucent);
	--bs-dropdown-border-radius: var(--bs-border-radius);
	--bs-dropdown-border-width: var(--bs-border-width);
	--bs-dropdown-inner-border-radius: calc(var(--bs-border-radius)- var(--bs-border-width));
	--bs-dropdown-divider-bg: var(--bs-border-color-translucent);
	--bs-dropdown-divider-margin-y: 0.5rem;
	--bs-dropdown-box-shadow: var(--bs-box-shadow);
	--bs-dropdown-link-color: var(--bs-body-color);
	--bs-dropdown-link-hover-color: var(--bs-body-color);
	--bs-dropdown-link-hover-bg: var(--bs-tertiary-bg);
	--bs-dropdown-link-active-color: #fff;
	--bs-dropdown-link-active-bg: #4582ec;
	--bs-dropdown-link-disabled-color: var(--bs-tertiary-color);
	--bs-dropdown-item-padding-x: 1rem;
	--bs-dropdown-item-padding-y: 0.25rem;
	--bs-dropdown-header-color: #868e96;
	--bs-dropdown-header-padding-x: 1rem;
	--bs-dropdown-header-padding-y: 0.5rem;
	position: absolute;
	z-index: var(--bs-dropdown-zindex);
	display: none;
	min-width: var(--bs-dropdown-min-width);
	padding: var(--bs-dropdown-padding-y) var(--bs-dropdown-padding-x);
	margin: 0;
	font-size: var(--bs-dropdown-font-size);
	color: var(--bs-dropdown-color);
	text-align: left;
	list-style: none;
	background-color: var(--bs-dropdown-bg);
	background-clip: padding-box;
	border: var(--bs-dropdown-border-width) solid
		var(--bs-dropdown-border-color);
	border-radius: var(--bs-dropdown-border-radius);
}
</style>
<!--     부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<!--     부트 워치 -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/litera/bootstrap.min.css"
	rel="stylesheet">
	
	
	
<!--     폰트어썸 -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- datetimepicker -->	
<script src="/js/jquery.datetimepicker.full.min.js"></script>
    
<!-- 모먼트.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<!--     전용 CDN -->
<link rel="stylesheet" type="text/css" href="/css/EveryFit-layout.css">
<link rel="stylesheet" type="text/css" href="/css/test.css">

<!-- Bootstrap JS (including Popper.js) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
<!-- jQuery UI CSS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jQuery UI JS -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
</head>






<script>
	function startTime() {
		const today = new Date();
		let h = today.getHours();
		let m = today.getMinutes();
		let s = today.getSeconds();
		m = checkTime(m);
		s = checkTime(s);
		document.getElementById('txt').innerHTML = h + "시" + " " + m + "분"
				+ " " + s + "초";
		setTimeout(startTime, 1000);
	}

	function checkTime(i) {
		if (i < 10) {
			i = "0" + i
		}
		;
		return i;
	}
	
</script>


<body>




	<nav class="navbar navbar-expand-lg bg-primary fixed-top"
		data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand ms-4" href="/"><img src="/images/logo.png"
				width="110px"/></a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarColor01"
				aria-controls="navbarColor01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav me-auto">
				
				
			
					<c:choose>
						<c:when test="${sessionScope.name==null}">

							<li class="nav-item">
								<h1>
									<a class="nav-link ms-3" href="/member/login"> <i
										class="fa-solid fa-user mt-2"></i>
									</a>
								</h1>
							</li>
						</c:when>

						<c:otherwise>
							<li class="nav-item">
								<h1>
									<a class="nav-link ms-3" href="/member/logout"> <i
										class="fa-solid fa-user-slash mt-2"></i>
									</a>
								</h1>
							</li>

						</c:otherwise>
					</c:choose>
							<li class="nav-item">
						<h1>
							<a class="nav-link ms-3" href="/member/join"> <i
								class="fa-solid fa-user-plus mt-2"></i> <span
								class="visually-hidden">(current)</span>
							</a>
						</h1>
					</li>
					
					
					<li class="nav-item">
						<h1>
							<a class="nav-link ms-3" href=/member/mypage> 
							<i class="fa-solid fa-user-gear mt-2"></i>
							</a>
						</h1>
					</li>



					<li class="nav-item">
						<h1>
							<a class="nav-link ms-3" href="#"> <i
								class="fa-solid fa-ranking-star mt-2"></i>
							</a>
						</h1>
					</li>

					<li class="nav-item">
						<h1>
							<a class="nav-link ms-3" href="#"> <i
								class="fa-solid fa-route  mt-2"></i>
							</a>
						</h1>
					</li>

					<li class="nav-item">
						<h1>
							<a class="nav-link ms-3" href="#"> <i
								class="fa-solid fa-people-group  mt-2"></i>
							</a>
						</h1>
					</li>



					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle ms-3" data-bs-toggle="dropdown"
						href="#" role="button" aria-haspopup="true" aria-expanded="false">
							<h2>
								<i class="fa-solid fa-users-gear mt-2"></i>
							</h2>
					</a>
						<div class="dropdown-menu">
							<a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/moim/create"> 모임
								만들기 </a> <a class="dropdown-item  fw-bold"
								href="${pageContext.request.contextPath}/moim/detail?moimNo=5">
								모임상세(테스트용) </a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item fw-bold" href="/league/leagueList">리그
								목록</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item fw-bold" href="#">여성전용 모임</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/freeBoard/list">자유게시판</a>
							<a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/faq/list">FAQ</a>

							<div class="dropdown-divider"></div>
							<a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/pay?productNo=1">
								프리미엄회원권 </a> <a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/pay?productNo=2">
								프리미엄모임권 </a> <a class="dropdown-item fw-bold"
								href="${pageContext.request.contextPath}/pay/list">
								나의결제내역리스트 </a>
						</div></li>



				




					<c:choose>
						<c:when test="${sessionScope.name != null}">


							<li class="nav-item ms-5">
								<h5>
									<div class="text-light fw-bold">${name}회원님 환영합니다.</div>
						
								</h5>
							</li>
						</c:when>
						<c:otherwise>
							<li class="nav-item ms-5">
					
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="d-flex">
				<div class="nav-item ms-5 me-3  bg-light rounded-3 "
					style="margin-left: 5500">
					<h6 class="text-primary fw-bold ">Now Time</h6>
					<div id="txt" class="text-primary fw-bold">
						<h5></h5>
					</div>
				</div>
			</div>
			
			<form class="d-flex">
				<input class="form-control me-sm-2 mt-3 bg-light text-primary fw-bold"
					type="search" placeholder="Search" style="height: 52px">
				<button class="btn btn-light   text-primary mt-3  fw-bold"
					type="submit"  style="height: 52px">Search</button>
			</form>
			</div>
		</div>
	</nav>

<body onload="startTime()">
	<div class="p-5 m-5"></div>
	<div id='wrapper'>

















		<!-- <nav class="navbar navbar-expand-lg bg-primary fixed-top p-0"
	data-bs-theme="dark">
	<div class="container-fluid col-9">
		<a class="navbar-brand ms-4" href="/"><img src="/images/logo.png"
			width="110px" height="100px" /></a>

		<div class="collapse navbar-collapse row" id="navbarColor01">
			<ul class="navbar-nav me-auto ">

				<li class="nav-item col-9">
					<form class="d-flex  mt-4">
						<input
							class="form-control me-sm-2 bg-light ms-5  col-8 text-primary"
							type="search" placeholder="검색어를 입력해주세요" />
						<button class="btn btn-light my-2 my-sm-0 bg-light text-primary"
							type="submit">Search
						</button>
					</form>
				</li>

			</ul>

		</div>
	</div>

	<div class="">
		<ul class="navbar-nav  row"> -->


		<!-- 회원가입  -->
		<!-- <li class="nav-item me-1  col-3  "><a href="/member/join"
				class=" btn btn-outline-primary text-light border-light mt-2">
					<h3>
						<i class="fa-regular fa-id-card mt-2"></i>
					</h3>
			</a></li> -->
		<!-- 로그인  -->
		<!-- 			<li class="nav-item me-4 col-3 "><a href="/member/login"
				class=" btn btn-light text-primary mt-2">
					<h3>
						<i class="fa-solid fa-right-to-bracket mt-2"></i>
					</h3>
			</a></li>


			<li class="nav-item dropdown col-5   "> -->




		<%-- 				<div class="flex-container pt-20">

					<div class="row etc-menu custom-menu navy">
						<a class="nav-link dropdown-toggle text-light mt-2 me-5 pe-5"
							data-bs-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">
							<h3>
								<i class="fa-solid fa-list"></i>
							</h3>
						</a>
						<div class="custom-service  rounded">
							<a class="left"
								href="${pageContext.request.contextPath}/moim/create">모임 만들기</a>
							<a class="left"
								href="${pageContext.request.contextPath}/moim/detail?moimNo=5">모임
								상세(테스트용)</a> <a class="left" href="#">리그 목록</a> <a class="left "
								href="#">여성전용 모임</a> <a class="left " href="#">자유게시판</a> <a
								class="left " href="#">특별 기능</a> <a class="left"
								href="${pageContext.request.contextPath}/pay?productNo=1">프리미엄회원권(테스트용)</a>
							<a class="left"
								href="${pageContext.request.contextPath}/pay?productNo=2">프리미엄모임권(테스트용)</a>

						</div>
					</div>
				</div>
	
	</li>

	</ul>
	</div>

</nav> --%>




		<!-- <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Toggle right offcanvas</button>

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    ...
  </div>
</div> -->