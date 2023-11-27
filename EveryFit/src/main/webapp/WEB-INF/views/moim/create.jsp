<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<style>
    textarea {
        resize: none;
    }
    .preview-wrapper1 {
    	object-fit:cover;
    	z-index: 9999;
    }
</style>
<title>등록해보기</title>


  <div class="col-md-8 offset-md-2">
    <div class="row">
      <div class="col">
		<div class="row">
		<div class="col-6 offset-3 text-start text-primary">
		<h1>모임개설</h1>
		</div>
		</div>
<div class="row">
<!--  라벨을 만들고 파일선택창을 숨김 -->
<form method="post" enctype="multipart/form-data" autocomplete="off" >

	<div class="row mt-4 mb-4">
		<div class="col-6 offset-3">
		<label>
		<input type="file" name="attach" accept="image/*" multiple id="attach-selector" style="display:none;">
		
		<div class="preview-wrapper1" width="300px;" height="200px;">
		<img src="/images/add-moim-image.png" class="w-100 image">
		</div>
		</label>
		</div>
		</div>
	
		<div class="row mt-2">
<!-- 		<div class="col-3 text-end"><label class="form-label ">모임명</label></div> -->
		<div class="col-6 offset-3"><input type="text" name="moimTitle" class="form-control" placeholder="모임명"></div>
		</div>
		
		<div class="row mt-2">
<!-- 		<div class="col-3 text-end"> -->
<!-- 		<label class="form-label">시/도</label></div> -->
		<div class="col-6 offset-3">
		<select class="form-select location-depth1">
			<option value="">시/도</option>
			<c:forEach var="locationDto" items="${locationList}">
				<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
			</c:forEach>
		</select></div>
		</div>
		<div class="row mt-2">
<!-- 		<div class="col-3 text-end"> -->
<!-- 		<label class="form-label">구/시 선택</label></div> -->
		<div class="col-6 offset-3"><select class="form-select" name="locationNo">
			<option value="">시/군/구</option>
		</select>
  		</div></div>

		<div class="row mt-2">
<!-- 		<div class="col-3 text-end"><label class="form-label">종목</label></div> -->
		<div class="col-6 offset-3">
		<select name="eventNo"  class="form-select" id="eventSelect">
             <option value="">종목</option>
		         <c:forEach var="event" items="${eventList}">
		             <option value="${event.eventNo}">${event.eventName}</option>
		         </c:forEach>
	     </select>
		</div>
		</div>
		
		<div class="row mt-2">
	 	<div class="col-6 offset-3"><textarea rows="5" class="form-control" name="moimContent">모임소개</textarea></div>
	 	</div>
		<div class="row mt-2">
	 	<div class="col-3 offset-3 text-end p-2"><label class="form-label">정원(~30명)</label></div>
	 	<div class="col-3">
	 	<input type="number" name="moimMemberCount" class="form-control" id="moimMemberCount"></div>
	 	</div>
		<div class="row mt-2">
	 	<div class="col-6 offset-3 text-end"><label class="form-label">여성전용</label>
		<input type="checkbox"  id="moimGenderCheck" value="Y" 
		name="moimGenderCheck" class="form-check-input">
		</div>
	 	</div>
		<div class="row mt-2">
		<div class="col-6 offset-3">
		<button type="submit" class="btn btn-primary w-100">등록</button>
		</div>
	 	</div>

</form>
</div>


</div>
</div>
</div>

<script>
		
    $(function(){
        $("#attach-selector").change(function(){
        	 $(".preview-wrapper1").empty();
        	
        	 if(this.files.length == 0) {
                //초기화
                return;
            }

            let reader = new FileReader();
            reader.onload = ()=>{
                $("<img>").attr("src", reader.result)//data;로 시작하는 엄청많은 실제이미지 글자
//                                 .css("max-width", "300px")
								.addClass("w-100, img-thumbnail")
                                .appendTo(".preview-wrapper1");
            };
            for(let i=0; i < this.files.length; i++) {
                reader.readAsDataURL(this.files[i]);
            }
            
            $(".image").hide();
        });
    });
	
	$(".location-depth1").change(function(e){
			var locationDepth1 = e.target.value;
			
			$.ajax({
				url:"http://localhost:8080/rest/location/depth2List",
				type:"post",
				data:{locationDepth1:locationDepth1},
				success:function (data){
					var select = $("[name=locationNo]");
					
					select.empty();
					select.append('<option value="">시/군/구</option>');
					$.each(data, function(index, locationDto){
						var depth2Value = locationDto.locationDepth2;
						var locationNo = locationDto.locationNo;
						select.append('<option value="' + locationNo + '">' + depth2Value + '</option>');
					});
				},
				error:function(){
					alert('주소 로딩중 서버 에러 발생');
				}
			});
		});
	
    $("#moimGenderCheck").change(function() {
    //여성회원전용 체크박스를 선택하면 ajax로 회원 세션을 넘겨서 
    //그 회원의 정보를 조회 한 후 여성이라면 체크 가능하도록
  	var memberEmail = "${sessionScope.name}";
	    if ($(this).is(":checked")) {
	        // 여성회원 전용 체크박스가 체크되었을 때만 Ajax 요청을 보냄
	        $.ajax({
	            type: "POST",
	            url: "http://localhost:8080/rest/moim/checkGender", // 서버 엔드포인트 URL을 적절히 수정
	            data: { memberEmail : memberEmail }, // 필요한 데이터를 전송 (세션 등)
	            success: function(response) {
	                // 서버에서의 응답을 확인하여 처리
	                if (response === "female") {
	                    // 여성인 경우에만 체크를 가능하도록 처리
	                    $("#moimGenderCheck").prop("disabled", false);
	                } else {
	                    // 여성이 아닌 경우 체크를 비활성화
	                    $("#moimGenderCheck").prop("checked", false);
	                    alert("여성 회원만 해당 옵션을 선택할 수 있습니다.");
	                }
	            },
	            error: function(error) {
	                console.error("Ajax 요청 중 에러 발생:", error);
	            }
	        });
	    }
   
    });
    
    document.getElementById("moimMemberCount").addEventListener("input", function() {
        // 현재 입력된 값 가져오기
        var inputValue = this.value;

        // 최소값(min)과 최대값(max) 설정
        var minValue = 1;
        var maxValue = 30;

        // 입력값이 최소값 미만이면 최소값으로 설정
        if (inputValue < minValue) {
            this.value = minValue;
        }

        // 입력값이 최대값 초과하면 최대값으로 설정
        if (inputValue > maxValue) {
            this.value = maxValue;
        }
    });	
    
    // jQuery 코드로 선택 옵션의 변경을 감지하고 알림창을 띄웁니다.
    $(document).ready(function () {
        $("#eventSelect").change(function () {
            // 현재 선택된 값 가져오기
            var selectedValue = $(this).val();

            // 선택된 값이 빈 문자열인 경우 알림창 띄우기
            if (selectedValue === "") {
                alert("종목을 선택해주세요.");
            }
        });
    });
    

 </script> 