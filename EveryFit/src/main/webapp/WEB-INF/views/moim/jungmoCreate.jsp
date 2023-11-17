<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<div class="container-fluid mt-4">
<div class="card border-primary mb-3" style="max-width: 80rem;">


	<div class="row mt-4">
		<div class="col-10 offset-1">
			<h1>정모등록</h1>
			<div>
				<form method="post" autocomplete="off" enctype="multipart/form-data" >
				<div class="preview-wrapper1"></div>
					<input type="file" name="attach" accept="image/*" multiple id="attach-selector" >
					정모명<input type="text" name="jungmoTitle"> 
					<input type="hidden" name="moimNo" >
					정모주소<input type="text" name="jungmoAddr"> 링크<input
						type="text" name="jungmoAddrLink"> 인원<input type="text"
						name="jungmoCapacity"> 가격<input type="number"
						name="jungmoPrice"> 일정<input type="datetime-local"
						name="jungmoDto.jungmoScheduleStr">
					<button type="submit" class="save-btn">등록하기</button>
				</form>
			</div>
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
        

        //파일 미리보기는 서버 업로드와 관련이 없다
        //- 서버에 올릴거면 따로 처리를 또 해야 한다

        //[1] 자동으로 생성되는 미리보기 주소를 연결
//         for(let i=0; i < this.files.length; i++) {
//             $("<img>").attr("src", URL.createObjectURL(this.files[i]))
//                             .css("max-width", "300px")
//                             .appendTo(".preview-wrapper1");
//         }
        
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
	//현재 페이지의 URL 가져오기
	var currentUrl = location.search;
	var moimNo = currentUrl.replace(/\D/g, '');

    $('input[name="moimNo"]').val(moimNo);

console.log(moimNo);

</script>