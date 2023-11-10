<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" >
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@200&display=swap" rel="stylesheet">
<style>

 @font-face {
            font-family: NotoSansKR;
            src: url("./fonts/NotoSansKR-VariableFont_wght.ttf");
        }
p {
            font-family: NotoSansKR;
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

<!--     전용 CDN -->
<link rel="stylesheet" type="text/css" href="/css/EveryFit-layout.css">
<link rel="stylesheet" type="text/css" href="/css/test111.css">

<nav class="navbar navbar-expand-lg bg-primary fixed-top p-0"
	data-bs-theme="dark">
	<div class="container-fluid col-9">
		<a class="navbar-brand ms-4" href="/"><img src="/images/logo.png"
			width="110px" height="100px" /></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarColor01" aria-controls="navbarColor01"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse row" id="navbarColor01">
			<ul class="navbar-nav me-auto ">

				<li class="nav-item col-9">
					<form class="d-flex  mt-4">
						<input
							class="form-control me-sm-2 bg-light ms-5  col-8 text-primary"
							type="search" placeholder="검색어를 입력해주세요" />
						<button class="btn btn-light my-2 my-sm-0 bg-light text-primary"
							type="submit">Search</button>
					</form>
				</li>

			</ul>

		</div>
	</div>

	<div class="">
		<ul class="navbar-nav  row">


				<!-- 회원가입  -->
			<li class="nav-item me-1  col-3  ">
				<a href="/member/join"
					class=" btn btn-outline-primary text-light border-light mt-2">
					<h3>
						<i class="fa-regular fa-id-card mt-2"></i>
					</h3>
				</a>
			</li>
					<!-- 로그인  -->
			<li class="nav-item me-4 col-3 ">
				<a href="/member/login"
				class=" btn btn-light text-primary mt-2">
					<h3>
						<i class="fa-solid fa-right-to-bracket mt-2" ></i>
					</h3>
				</a>
			</li>


			<li class="nav-item dropdown col-5   ">

				
				
				
				<div class="flex-container pt-20">
				
					<div class="row etc-menu custom-menu navy">
						<a class="nav-link dropdown-toggle text-light mt-2 me-5 pe-5"
				data-bs-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">
				<h3><i class="fa-solid fa-list"></i></h3></a>
					<div class="custom-service  rounded">
									<a class="left"  href="${pageContext.request.contextPath}/moim/create">모임 만들기</a>
									<a class="left"  href="${pageContext.request.contextPath}/moim/detail?moimNo=5">모임 상세(테스트용)</a>
									<a class="left" href="#">리그 목록</a>
									<a class="left " href="#">여성전용 모임</a>
									<a class="left " href="#">자유게시판</a>					
									<a class="left " href="#">특별 기능</a>
									<a class="left"  href="${pageContext.request.contextPath}/pay?productNo=1">프리미엄회원권(테스트용)</a>	
									<a class="left"  href="${pageContext.request.contextPath}/pay?productNo=2">프리미엄모임권(테스트용)</a>	

					</div>
				        </div>
				      </div>							
				
			


				</div></li>

		</ul>
	</div>

</nav>
