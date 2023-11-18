<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<style>
.jungmo-image {
	width: 200px;
}
.member-profile {
	width: 50px;
}
.profile-image {
	width:500px;
}

</style>

<title>모임 상세페이지</title>

<div class="container-fluid mb-5 pb-5">
	<div class="row">
		<div class="col-md-10 offset-md-1">
		
		
			<div class="jumbotron mt-5">
				<h1 class="display-4 bg-primary rounded text-light p-3">${moimDto.moimTitle}</h1>
				<div class="miom-content">${moimDto.moimContent}</div>
				<hr class="my-4" />
				<p>구현중입니다</p>
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


	<div class="card border-primary mb-3 items-center" style="max-width: 50rem;">
		<div class="card-body">


		${profile}
		${moimDto}
		<h1>모임 상세(사진, 모임명, 설명)</h1>
		${locationDto.locationDepth1}
		${locationDto.locationDepth2} ${eventDto.eventName}
		<div class="row"><div class="col">
		<a class="btn btn-primary" href="/default/${moimDto.chatRoomNo}">채팅방가기</a>
		
		</div></div>
		<div class="row"><div class="col">
		모임신고
		</div></div>
		<div class="row"><div class="col">
		<button class="moim-edit btn btn-primary">모임수정</button>
		</div></div>
		<div class="row"><div class="col">
		</div></div>
		<div class="row"><div class="col">
		좋아요
		<i class="fa-regular fa-heart fa-beat red"></i> 
		<span >?</span>
		</div></div>
		<div class="row"><div class="col">
		모임탈퇴
		</div></div>
		<div class="row"><div class="col">
		모임장승계?(어떻게구현할지고민해보자)
		</div></div>
		<div class="row"><div class="col">
		정모 등록할 때 날짜 형식검사 필요함(지난날짜 검사, 너무 먼 미래 검사)
		모임 가입할 때 여성전용은 여성만 가입하도록 ...조회한번해야함
		
		모임리스트에서 보여 줄 것
		모임정보(전부), 모임인원(moim_member 카운트), 모임종목명, 모임지역명(dept1, dept2), 사진, 
		좋아요수(member_like 카운트)
		</div></div>
		<c:if test="${moimDto.moimUpgrade == 'Y'}">
			<span class="badge bg-info gender-check">프리미엄</span>
		</c:if>
		<c:if test="${moimDto.moimGenderCheck == 'Y'}">
			<span class="badge bg-warning gender-check">여성전용</span>
			<input type="checkbox" name="moimGenderCheck" style="display:none;">
		</c:if>
		<div class="row"><div class="col">
				
		</div></div>
		
		<h1 class="text-primary">
		<a href="board/list?moimNo=${moimDto.moimNo}"
		class="btn btn-primary">게시판가기</a>
		</h1>		
		
		<h1>회원목록</h1>
		<c:forEach var="moimMemberDto" items="${memberList}">
		<div class="card-body">
		<c:choose>
			<c:when test="${moimMemberDto.attachNo} != null">
			<img src="/rest/attach/download?attachNo=${moimMemberDto.attachNo}">
			</c:when>
			<c:otherwise>
			<img class="member-profile rounded-circle bg-primary" src="/images/user.png">
			</c:otherwise>
		</c:choose>
		${moimMemberDto.memberEmail}
		${moimMemberDto.moimMemberLevel}
		${moimMemberDto.moimMemberStatus}
		${moimMemberDto.memberNick}
		${moimMemberDto.memberBlock}
<!-- 		<a href="" class="btn btn-danger">차단</a> -->
		<a href="memberApproval?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}" class="btn btn-info">승인</a>
		<a href="memberBlock?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}" class="btn btn-danger btn-block">
		차단</a>
		</div>
	</c:forEach>
			<hr>
