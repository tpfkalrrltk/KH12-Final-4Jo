<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>
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

			var faqTitle = $("[name=faqTitle]").val();
			var faqDetail = $("[name=faqDetail]").val();
			var fileInput = $(".file-chooser")[0];

			if (faqTitle.length == 0 || faqDetail.length == 0) {
				event.preventDefault();
				alert("제목과 내용을 입력해주세요.");
			}
		})
	});
</script>

<body>
	<div class="container ">

		<div class="row mt-5 p-5">
			<div class="col-5 offset-2 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">등록</h1>
			</div>
		</div>




		<div class="row mt-3">
			<div class="col">
				<form action="add" method="post" enctype="multipart/form-data">

					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">제목 :</p>
							<input type="text" name="faqTitle"
								class="form-control fw-bold bg-primary text-light">
						</div>
					</div>


					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">파일 :</p>

							<label> <input type="file" name="attach" accept="image/*"
								multiple id="attach-selector">
							</label>
							<div class="preview-wrapper"></div>

						</div>
					</div>




					<div class="row">
						<div class="col-5 offset-1">
							<p class="text-primary fw-bold">카테고리 :</p>
							<select name="faqCategory"
								class="form-select fw-bold bg-primary text-light">
								<option class="fw-bold bg-primary text-light">공지사항</option>
								<option class="fw-bold bg-primary text-light">이용방법</option>
								<option class="fw-bold bg-primary text-light">이벤트</option>
								<option class="fw-bold bg-primary text-light">일반</option>
								<option class="fw-bold bg-primary text-light">계정</option>
								<option class="fw-bold bg-primary text-light">모임</option>
							</select>
						</div>
					</div>






					<div class="row">
						<div class="col offset-1">
							<p class="text-primary fw-bold">내용 :</p>
							<textarea rows="30" cols="52" name="faqDetail"
								class="form-control fw-bold bg-primary text-light"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-10 offset-1">
							<button type="submit"
								class="btn btn-primary w-100 m-5 btn-save fw-bold">등록</button>
						</div>
					</div>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include>