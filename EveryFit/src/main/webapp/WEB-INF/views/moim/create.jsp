<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>


<title>등록해보기</title>

<c:choose>
	<c:when test="${moimDto != null}">
		<h1>모임수정</h1>
<div class="container-fluid col-8 offset-2">
<div class="row mt-4">
<div class="card border-primary mb-3" style="max-width: 100rem;">
</div></div></div>
	</c:when>
	<c:otherwise>
		<h1>모임등록</h1>
	</c:otherwise>
</c:choose>

<div class="row mt-4">
	<c:if test="${profile != null}">
	<img src="/rest/attach/download?attachNo=${profile}"
			class="rounded profile-image">		
	</c:if>
<!--  라벨을 만들고 파일선택창을 숨김 -->
<form method="post" enctype="multipart/form-data" autocomplete="off" >
	<div class="row mt-4">
		<label>
		<input type="file" name="attach" accept="image/*" multiple id="attach-selector" >
		
		<i class="fa-solid fa-user fa-2x"></i>
		</label>
		<i class="fa-solid fa-trash-can fa-2x profile-delete"></i>
		<div class="preview-wrapper1"></div>
	</div>

    <div class="row mt-4"><div class="col">
		<label class="form-label">시/도</label>
		<select class="form-select location-depth1">
			<option value="">시/도</option>
			<c:forEach var="locationDto" items="${locationList}">
				<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
			</c:forEach>
		</select>
		<label class="form-label">구/시 선택</label>
		<select class="form-select" name="locationNo">
			<option value="">시/도</option>
		</select>
    </div></div>

     <br>
     종목 
     <select name="eventNo">
         <c:forEach var="event" items="${eventList}">
             <option value="${event.eventNo}">${event.eventName}</option>
         </c:forEach>
     </select>
	모임명<input type="text" name="moimTitle" placeholder="${moimDto.moimTitle}">
	모임설명<input type="text" name="moimContent" placeholder="${moimDto.moimContent}">
	<input type="hidden" name="moimMemberCount" value=30>
	
	여성전용 <input type="checkbox" name="moimGenderCheck">
	<button type="submit">등록</button>
</form>
</div>


<script>
		
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
	
	$(".location-depth1").change(function(e){
			var locationDepth1 = e.target.value;
			console.log(locationDepth1)
			$.ajax({
				url:"http://localhost:8080/rest/location/depth2List",
				type:"post",
				data:{locationDepth1:locationDepth1},
				success:function (data){
					var select = $("[name=locationNo]");
					
					select.empty();
					select.append('<option value="">구/시 선택</option>');
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
	
	$("[name=moimGenderCheck]").click(function(e){
	    var isChecked = $(this).prop("checked");

	    // 체크박스를 클릭하여 선택되었다면
	    if (isChecked) {
	        $(this).val(1);
	    } else {
	    	$(this).val(2);
	    }
	});
 </script> 