<!-- 	<a class="btn btn-primary jungmo-create"  -->
<%-- 	href="detail?moimNo=${moimDto.moimNo}">정모등록</a>  --%>
		
			<button class="btn btn-primary jungmo-create"  type="button">정모등록</button>
			<hr>
			<h1>정모 List</h1>
			<!-- 			<button type="button" class="load-list">목록불러오기</button> -->
			<!-- 			<div class="list-group"></div> -->
			<h3 class="card-header">Card header</h3>
			<c:forEach var="jungmoList" items="${jungmoTotalList}">
				<div class="card mb-3">
					<div class="card-body">
					<div class="col-4">
						<img class="jungmo-image" src="/rest/attach/download?attachNo=${jungmoList.jungmoListVO.jungmoImageAttachNo}">
					</div>
					<div class="col-8">
<%-- 						${jungmoList} --%>
						정모번호 : ${jungmoList.jungmoListVO.jungmoNo}
						정모명 : ${jungmoList.jungmoListVO.jungmoTitle}
						상태 : ${jungmoList.jungmoListVO.jungmoStatus}
						인원 : ${jungmoList.jungmoListVO.memberCount} / ${jungmoList.jungmoListVO.jungmoCapacity}
						날짜 : ${jungmoList.jungmoListVO.jungmoSchedule}
						채팅방가기 <a class="btn btn-primary" href="/default/${jungmoList.jungmoListVO.chatRoomNo}">입장</a> 
						<h4 class="text-danger"> 
						<c:choose>
						<c:when test="${jungmoList.jungmoListVO.dday <= 0}">
							D - Day
						</c:when>
						<c:otherwise>
						D - ${jungmoList.jungmoListVO.dday}
						</c:otherwise>
						</c:choose>
						</h4>
					
					
<%-- 					<a class="btn btn-primary" href="jungmo/edit?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}" class="text-light">정모수정</a> --%>
					<button class="btn btn-primary jungmo-edit" type="button"
					data-jungmo-no="${jungmoList.jungmoListVO.jungmoNo}"
					>정모수정</button>
					<a class="btn btn-primary" 
					href="jungmo/join?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light">참가</a>
					<a class="btn btn-warning" 
					href="jungmo/exit?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light">취소</a>
					<a class="btn btn-warning" 
					href="jungmo/cancel?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}" class="text-light">정모취소</a>
                        
                        <div class="row">
                        <div class="col">
                        	<c:forEach var="jungmoMember" items="${jungmoList.jungmoMemberList}">
		                    <div class="card-body">
							<div class="col-4">
                       	 		<c:choose>
                       	 		<c:when test="${jungmoMember.attachNo} != null">
                       	 		<img src="/rest/attach/download?attachNo=${jungmoMember.attachNo}">
                       	 		</c:when>
 								<c:otherwise>
                       	 		<img class="member-profile rounded-circle bg-primary" src="/images/user.png">
 								</c:otherwise>
                       	 		</c:choose>
                       	 		${jungmoMember.memberEmail}      
                   	 		</div>
                  	 		</div>                 	 		
                    		</c:forEach>
                        </div>
                        </div>

					</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
</div>
</div>
			
