<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="../template/Header.jsp"></jsp:include>

<style>
.box {
	margin: 20px;
	padding: 30px;
	border: 1px solid #118ab2;
	border-radius: 14px;
}

.container a {
	text-decoration: none;
}

</style>



<div class="container-fluid ">
	<div class="row"><div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row mt-5 p-3 border border-primary rounded shadow-sm"><div class="col">
			<div class="row m-1">
				<div class="col-4">
					<c:choose>
						<c:when test="${profile == null }">
							<img src="/images/profile.png"
								class="rounded-circle border shadow-sm bg-dark profile-image w-100">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${profile}"
								class="rounded-circle border shadow-sm bg-dark profile-image w-25">
						</c:otherwise>
					</c:choose>
					<div class="row mt-2 text-center"><div class="col">
						<label> 
							<input type="file" class="profile-chooser "
										accept="image/*" style="display: none;">
							<i class="fa-solid fa-camera-retro text-primary fa-2x"></i>
						</label> 
						<i class="ms-2 fa-regular fa-trash-can text-danger fa-2x profile-delete"></i>
					</div></div>
				</div>
				<div class="col-8">
					<div class="row mt-4 ms-2"><div class="col d-flex align-items-center">
						<h3>${memberDto.memberNick}</h3>
						<c:choose>
							<c:when test="${memberDto.memberLevel=='프리미엄'}">
								<span class="ms-2 badge bg-info">${memberDto.memberLevel}</span>
							</c:when>
							<c:otherwise>
								<span class="ms-2 badge bg-secondary">${memberDto.memberLevel}</span>
							</c:otherwise>
						</c:choose>
					</div></div>
					<div class="row ms-2"><div class="col">
						<i class="fa-solid fa-user-group"></i> 가입한 모임 : ${memberDto.memberMoimCount}
						<c:choose>
							<c:when test="${memberDto.memberLevel=='프리미엄'}">
								/ 10 개
							</c:when>
							<c:otherwise>
								/ 3 개
							</c:otherwise>
						</c:choose>
					</div></div> 
					<div class="row mt-5 ms-2"><div class="col">
						<c:choose>
							<c:when test="${memberDto.memberLevel == '프리미엄'}">
								<a href="${pageContext.request.contextPath}/pay/list" class="btn btn-primary w-100">보유중인 프리미엄</a>
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/pay?productNo=1" class="btn btn-primary">프리미엄 회원권 구매</a>
							</c:otherwise>
						</c:choose>
					</div></div>
					<div class="row mt-2 ms-2"><div class="col">
						<a href="${pageContext.request.contextPath}/member/change" class="btn btn-primary w-100">
							프로필 수정
						</a>	
					</div></div>
				</div>
				<div class="row"><div class="col">
					<hr>
				</div></div>
				<div class="row mt-2 text-center"><div class="col">
					<h3>참여중인 모임</h3>
				</div></div>
				<c:forEach var="moimDto" items="${moimList}">
					<div class="row mt-2"><div class="col">
						<div class="card border-dark mb-3">
							<div class="card-header">모임번호 : ${moimDto.moimNo}</div>
							  <div class="card-body">
							    <h4 class="card-title text-center">${moimDto.moimTitle}</h4>
							    	<div class="row mt-4">
							    		<div class="col">
									    	<a href="${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}" 
									    		class="btn btn-primary w-100">모임 상세</a>
							    		</div>
										<div class="col">
							    			<a href="${pageContext.request.contextPath}/default/${moimDto.chatRoomNo}" 
								    			class="btn btn-primary w-100">채팅방 입장</a>
								    	</div>
							  		</div>
							  	</div>
							</div>
					</div></div>
				</c:forEach>
			</div>
		</div>
	</div></div>
</div>
</div>

