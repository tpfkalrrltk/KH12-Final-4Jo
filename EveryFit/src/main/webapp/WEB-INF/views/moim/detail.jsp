<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<title>모임 상세페이지</title>


<div class="container-fluid mb-5 pb-5">
	<div class="row">
		<div class="col-md-10 offset-md-1">
			<div class="jumbotron mt-5">
				<h1 class="display-4 bg-primary rounded text-light p-3">모임상세</h1>
				<p class="lead">모임상세/정모등록 페이지입니다</p>
				<hr class="my-4" />
				<p>구현중입니다</p>
			</div>


			<div class="card border-primary mb-3" style="max-width: 20rem;">

				<div class="card-body">

					<div class="row mt-4">
						<c:choose>
							<c:when test="${profile == null}">
								<img src="/images/user.png" class="rounded profile-image">
							</c:when>
							<c:otherwise>
								<img src="/rest/attach/download?attachNo=${profile}"
									class="rounded profile-image">
							</c:otherwise>
						</c:choose>

						<!--  라벨을 만들고 파일선택창을 숨김 -->
						<label> <input type="file" class="profile-chooser"
							accept="image/*"> <i class="fa-solid fa-user fa-2x"></i>
						</label> <i class="fa-solid fa-trash-can fa-2x profile-delete"></i> <br>
					</div>
				</div>
			</div>

			${profile}
			<h1>모임 상세(사진, 모임명, 설명)</h1>
			${moimDto.moimNo} ${locationDto.locationDepth1}
			${locationDto.locationDepth2} ${eventDto.eventName}
			<h1>회원목록</h1>
			<c:forEach var="moimMemberDto" items="${memberList}">
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
	</c:forEach>
			<hr>
			<button type="button">
				<a href="jungmo/create?moimNo=${moimDto.moimNo}"> 정모등록 </a>
			</button>

			<hr>
			<h1>정모 List</h1>
			<button type="button" class="load-list">목록불러오기</button>
			<div class="jungmoContainer"></div>
		</div>
	</div>
</div>


<script>

	$(document).ready(function () {
	    loadJungmoList();
	});

	var moimNo = "${moimDto.moimNo}";
	$(".profile-chooser").change(function(){

		var input = this;
		if(input.files.length == 0) return;
		
		//ajax로 multipart 업로드
		var form = new FormData();
		form.append("attach", input.files[0]);
		form.append("moimNo", moimNo);
		
		$.ajax({
			url:"http://localhost:8080/rest/attach/upload",
			method:"post",
			processData:false,
			contentType:false,
			data:form,
			success:function(response){
				//응답 형태 - { "attachNo" : 7 }
				//프로필 이미지 교체
				$(".profile-image").attr("src", 
					"/rest/attach/download?attachNo="+response.attachNo);
			},
			error:function(){
				window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
			},
		});
		
	});
	//삭제아이콘을 누르면 프로필이 제거되도록 구현
	$(".profile-delete").click(function() {
		//확인창
		var choice = window.confirm("정말 프로필을 지우시겠습니까?");
		if(choice == false) return;
		
		//삭제요청
		$.ajax({
			url:"http://localhost:8080/rest/attach/delete",
			method:"post",
			data:{moimNo, moimNo},
			success:function(response){
				$(".profile-image").attr("src", "/images/user.png");
			},
		});
	});

	
    // 정모목록을 로드하는 함수
    function loadJungmoList() {
        
    	var moimNo = "${moimDto.moimNo}";
    	    	
    	$.ajax({
            type: 'POST',
            url: 'http://localhost:8080/rest/moim/list', 
            data: {moimNo: moimNo},
            dataType: 'json',
            success: function (data) {
                
				$.each(data, function(index, data) { // 데이터 =item
					$(".jungmoContainer").append(index + " "); // index가 끝날때까지 
					$(".jungmoContainer").append(data.jungmo_title + " ");
					$(".jungmoContainer").append(data.jungmo_addr + " ");
					$(".jungmoContainer").append(data.jungmo_addr_link + " ");
					$(".jungmoContainer").append(data.jungmo_capacity + " ");
					$(".jungmoContainer").append(data.jungmo_price + " ");
					$(".jungmoContainer").append(data.jungmo_schedule + " ");
					$(".jungmoContainer").append(data.jungmo_status + " ");
					$(".jungmoContainer").append(data.attach_no + " ");
				});
            },
            error: function () {
                alert('Jungmo 목록을 로드하는 중 오류가 발생했습니다.');
            }
        });
    }

    // 페이지에 Jungmo 목록을 표시하는 함수
//     function displayJungmoList(jungmoList) {
//         var container = $('.jungmoContainer');
//         container.empty(); 

//         var ul = $('<ul>');

//         $.each(jungmoList, function (index, jungmo) {
//             var li = $('<li>').text(${jungmo.jungmo_title});
//             ul.append(li);
//         });

//         container.append(ul);
//     }

    // 버튼 클릭 시 Jungmo 목록 로드
   $('.load-list').click(function () {
       loadJungmoList();
   });

	
</script>