<!-- 모달창 -->
<div class="modal fade" id="applicationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel ">모임 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <!-- 모임 수정내용 -->
      <div class="moim-edit-inputs" style="display: none;">
      <form id="appInsert" method="post" autocomplete="off">
      	<input type="hidden" name="moimNo" value="${moimDto.moimNo}"  class="form-control">
      	<input type="hidden" name="LocationNo" value="${moimDto.locationNo}"  class="form-control">
      	<input type="hidden" name="eventNo" value="${moimDto.eventNo}"  class="form-control">
      	<label class="form-label">모임명</label> 
      	<input type="text" name="moimTitle" data-original-value="${moimDto.moimTitle}" class="form-control">
      	<label class="form-label">모임소개</label> 
      	<input type="text" name="moimContent" data-original-value="${moimDto.moimContent}" class="form-control">
      	<label class="form-label">모임상태</label> 
      	<select name="moimState" data-original-value="${moimDto.moimState}" class="form-select">
      		<option>모집중</option>
      		<option>마감</option>
      	</select>
      	<c:if test="${moimDto.moimGenderCheck == 'Y'}">
      	<label class="form-check-label">여성전용모임해제</label>
      	<input type="checkbox"  id="moimGenderCheck" 
      	name="moimGenderCheck" ${moimDto.moimGenderCheck == 'N' ? 'checked' : ''}
      	data-original-value="${moimDto.moimGenderCheck}" class="form-check-input`">
      	</c:if>
      </form>
      </div>
      <!-- 정모 등록 내용 -->
      <div id="jungmoInsert" class="jungmo-create-inputs" style="display: none;">
		<form id="jungmoInsertForm" autocomplete="off" enctype="multipart/form-data" >
			<div class="preview-wrapper1"></div>
			<input type="file" name="attach" accept="image/*" multiple id="attach-selector" class="form-control">
			<input type="hidden" name="moimNo" value="${moimDto.moimNo}">
			<label class="form-label">정모명</label>
			<input type="text" name="jungmoTitle" class="form-control jungmo-create-inputs"> 
			<label class="form-label">장소</label>
			<input type="text" name="jungmoAddr" class="form-control jungmo-create-inputs"> 
			<label class="form-label">장소url</label>
			<input type="text" name="jungmoAddrLink" class="form-control jungmo-create-inputs"> 
			<label class="form-label">인원</label>
			<input type="text" name="jungmoCapacity" class="form-control jungmo-create-inputs"> 
			<label class="form-label">가격</label>
			<input type="number" name="jungmoPrice" class="form-control jungmo-create-inputs"> 
			<label class="form-label jungmo-create-inputs">일정</label>
			<input type="datetime-local" name="jungmoDto.jungmoScheduleStr" class=>
		</form>
      </div>
      
	<!-- 정모 수정 내용 -->
	<div class="jungmo-edit-inputs" style="display: none;">
    </div>
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="appBtn">모임수정</button>
        <button type="button" class="btn btn-primary" id="jungmoInsertBtn">정모등록</button>
        <button type="button" class="btn btn-primary" id="jungmoEditBtn">정모수정</button>
      </div>
    </div>
  </div>
</div>

    
    <c:if test="${sessionScope.name != null}">>
    <script>
    	//좋아요 처리
    	//[1] 페이지가 로드되면 비동기 통신으로 좋아요 상태를 체크하여 하트 생성
    	//[2] 하트에 클릭 이벤트를 설정하여 좋아요 처리가 가능하도록 구현
    	$(function(){
//     		var params = new URLSearchParams(location.search);
//     		var moimNo = params.get("moimNo");
//     		console.log(moimNo)
    		$.ajax({
    			url:"http://localhost:8080/rest/moim/likeCheck",
    			method:"post",
    			data:{moimNo : moimNo},
    			success:function(response) {
    				//response는 {"check":true, "count":0} 형태의 JSON이다
    				if(response.check){
    					$(".fa-heart").removeClass("fa-solid fa-regular")
    										.addClass("fa-solid");		
    				}
    				else {
    					$(".fa-heart").removeClass("fa-solid fa-regular").
    										addClass("fa-regular");		
    				}
    				//전달받은 좋아요 개수를 하트 뒤의 span에 출력
    				$(".fa-heart").next("span").text(response.count);
    			}
    		});

    		//[2]
    		$(".fa-heart").click(function() {
    			$.ajax({
    				url:"http://localhost:8080/rest/moim/likeAction",
    				method:"post",
    				data:{moimNo : moimNo},
    				success:function(response) {
    					if(response.check){
    						$(".fa-heart").removeClass("fa-solid fa-regular")
    											.addClass("fa-solid");		
    					}
    					else {
    						$(".fa-heart").removeClass("fa-solid fa-regular").
    											addClass("fa-regular");		
    					}
    					//전달받은 좋아요 개수를 하트 뒤의 span에 출력
    					$(".fa-heart").next("span").text(response.count);
    				}
    			});
    			
    		});
    	});
    </script>

    </c:if>	
			
