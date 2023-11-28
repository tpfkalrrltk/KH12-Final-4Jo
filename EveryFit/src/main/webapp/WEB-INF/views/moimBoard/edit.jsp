<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../template/Header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에브리핏</title>
</head>

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

			var faqTitle = $("[name=moimBoardTitle]").val();
			var faqDetail = $("[name=moimBoardContent]").val();
			var fileInput = $(".file-chooser")[0];

			if (moimBoardTitle.length == 0 || moimBoardContent.length == 0) {
				event.preventDefault();
				alert("제목과 내용을 입력해주세요.");
			}
		})
	});
</script>


<body>
	<div class="container">

		<div class="row">
			<div class="col-5 offset-2 p-5 m-4 bg-primary rounded-3  text-light">

				<h1 class="display-5 fw-bold">수정</h1>
			</div>
		</div>

		<div class="row">
			<a href="${pageContext.request.contextPath}/moim/board/list?moimNo=${moimBoardDto.moimNo}">목록으로
				돌아가기 </a>
		</div>




		<div class="row mt-3">
			<div class="col">
				<form action="edit" method="post" enctype="multipart/form-data">

					<input type="hidden" name="moimBoardNo"
						value="${moimBoardDto.moimBoardNo}" style="width: 450px;">
					<input type="hidden" name="moimNo" value="${moimBoardDto.moimNo}"
						style="width: 450px;">
					<div class="row">
						<div class="col-5 text-primary fw-bold">
							카테고리 : <select name="moimBoardCategory" class="form-select bg-primary text-light fw-bold">
								<c:forEach items="${moimBoardDto.moimBoardCategory}"
									var="category">
									<option value="${category}"
										${category eq moimBoardDto.moimBoardCategory ? 'selected' : ''}>${category}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="col text-primary fw-bold">제목 :</div>
					</div>

					<div class="row">
						<div class="col-2">
							<input type="text" name="moimBoardTitle" class=" form-control bg-primary text-light fw-bold"
								value="${moimBoardDto.moimBoardTitle}" style="width: 450px;">
						</div>
					</div>

						<div class="row">
						<div class="col">
							<p class="text-primary fw-bold ">파일 :</p>

							<label> <input type="file" name="attach" accept="image/*"
								multiple id="attach-selector">
							</label>
							<div class="preview-wrapper"></div>

						</div>
					</div>




					<div class="row">
						<div class="col text-primary fw-bold">내용 :</div>
					</div>

					<div class="row">
						<div class="col">
							<textarea rows="30" cols="52" name="moimBoardContent" class=" form-control bg-primary text-light fw-bold">${moimBoardDto.moimBoardContent}	</textarea>
						</div>

					</div>


					<button type="submit" class="btn btn-primary w-100 mt-5">수정</button>
				</form>

			</div>
		</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>