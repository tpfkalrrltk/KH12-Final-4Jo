<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 부트스트랩 CSS 파일 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- 부트스트랩 Icons CSS 파일 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.19.0/font/bootstrap-icons.css" rel="stylesheet">
<jsp:include page="../template/Header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>
.box {
	margin: 20px;
	padding: 30px;
	border: 1px solid #118ab2;
	border-radius: 14px;
}

text {
	text-decoration: none;
	color: white;
}

.container a {
    text-decoration: none;
    color: #007BFF;
}

.container a:hover {
    text-decoration: underline;
}

.container a.active {
    text-decoration: underline !important;
    color: #ee6c4d !important;
}

/* .editable-content {
	border: 1px solid #1C1C1C;
	padding: 10px;
	min-height: 100px;
	color: #A4A4A4;
} */

</style>








<!-- ---------------------------------------------------------------------------------------- -->


<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">



			<div class="container text-center mt-5 box">
				<div class="row">
					<div class="col align-self-start">
						<div>

							<c:choose>
								<c:when test="${profile == null }">
									<div class="p-2">
										<img src="/images/profile.png"
											class="image image-circle image-border profile-image"
											style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">
									</div>
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${profile}"
										class="image image-circle image-border profile-image"
										style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">

								</c:otherwise>
							</c:choose>

							<c:choose>

								<c:when test="${memberDto.memberLevel == '프리미엄'}">
									<div>
										<span class="badge bg-info">프리미엄 회원</span>
									</div>
								</c:when>
							</c:choose>

							<div class="d-flex flex-column mb-3 mt-1">
								<div class="p-2">
									<label> <input type="file" class="profile-chooser "
										accept="image/*" style="display: none;"><i class="fa-solid fa-camera-retro blue fa-2x"></i>
									</label> <i class="ms-2 fa-regular fa-trash-can red fa-2x profile-delete"></i>

								</div>
							</div>
						</div>

					</div>


					<div class="col align-self-center d-flex">
						<div class="d-flex flex-column ">

       
                 <div class="p-2 flex-fill text-start">
						<c:if test="${memberDto.memberLevel == '프리미엄'}">
							<span class="badge bg-success btn btn-success" >프리미엄 회원</span>
						</c:if>
						</div>
							<div class="p-2 flex-fill text-start">

								<i class="fa-solid fa-user-tag" style="color: #118ab2;"> :
									${memberDto.memberNick}</i>

							</div>
							<div class="p-2 mt-2 text-start">
								<i class="fa-solid fa-user-group" style="color: #118ab2;"> :
									${memberDto.memberMoimProduce} 개</i>
							</div>

						</div>
					</div>

					<div class="col align-self-end">
						<div>
							<c:choose>
								<c:when test="${memberDto.memberLevel == '프리미엄'}">
									<button class="btn btn-primary w-100 ">
										<a onclick="Premium()"
											style="text-decoration: none; color: white;">보유중인 프리미엄</a>
									</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-primary w-100 ">
										<a onclick="Premium()"
											style="text-decoration: none; color: white;">프리미엄 회원권
											구매하기</a>
									</button>
								</c:otherwise>
							</c:choose>
						</div>

						<div>
							<button class="btn btn-primary mt-2 w-100">
								<a onclick="mypage()"
									style="text-decoration: none; color: white;">프로필 등록/수정</a>
							</button>
						</div>

						<div></div>
					</div>
				</div>
			</div>

			<!-- <textarea id="summernote"></textarea> -->
			<div class="container text-center mt-3 box">
				<div class="d-flex">
				<!-- 	<p>
						<a href="#"
							class="summernote link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
							data-tag="소개">소개</a>
					</p> -->

					<p>
						<a 
							class="moimList link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3"
							data-tag="모임"> 모임 </a>
					</p>
					<!-- <p>
						<a href="#"
							class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3"
							data-tag="정모">정모</a>
					</p>
					<p>
						<a href="#"
							class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3"
							data-tag="리그">리그</a>
					</p> -->

				</div>
				<div>
					<hr>
					<div class="moimListAppend"></div>
				</div>
			</div>

		</div>
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
			var choice = window.confirm("프로필을 삭제하시겠습니까?");
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
    var moimListAppended = false;

    // 모임 목록을 닫는 함수
    function closeMoimList() {
        // 기존 내용 삭제
        $(".moimListAppend").empty();
        // 추가된 상태를 해제
        moimListAppended = false;
    }

    // 모임 목록 클릭 이벤트
    $(".moimList").click(function() {
        // 모임 목록이 띄워진 상태인 경우
        if (moimListAppended) {
            // 모임 목록 닫기
            closeMoimList();
        } else {
            // 모임 목록 열기
            // Rest 호출
            $.ajax({
                url: window.contextPath + "/rest/moim/list",
                method: "post",
                dataType: "json",
                success: function(response) {
                    console.log(response);

                    // 기존 내용 삭제
                    $(".moimListAppend").empty();

                    // 예상대로 응답이 배열 형태인 경우
                    for (var i = 0; i < response.length; i++) {
                        var moimDetailUrl = window.contextPath + "/moim/detail?moimNo=" + response[i].moimNo;

                        $(".moimListAppend").append("<p><a href='" + moimDetailUrl + "'>" +
                            response[i].moimTitle + " (" + response[i].moimMemberLevel + ")" + "</a></p>");
                    }

                    // 추가된 상태로 변경
                    moimListAppended = true;
                },
                error: function(xhr, status, error) {
                    console.error("Ajax 요청 에러:", status, error);
                },
            });
        }
    });

    // 모임 목록 닫기 이벤트
    $(document).on('click', function(event) {
        // 클릭한 요소가 .moimList 또는 .moimListAppend의 자손이 아닌 경우 모임 목록 닫기
        if (!$(event.target).closest('.moimList, .moimListAppend').length) {
            closeMoimList();
        }
    });
});
	
