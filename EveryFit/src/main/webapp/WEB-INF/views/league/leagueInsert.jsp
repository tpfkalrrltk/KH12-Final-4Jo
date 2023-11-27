<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="container-fluid">
	<div class="row"><div class="col-md-8 offset-md-2">
		
		<div class="p-5 bg-primary text-light rounded">
			<h1>리그등록 <i class="fa-solid fa-plus"></i></h1>
			<hr>
			<div class="row text-end">
				<div class="col">
					<a href="${pageContext.request.contextPath}/league/leagueList" class="btn btn-outline-success bg-light">목록으로</a>
				</div>
			</div>
		</div>
		
		<form method="post" enctype="multipart/form-data">
			<div class="row mt-5"><div class="col">
			<div class="input-group">
				<span class="input-group-text">기본정보</span>
				<select class="form-select" name="eventNo">
					<option value="">종목선택</option>
					<c:forEach var="eventDto" items="${eventList}">
						<option value="${eventDto.eventNo}">${eventDto.eventName}</option>
					</c:forEach>
				</select>
				<select class="form-select location-depth1">
					<option value="">시/도</option>
					<c:forEach var="locationDto" items="${locationList}">
						<option value="${locationDto.locationDepth1}">${locationDto.locationDepth1}</option>				
					</c:forEach>
				</select>
				<select class="form-select" name="locationNo">
					<option value="">시/군/구</option>
				</select>
			</div>
			</div></div>
			<div class="row mt-2"><div class="col">
				<div class="input-group">
					<span class="input-group-text">리그시작일</span>
					<input type="date" class="form-control" name="leagueStart">
					<span class="input-group-text">리그종료일</span>
					<input type="date" class="form-control" name="leagueEnd">
				</div>
			</div></div>
			
			<div class="row mt-2"><div class="col">
				<div class="input-group">
					<span class="input-group-text">참가정보</span>
					<input type="number" class="form-control" name="leagueTeamCount" min="1" placeholder="최대 참가팀 개수">
					<input type="number" class="form-control" name="leagueRoasterCount" min="1" placeholder="로스터 정원">
					<input type="number" class="form-control" name="leagueEntryFee" min="0" placeholder="참가비(원)">
				</div>
			</div></div>
			
			<div class="row mt-4"><div class="col">
				<label class="form-label">리그 사진</label>
		        <input class="form-control" type="file" name="attach" accept="image/*">
		    </div></div>
			
		    <div class="row mt-4"><div class="col">
				<label class="form-label">제목</label>
		        <input class="form-control" name="leagueTitle">
		    </div></div>
		    <div class="row mt-2"><div class="col">
				<label class="form-label">내용</label>
		        <textarea class="form-control" name="leagueDetail"></textarea>
		    </div></div>
		    
		    <div class="row mt-5"><div class="col">
		        <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold">리그등록</button>
		    </div></div>
		</form>
	</div></div>