<script>
	

	
	/* imgae */
	$(function() {
		//파일이 바뀌면 프로필을 업로드하고 이미지 교체
		$(".profile-chooser").change(
				function() {
					//선택된 파일이 있는지 확인하고 없으면 중단
					//var input = document.querySelector(".profile-chooser");
					//var input = $(".profile-chooser")[0];
					var input = this;
					if (input.files.length == 0)
						return;

					//ajax로 multipart 업로드
					var form = new FormData();
					form.append("attach", input.files[0]);

					$.ajax({
						url : window.contextPath + "/rest/member/upload",
						method : "post",
						processData : false,
						contentType : false,
						data : form,
						dataType : "json",
						success : function(response) {
							//응답 형태 - { "attachNo" : 7 }
							console.log(response);

							//프로필 이미지 교체
							$(".profile-image").attr(
									"src",
									"/rest/member/download?attachNo="
											+ response.attachNo);
						},
						error : function() {
							window.alert("통신 오류 발생\n잠시 후 다시 시도해주세요");
						},
					});
				});
		//삭제아이콘을 누르면 프로필이 제거되도록 구현
		$(".profile-delete").click(function() {
			//확인창
			var choice = window.confirm("정말 프로필을 지우시겠습니까?");
			if (choice == false)
				return;

			//삭제요청
			$.ajax({
				url : window.contextPath + "/rest/member/delete",
				method : "post",
				success : function(response) {
					$(".profile-image").attr("src", "/images/profile.png");
				},
			});
		});
	});

	/* a태그클릭시 밑줄, 정보불러오기 */
	document.addEventListener('DOMContentLoaded', function() {
		var links = document.querySelectorAll('.container a');

		links.forEach(function(link) {
			link.addEventListener('click', function(event) {
				event.preventDefault(); // 기본 동작 방지
				links.forEach(function(otherLink) {
					otherLink.classList.remove('active');
				});
				link.classList.add('active');

				// 클릭된 링크의 태그 이름을 가져와서 출력 (여기서는 콘솔에 출력)
				var tag = link.getAttribute('data-tag');
				console.log('선택된 태그: ' + tag);

				// 이제 여기에 실제 정보를 불러오는 로직을 추가하세요.
				// 예를 들면, Ajax를 사용하여 서버에서 데이터를 가져오거나, 미리 정의된 데이터를 사용할 수 있습니다.

			});
		});
	});

	//회원정보변경
	function mypage() {

		window.location.href =window.contextPath +'/member/change';
	}
	//내가보유한카드리스트
	function Premium() {
		window.location.href = window.contextPath +'/pay?productNo=1';
	}


	/* 모임링크 클릭시  */
	$(function() {
		$(".moimList").click(
				function() {
					// Rest 호출
					$.ajax({
						url : window.contextPath + "/rest/moim/list",
						method : "post",
						dataType : "json", // JSON 형식으로 응답을 기대하는 경우 반드시 명시
						success : function(response) {
							console.log(response); // 확인용 출력

							// 기존 내용 삭제
							$(".moimListAppend").empty();
							// 예상대로 응답이 배열 형태인 경우
							for (var i = 0; i < response.length; i++) {

								// 각각의 moimNo에 맞는 URL을 생성
								var moimDetailUrl = window.contextPath
										+ "/moim/detail?moimNo="
										+ response[i].moimNo;

								// <a> 태그로 감싸진 <p> 태그를 append
								$(".moimListAppend").append(
										"<p><a href='" + moimDetailUrl + "'>"
												+ response[i].moimTitle + " ("
												+ response[i].moimMemberLevel
												+ ")" + "</a></p>");

							}

							// 예상대로 응답이 객체 형태인 경우
							// $(".moimListAppend").append("<p>" + response.moimName + "</p>");
							// 예시: response.moimName은 실제 데이터 구조에 맞게 변경
						},
						error : function(xhr, status, error) {
							console.error("Ajax 요청 에러:", status, error);
						},
					});
				});
	});
	
</script>

<script>
$(function() {
    $(".moimList").click(function() {
        // Rest 호출
    	$.ajax({
    	    url: window.contextPath + "/rest/moim/list",
    	    method: "post",
    	    dataType: "json", // JSON 형식으로 응답을 기대하는 경우 반드시 명시
    	    success: function(response) {
    	        console.log(response); // 확인용 출력

    	        // 기존 내용 삭제
                $(".moimListAppend").empty();
    	        // 예상대로 응답이 배열 형태인 경우
    	        for (var i = 0; i < response.length; i++) {
    	           


    	            // 각각의 moimNo에 맞는 URL을 생성
    	            var moimDetailUrl = window.contextPath + "/moim/detail?moimNo=" + response[i].moimNo;

    	            // <a> 태그로 감싸진 <p> 태그를 append
    	            $(".moimListAppend").append("<p><a href='" + moimDetailUrl + "'>" + response[i].moimTitle + " ("+response[i].moimMemberLevel+")" +"</a></p>");
    	            
    	        }

    	        // 예상대로 응답이 객체 형태인 경우
    	        // $(".moimListAppend").append("<p>" + response.moimName + "</p>");
    	        // 예시: response.moimName은 실제 데이터 구조에 맞게 변경
    	    },
    	    error: function(xhr, status, error) {
    	        console.error("Ajax 요청 에러:", status, error);
    	    },
    	});
    });
});

//'소개' 링크 클릭 시
document.addEventListener('DOMContentLoaded', function () {
  var links = document.querySelectorAll('.container a');

  links.forEach(function (link) {
    link.addEventListener('click', function (event) {
      event.preventDefault(); // 기본 동작 방지
      links.forEach(function (otherLink) {
        otherLink.classList.remove('active');
      });
      link.classList.add('active');

      // 클릭된 링크의 태그 이름을 가져와서 출력
      var tag = link.getAttribute('data-tag');
      console.log('선택된 태그: ' + tag);

      // '소개' 링크를 클릭하면 해당 내용을 summernote에 추가
      if (tag === '소개') {
        var introductionContent = '여기에 소개 내용을 작성하세요...';
        $('#summernote').summernote('code', introductionContent);
      }

      // 이제 여기에 실제 정보를 불러오는 로직을 추가하세요.
      // 예를 들면, Ajax를 사용하여 서버에서 데이터를 가져오거나, 미리 정의된 데이터를 사용할 수 있습니다.
    });
  });
});

// 나머지 JavaScript 코드는 그대로 유지합니다.

// 나머지 JavaScript 코드도 그대로 유지합니다.
//회원정보변경
function mypage() {
  window.location.href = window.contextPath + '/member/change';
}

//내가보유한카드리스트
function Premium() {
  window.location.href = window.contextPath + '/pay/list';
}
</script>





<jsp:include page="../template/Footer.jsp"></jsp:include>