<body>
	<c:if test="${param.errorFlag != null}">
	    <script>
	    alert("인원이 꽉 찼습니다.");
	    window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
	    </script>
	</c:if>
	<c:if test="${param.block != null}">
	    <script>
	    alert("차단했습니다.");
	    window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
	    </script>
	</c:if>
	<c:if test="${param.approval != null}">
	    <script>
	    alert("승인완료");
	    window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
	    </script>
	</c:if>
</body>

<script>

// 	$(document).ready(function () {
// 	    loadJungmoList();
// 	});
	    // 클라이언트 측에서 errorFlag를 확인하여 alert를 띄웁니다.

	var moimNo = "${moimDto.moimNo}";
	$(".profile-chooser").change(function(){

		var input = this;
		if(input.files.length == 0) return;
		
		//ajax로 multipart 업로드
		var form = new FormData();
		form.append("attach", input.files[0]);
		form.append("moimNo", moimNo);
		//만일 정모이미지를 변경한다면?
// 		form.append("jungmoNo", jungmoNo);
		
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
			data:{moimNo: moimNo},
			success:function(response){
				$(".profile-image").attr("src", "/images/user.png");
			},
		});
	});
	
	$("#moimGenderCheck").on("change", function() {
	    // 체크박스가 체크되어 있다면 'N', 체크되어 있지 않다면 'Y' 값을 설정
		if (this.checked) {
			this.value = 'N';
			alert("여성모임을 해제하면 다시 변경이 어렵습니다.");
        } else {
            this.checked = true; // 체크를 해제하지 못하게 함
        }
	});

//     $(".gender-check").click(function(){
//         // 여성전용을 나타내는 span이 클릭되면
//         // 해당하는 체크박스를 토글
//         $("[name=moimGenderCheck]").show();

//         // 체크박스 상태에 따라 서버로 값을 전송
//         var isChecked = $("[name=moimGenderCheck]").prop("checked");
//         var valueToSend = isChecked ? "N" : "Y";

//         // AJAX를 사용하여 서버로 데이터 전송
//         //모임번호랑, 체크여부를 보내면 될 듯 Y면 여성전용 해제..인걸로!
// 		var vo = {
// 			moimGenderCheck: valueToSend,
// 			moimNo: moimNoValue
// 		};
        
//         $.ajax({
//             url: "http://localhost:8080/rest/moim/genderCheck",
//             type: "POST",
//             data: vo,
//             success: function (response) {
//                 if(response == success) {
//                 	$("[name=moimGenderCheck]").hide();                	
//                 }
//             },
//         });
//     });
    var Modal = new bootstrap.Modal(document.getElementById('applicationModal'));
	 
    $("#appBtn").click(function(){

		 var formData = $("#appInsert").serialize();

		 $.ajax({
               url: "http://localhost:8080/rest/moim/infoChange",
               type: "POST",
               data: formData,
               success: function (data) {
                   // 서버 응답에 따른 동작 수행
                  console.log(data); 
             	    alert("변경완료");
                	window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
               },
               error: function (error) {
                   // 오류 발생 시 동작 수행
                   console.error(error);
                   console.error("에러");
               }
           });
 
       });
    
    $("#jungmoInsertBtn").click(function(){

    	var formData = new FormData(document.getElementById("jungmoInsertForm"));
    	
		 $.ajax({
               url: "http://localhost:8080/rest/moim/jungmo/create",
               type: "POST",
               data: formData,
               contentType: false,
               processData: false,
               success: function (data) {
                   // 서버 응답에 따른 동작 수행
                  console.log(data); 
             	    alert("등록완료");
                	window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
               },
               error: function (error) {
                   // 오류 발생 시 동작 수행
                   console.error(error);
                   console.error("에러");
               }
           });
 
       });
    
    
    
// $("#appBtn").click(function () {
//   var dataToSend = {};