</script>

<script>
/* $(function() {
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
}); */

//'소개' 링크 클릭 시
/* document.addEventListener('DOMContentLoaded', function () {
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
 */
//회원정보변경
function mypage() {
  window.location.href = window.contextPath + '/member/change';
}

//내가보유한카드리스트
function Premium() {
  window.location.href = window.contextPath + '/pay/list';
}

var quill = new Quill('#editor', {
    theme: 'snow'
  });
</script>





<jsp:include page="../template/Footer.jsp"></jsp:include>



$(function() {
    var moimListAppended = false;

    // 모임 목록을 닫는 함수
    function closeMoimList() {
        // 기존 내용 삭제
        $(".moimListAppend").empty();
        // 추가된 상태를 해제
        moimListAppended = false;
    }

    // 모임 목록 클릭 이벤트
    $(".moimList").click(function() {
        // 모임 목록이 띄워진 상태인 경우
        if (moimListAppended) {
            // 모임 목록 닫기
            closeMoimList();
        } else {
            // 모임 목록 열기
            // Rest 호출
            $.ajax({
                url: window.contextPath + "/rest/moim/list",
                method: "post",
                dataType: "json",
                success: function(response) {
                    console.log(response);

                    // 기존 내용 삭제
                    $(".moimListAppend").empty();

                    // 예상대로 응답이 배열 형태인 경우
                    for (var i = 0; i < response.length; i++) {
                        var moimDetailUrl = window.contextPath + "/moim/detail?moimNo=" + response[i].moimNo;

                        $(".moimListAppend").append("<p><a href='" + moimDetailUrl + "'>" +
                            response[i].moimTitle + " (" + response[i].moimMemberLevel + ")" + "</a></p>");
                    }

                    // 추가된 상태로 변경
                    moimListAppended = true;
                },
                error: function(xhr, status, error) {
                    console.error("Ajax 요청 에러:", status, error);
                },
            });
        }
    });

    // 모임 목록 닫기 이벤트
    $(document).on('click', function(event) {
        // 클릭한 요소가 .moimList 또는 .moimListAppend의 자손이 아닌 경우 모임 목록 닫기
        if (!$(event.target).closest('.moimList, .moimListAppend').length) {
            closeMoimList();
        }
    });
});