</div>
<script>

	$(".location-depth1").change(function(e){
		var locationDepth1 = e.target.value;
		if(locationDepth1=="") return;
		$.ajax({
			url:window.contextPath + "/rest/location/depth2List",
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
	
	$("form").submit(function (event) {
        // 각 필드에 대한 유효성 검사 수행
        var isFormValid = true;

        // 각 필드에 대한 검사 함수 호출
        isFormValid = isFormValid && validateField("[name=eventNo]");
        isFormValid = isFormValid && validateField("[name=locationNo]");
        isFormValid = isFormValid && validateField("[name=leagueStart]");
        isFormValid = isFormValid && validateField("[name=leagueEnd]");
        isFormValid = isFormValid && validStartEnd("[name=leagueStart]", "[name=leagueEnd]");
        isFormValid = isFormValid && validateNumberField("[name=leagueTeamCount]", 1); // 최소값 1
        isFormValid = isFormValid && validateNumberField("[name=leagueRoasterCount]", 1); // 최소값 1
        isFormValid = isFormValid && validateNumberField("[name=leagueEntryFee]", 0); // 최소값 0
        isFormValid = isFormValid && validateField("[name=leagueDetail]");
        
        // 모든 필드가 유효한지 확인하고 유효하지 않으면 폼 제출 막기
        if (!isFormValid) {
        	alert("입력항목을 확인해주세요");
            event.preventDefault();
        }
    });

    // 입력 필드에서 포커스를 떠날 때의 동작
    $("[name=eventNo], [name=locationNo], [name=leagueStart], [name=leagueEnd], [name=leagueTeamCount], [name=leagueRoasterCount], [name=leagueEntryFee], [name=leagueTitle], [name=leagueDetail]").blur(function () {
        validateField(this);
    });

    // 특정 숫자 필드에 대한 유효성 검사 함수
    function validateNumberField(selector, minValue) {
        var fieldValue = $(selector).val();

        // 필드가 비어있거나 최소값보다 작으면 유효하지 않음
        if (fieldValue === "" || parseInt(fieldValue, 10) < minValue) {
            $(selector).addClass("is-invalid");
            return false;
        } else {
            $(selector).removeClass("is-invalid");
            return true;
        }
    }

    // 최대 길이 검사 함수
    function validateMaxLength(selector, maxLength) {
        var fieldValue = $(selector).val();
        // 필드의 길이가 최대값을 초과하면 유효하지 않음
        if (fieldValue.length > maxLength) {
            $(selector).addClass("is-invalid");
            return false;
        } else {
            $(selector).removeClass("is-invalid");
            return true;
        }
    }
    
    //리그 시작 끝 날짜
    function validStartEnd(leagueStart, leagueEnd){
    	var start = $(leagueStart).val();
    	var end = $(leagueEnd).val();
    	if(start>=end){
    		$(leagueEnd).addClass("is-invalid");
    		return false;
    	}
    	else{
    		$(leagueEnd).removeClass("is-invalid");
    		return true;
    	}
    }

    // 각 필드에 대한 유효성 검사 함수
    function validateField(selector) {
        var fieldValue = $(selector).val();

        // 필드가 비어있으면 유효하지 않음
        if (fieldValue === "") {
            $(selector).addClass("is-invalid");
            return false;
        } else {
            $(selector).removeClass("is-invalid");
            return true;
        }
    }
    
    var maxLength = 4000;
    $("[name=leagueDetail]").summernote({
		height: 240,
		fontNames: ['NotoSansKR'],
        fontNamesIgnoreCheck: ['NotoSansKR'],
        defaultFontName: 'NotoSansKR',
        fontSizeUnits: ['px'], 
	    toolbar: [
	          ['style', ['style']],
	          ['font', ['bold', 'underline', 'clear']],
	          ['color', ['color']],
	          ['para', ['ul', 'ol', 'paragraph']],
	          ['insert', ['link']],
	          ['view', ['codeview', 'help']]
	        ],
	        callbacks: {
	        	onPaste: function (e) {
	                // 붙여넣기 이벤트에서 태그 제거
	                var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text');
	                e.preventDefault();
	                document.execCommand('insertText', false, bufferText);
	            },
                onKeyup: function(e) {
                    // 썸머노트의 내용을 가져오는 함수
                    function getSummernoteContent() {
                        return $('[name=leagueDetail]').summernote('code');
                    }

                    // 썸머노트 입력값의 길이를 계산하는 함수
                    function calculateContentLength() {
                        var content = getSummernoteContent();
                        var lengthInBytes = new Blob([content]).size;
                        return lengthInBytes;
                    }

                    // 현재 입력값의 길이 계산
                    var currentLength = calculateContentLength();

                    // 최대 길이를 초과하는지 확인
                    if (currentLength > maxLength) {
                        alert("최대 길이를 초과했습니다. 더 이상 입력할 수 없습니다.");
                        // 혹은 다음과 같이 최대 길이 이하로 자르거나, 입력을 무시하는 등의 처리 가능
                        $('[name=leagueDetail]').summernote('undo');
                        var truncatedContent = getSummernoteContent().substring(0, maxLength);
                        $('[name=leagueDetail]').summernote('code', truncatedContent);
                    }
                }
	        }
	  });
    
    
</script>



<%@ include file="/WEB-INF/views/template/Footer.jsp"%>