//   // input, select 요소에 대해 처리
//   $("#appInsert input, #appInsert select, #appInsert input[type='checkbox']").each(function () {
//     var originalValue = $(this).data("original-value");
//     var currentValue = $(this).val();

//     // input 타입이 checkbox인 경우에 대한 처리
//     if ($(this).is("input[type='checkbox']")) {
//       currentValue = this.checked ? 'N' : 'Y';

//     }

//     // 입력값이 있고, 현재 값이 원래 값과 다르면 객체에 추가
//     if (currentValue.length !== 0 && currentValue !== originalValue) {
//       dataToSend[$(this).attr("name")] = currentValue;
//     }
//   });
//   console.log(dataToSend);
//   // AJAX를 사용하여 서버로 데이터 전송
//   $.ajax({
//     url: "http://localhost:8080/rest/moim/infoChange",
//     type: "POST",
//     data: dataToSend,
//     success: function (data) {
//       // 서버 응답에 따른 동작 수행
//       console.log(data);
//       alert("변경완료");
//       window.location.href = "/moim/detail?moimNo=${moimDto.moimNo}";
//     },
//     error: function (error) {
//       // 오류 발생 시 동작 수행
//       console.error(error);
//       console.error("에러");
//     }
//   });
// });

	//모달창으로 모임 수정
    $(".moim-edit").click(function(){
        // 모든 input, select, checkbox 필드에 대해 초기화
        $("#appInsert input:not([type='hidden']), #appInsert select").each(function () {
          var originalValue = $(this).data("original-value");
          if ($(this).is("select")) {
            // select는 선택된 옵션으로 초기화
            $(this).val(originalValue);
          } 
          else if ($(this).is("input[type='checkbox']")) {
              // checkbox는 checked 상태로 초기화
              $(this).prop("checked", originalValue === "N");
          }
          else {
            // 나머지는 값으로 초기화
            $(this).val(originalValue);
          }
        });
    	
        $("#applicationModal").modal("show");
    });

    // 등록 버튼 클릭 시 모달 닫기
    $("#appBtn").click(function(){
        $("#applicationModal").modal("hide");
    });
    
    //모임수정버튼 눌렀을 때 모달창 띄우고 나머지 숨김
    $('.moim-edit').click(function () {
    	$("#applicationModal").modal("show");
        $('.moim-edit-inputs').show();
        $('.jungmo-create-inputs').hide();
        $('.jungmo-edit-inputs').hide();
        $('#appBtn').text('수정'); // 버튼 텍스트를 '수정'으로 변경
        $('.modal-title').text('모임수정'); // 버튼 텍스트를 '수정'으로 변경
      });
    //정모등록버튼 눌렀을 때 
    $('.jungmo-create').click(function () {
    	$('.jungmo-create-inputs input[type!="hidden"]').val('');
    	$("#applicationModal").modal("show");
        $('.moim-edit-inputs').hide();
        $('.jungmo-create-inputs').show();
        $('.jungmo-edit-inputs').hide();
        $('#appBtn').text('등록'); // 버튼 텍스트를 '등록'으로 변경
        $('.modal-title').text('정모등록'); // 버튼 텍스트를 '수정'으로 변경
      });
    
    //정모수정버튼 눌렀을 때
    $('.jungmo-edit').click(function () {
    	$("#applicationModal").modal("show");
        $('.moim-edit-inputs').hide();
        $('.jungmo-create-inputs').hide();
        $('.jungmo-edit-inputs').show();
        $('#appBtn').text('수정'); // 버튼 텍스트를 '수정'으로 변경
        $('.modal-title').text('정모수정'); // 버튼 텍스트를 '수정'으로 변경
      });

    //사진 미리보기
    $(function(){
        $("#attach-selector").change(function(){
        	 $(".preview-wrapper1").empty();
        	
        	 if(this.files.length == 0) {
                //초기화
                return;
            }
            

            //파일 미리보기는 서버 업로드와 관련이 없다
            //- 서버에 올릴거면 따로 처리를 또 해야 한다

            //[1] 자동으로 생성되는 미리보기 주소를 연결
//             for(let i=0; i < this.files.length; i++) {
//                 $("<img>").attr("src", URL.createObjectURL(this.files[i]))
//                                 .css("max-width", "300px")
//                                 .appendTo(".preview-wrapper1");
//             }
            
            //[2] 직접 읽어서 내용을 설정하는 방법
            let reader = new FileReader();
            reader.onload = ()=>{
                $("<img>").attr("src", reader.result)//data;로 시작하는 엄청많은 실제이미지 글자
                                .css("max-width", "300px")
                                .appendTo(".preview-wrapper1");
            };
            for(let i=0; i < this.files.length; i++) {
                reader.readAsDataURL(this.files[i]);
            }
        });
    });
    
    
    
