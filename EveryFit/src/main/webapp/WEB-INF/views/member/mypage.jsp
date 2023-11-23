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

text{
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
      text-decoration: underline;!important;/* 클릭된 링크에만 밑줄 효과 유지 */
    color: ee6c4d !important; /* 원하는 색상으로 변경 */
    }

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
									<img src="/rest/attach/download?attachNo=${profile}"
										class="image image-circle image-border profile-image"
										style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden; color: #5598b4;">

								</c:otherwise>
							</c:choose>
<c:choose>
												
						<c:when test="${memberDto.memberLevel == '프리미엄'}">
							<div><span class="badge bg-info" >프리미엄 회원</span>
						</div></c:when>
						</c:choose>
							<div class="d-flex flex-column mb-3 mt-1">
								<div class="p-2">
									<label> <input type="file" class="profile-chooser "
										accept="image/*" style="display: none;"> <i
										class="fa-solid fa-camera blue fa-2x"></i>
									</label> <i class="ms-2 fa-solid fa-trash-can red fa-2x profile-delete"></i>

								</div>
							</div>
						</div>

					</div>


					<div class="col align-self-center d-flex">
						<div class="d-flex flex-column ">
						<div class="p-2 flex-fill text-start">
						
						<i class="fa-solid fa-user-tag fa-2x" style="color: #34b79d;">  : ${memberDto.memberNick}</i>
												
						</div>
						<div class="p-2 mt-4">
						<i class="fa-solid fa-people-group  fa-2x" style="color: #34b79d;"> : 개</i>
						</div>
						</div>
					</div>
					
					<div class="col align-self-end">
						<div>
						<c:choose>
						<c:when test="${memberDto.memberLevel == '프리미엄'}">
							<button class="btn btn-success w-50 ">
								<a onclick="Premium()" style="text-decoration:none; color:white;">보유중인 프리미엄</a>						
							</button>
						</c:when>
						<c:otherwise>
							<button class="btn btn-success w-50 ">
								<a onclick="Premium()" style="text-decoration:none; color:white;">프리미엄 회원권 구매하기</a>						
							</button>
						</c:otherwise>
						</c:choose>
						</div>

						<div>
							<button class="btn btn-info mt-2 w-50">
								<a onclick="mypage()" style="text-decoration:none; color:white;">프로필 등록/수정</a>
							</button>
						</div>

						<div>
							<!-- 	
						 Button trigger modal
							<button type="button" class="btn btn-info mt-2"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								프로필 등록/수정</button>
 -->
							<!-- Modal -->
							<%-- <div class="modal fade" id="exampleModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h1 class="modal-title fs-5" id="exampleModalLabel">회원정보
												등록/수정</h1>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div>
												email<input value="${memberDto.memberEmail}" disabled>
											</div>

											<div>
												pw<input type="password" value="${memberDto.memberPw}" disabled>
												<button class="btn btn-warning" id="changePasswordButton">변경</button>
											</div>

											<div>
												name<input value="${memberDto.memberName}" disabled>
											</div>

											<div>
												nick<input value="${memberDto.memberNick}" disabled>
											</div>

											<div>
												gender<input  value="${memberDto.membergender}">
											</div>

											<div>
												contact<input value="${memberDto.memberContact}" disabled>
											</div>

											<div>
												birth<input type="date" value="${memberDto.memberBirth}" disabled>
											</div>



										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>  --%>
						</div>
					</div>
				</div>
			</div>


			<div class="container text-center mt-3 box">
				<div class="d-flex">
					 <p><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover" data-tag="소개">소개</a></p>
     				 <p><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3" data-tag="모임">모임</a></p>
				     <p><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3" data-tag="정모">정모</a></p>
				     <p><a href="#" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover ms-3" data-tag="리그">리그</a></p>
				</div>
				<div>
				<hr>
				</div>
			</div>

		</div>
	</div>
</div>





<%-- <table>
		<tr>
		
			<th>email</th>
			<td>${memberDto.memberEmail}</td>
			
			<th>pw</th>
			<td>${memberDto.memberPw}</td>
			
			<th>name</th>
			<td>${memberDto.membername}</td>
			
			<th>nick</th>
			<td>${memberDto.memberNick}</td>
			
			<th>gender</th>
			<td>${memberDto.membeGgender}</td>
			
			<th>contact</th>
			<td>${memberDto.memberContact}</td>
			
			<th>birth</th>
			<td>${memberDto.memberBirth}</td>
		
		</tr>
	</table> --%>

<script>
	$(function() {
		$(".open-modal-btn").click(
				function() {
					//$("#exampleModal").modal("show");//표시
					//$("#exampleModal").modal("hide");//숨김

					var modal = new bootstrap.Modal(document
							.querySelector("#exampleModal"));
					modal.show();
				});
	});

	/* 비밀번호 변경  */
	$(document).ready(function() {
		$("#changePasswordButton").click(function() {
			var newPassword = prompt("새로운 비밀번호를 입력하세요:");
			if (newPassword !== null && newPassword !== "") {
				changePassword(newPassword);
			}
		});

		function changePassword(newPassword) {
			// 서버로 비밀번호 변경 요청을 보내는 AJAX 호출
			$.ajax({
				url : "/changePassword", // 비밀번호 변경을 처리하는 서버 엔드포인트 URL
				type : "POST", // HTTP POST 요청
				data : {
					newPassword : newPassword
				}, // 변경할 비밀번호
				success : function(response) {
					alert("비밀번호가 성공적으로 변경되었습니다.");
				},
				error : function(xhr, status, error) {
					console.error("비밀번호 변경 실패: " + error);
				}
			});
		}
	});

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
	document.addEventListener('DOMContentLoaded', function () {
      var links = document.querySelectorAll('.container a');

      links.forEach(function (link) {
        link.addEventListener('click', function (event) {
          event.preventDefault(); // 기본 동작 방지
          links.forEach(function (otherLink) {
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
        window.location.href = '/member/change';
    }
	//내가보유한카드리스트
	function Premium() {
        window.location.href = '/pay/list';
    }
	
</script>


<jsp:include page="../template/Footer.jsp"></jsp:include>


