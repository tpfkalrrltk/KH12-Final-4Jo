<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@200&display=swap"
	rel="stylesheet">

<!-- datetimepicker -->
<link rel="stylesheet" href="/css/jquery.datetimepicker.min.css" />

<link rel="preload" href="webfont-path" as="font" crossorigin />

<script
	src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script>
<script>
	WebFont.load({
		google : {
			families : [ 'Noto Sans KR', 'Noto Sans KR' ]
		}
	});
	
	
</script>


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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<!--     전용 CDN -->
<link rel="stylesheet" type="text/css" href="/css/EveryFit-layout.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<!-- Bootstrap JS (including Popper.js) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jQuery UI JS -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>

<style>
textarea {
	width: 100%;
	height: 25em;
	border: none;
	resize: none;
}

@font-face {
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
}

#wrapper {
	font-family: 'Noto Sans KR', sans-serif;
}

p {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>

<script>
$(function(){
    $("#attach-selector").change(function(){
    	 $(".preview-wrapper").empty();
    	
    	 if(this.files.length == 0) {
            //초기화
            return;
        }

        let reader = new FileReader();
        reader.onload = ()=>{
            $("<img>").attr("src", reader.result)//data;로 시작하는 엄청많은 실제이미지 글자
                            .css("max-width", "300px")
                            .appendTo(".preview-wrapper");
        };
        for(let i=0; i < this.files.length; i++) {
            reader.readAsDataURL(this.files[i]);
        }
    });
});
</script>

<script>
	$(function() {
		$(".btn-save").click(function() {

			var reportReason = $("[name=reportReason]").val();
			var reportContent = $("[name=reportContent]").val();
			var fileInput = $(".file-chooser")[0];

			if (reportReason.length == 0 || reportContent.length == 0) {
				event.preventDefault();
				alert("제목과 내용을 입력해주세요.");
			}
		})
	});
</script>

<script type="text/javascript">





function popClose() {
	   window.alert("소중한 신고 감사합니다.\n신고 내용이 전송되었습니다.")
	  $('#report-from').submit(); 
	    setTimeout(function() {  	 
	    	self.close(); 
	    }, 300);
	 

}


$(document).keydown(function(e){
	
    var code = e.keyCode || e.which;
 
    if (code == 27) { // 27은 ESC 키번호
    	window.alert("esc키를 눌러서 신고가 취소됩니다.")
        window.close();

    }
});
</script>

<body>
	<div class="container ">

		<div class="row ms-3">
			<div
				class="col-7 offset-2 p-5 m-4 bg-primary rounded-3 text-center  text-light">

				<h1 class="display-5 fw-bold fst-italic  text-center">Appeal</h1>
			</div>
		</div>




		<div class="row mt-3">
			<div class="col">
				<form action="" method="post" enctype="multipart/form-data"
					id="appeal-from">

					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">항소 제목 :</p>
							<input type="text" name="appealReason"
								class="form-control fw-bold bg-primary text-light">
						</div>
					</div>


			




					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">카테고리 :</p>
							<select name="appealCategory"
								class="form-select fw-bold bg-primary text-light">

								<option class="fw-bold bg-primary text-light">회원</option>
								<option class="fw-bold bg-primary text-light">모임</option>
								<option class="fw-bold bg-primary text-light">댓글</option>
								<option class="fw-bold bg-primary text-light">정모</option>
								<option class="fw-bold bg-primary text-light">게시글</option>
							</select>
						</div>
					</div>






					<div class="row">
						<div class="col offset-1">
							<p class="text-primary fw-bold">항소 내용 :</p>
							<textarea rows="30" cols="52" name="appealContent"
								class="form-control fw-bold bg-primary text-light"
								placeholder="상세히 기술하여 주세요."></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-11">
							<button type="submit"
								class="btn btn-primary w-100 m-5 btn-save fw-bold" 
					
								id="report-btn" onclick="popClose()" >등록</button>
							
								
						</div>
					</div>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