//     $('.blockButton').click(function () {
//         // 클릭된 버튼의 데이터 속성을 통해 이메일 값을 가져옴
//         var memberEmail = $(this).data('member-email');
// 		console.log(memberEmail);
		
        
//         // AJAX 요청
//         $.ajax({
//             type: 'POST', // 또는 'GET'
//             url: "http://localhost:8080/rest/moim/memberBlock", // 실제 서버 엔드포인트로 대체해야 함
//             data: { memberEmail: memberEmail },
//             success: function (response) {
//                 // 성공 시 수행할 동작
//                 if(response == "Y") {
//                 console.log(response);
//                 	window.alert("차단함");
//                 }
//             },
//             error: function (error) {
//                 // 오류 발생 시 수행할 동작
//                 console.log(error);
//             }
//         });
//     });
	
	//회원 정모 참여
// 	$(".btn-join").click(function() {
		
// 		var myId = "${sessionScope.name}";
// 		var jungmoNo = parseInt($(this).closest(".card").find(".jungmo-no").text().trim(), 10);
		
// 		$.ajax({
// 			url:"http://localhost:8080/rest/moim/join",
// 			method:"post",
// 			contentType:"application/json",
// 			data: JSON.stringify({
// 				memberEmail:myId,
// 				jungmoNo:jungmoNo
// 			}),
// 			success:function(response) {
// 				alert("참가신청이 완료되었습니다.");
// 			}
// 		});		
// 	});
	
	
    // 정모목록을 로드하는 함수
//     function loadJungmoList() {      
//     	var moimNo = "${moimDto.moimNo}";  	    	
//     	$.ajax({
//             type: 'POST',
//             url: 'http://localhost:8080/rest/moim/list', 
//             data: {moimNo: moimNo},
//             dataType: 'json',
//             success: function (data) {     
// 				$.each(data, function(index, data) { 
// 				    var listItem = $("<a>").addClass("list-group-item list-group-item-action flex-column align-items-start");

// 				    var headerDiv = $("<div>").addClass("d-flex w-100 justify-content-between");
// 				    headerDiv.append("<h5 class='mb-1'>" + data.jungmo_title + "</h5>");
// 				    headerDiv.append("<small class='text-muted'>" + data.jungmo_schedule + "</small>");
					
// 				    var image = $("<img>").attr("src", "/rest/attach/download?attachNo="+data.attach_no).addClass("img-fluid rounded "); // 이미지의 경로나 URL을 지정하세요.
// 				    listItem.append(headerDiv);
// 				    listItem.append(image); // 이미지 추가
				    
// 				    listItem.append(headerDiv);
// 				    listItem.append("<p class='mb-1'>" + data.jungmo_addr + "</p>");
// 				    listItem.append("<small>" + data.jungmo_capacity + "</small>");

// 				    $(".list-group").append(listItem);
// 				});
//             },
//             error: function () {
//                 alert('Jungmo 목록을 로드하는 중 오류가 발생했습니다.');
//             }
//         });
//     }

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
//    $('.load-list').click(function () {
//        loadJungmoList();
//    });

	
</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>