<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>
span {
	color: darkorange;
}
</style>

<script>
$(function(){
    //최초 게이지 계산
    refreshProgressbar();

    //이전이나 다음버튼을 누르면 진행상황을 파악하여 게이지 계산
    $(".btn-prev, .btn-next").click(function(){
        refreshProgressbar();
    });

    function refreshProgressbar() {
        //page중에 보여지는 태그를 찾아서 계산
        //- 전체 페이지 수 + 보여지는 페이지 번호

        var count = 0;
        var index = 0;
        $(".page").each(function(idx, el){
            //if(현재 태그가 표시중이라면) {
            if($(this).is(":visible")) {
                index = idx+1;
            }
            count++;
        });

        var percent = index * 100 / count;
        $(".progressbar > .guage").css("width", percent+"%");
    }
});

$(function(){
    //검색버튼, 우편번호 입력창, 기본주소 입력창을 클릭하면 검색 실행
    $(".post-search").click(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.querySelector("[name=memberPost]").value = data.zonecode;
                $("[name=memberPost]").val(data.zonecode);
                //document.querySelector("[name=memberAddr1]").value = addr;
                $("[name=memberAddr1]").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                //document.querySelector("[name=memberAddr2]").focus();
                $("[name=memberAddr2]").focus();
                $(".post-clear").show();
            }
        }).open();
    });
    
    //x버튼 누르면 주소 지우기
    $(".post-clear").click(function(){
    	$("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").val("").removeClass("success fail");
    });
    $("[name=memberAddr2]").on("input blur", function(){
		var post = $("[name=memberPost]").val();
		var addr1 = $("[name=memberAddr1]").val();
		var addr2 = $("[name=memberAddr2]").val();
		if(post.length == 0 && addr1.length == 0 && addr2.length == 0) {
			$(".post-clear").hide();				
		}
		else {
			$(".post-clear").show();        	
		}
    });
    $(".post-clear").hide();
});


/* 인증번호  */
   $(function(){
            //처음 로딩아이콘 숨김
            $(".btn-send").find(".fa-spinner").hide();
            $(".cert-wrapper").hide();


            // 인증번호 보내기 버튼을 누르면 
            // 서버로 비동기 통신을 보내 인증 메일 발송 요청
            $(".btn-send").click(function(){
                var email = $("[name=memberEmail]").val();
                if(email.length == 0) return;

                $(".btn-send").prop("disabled",true);
                $(".btn-send").find(".fa-spinner").show();
                $(".btn-send").find("span").text("이메일 발송중");
                $.ajax({
                    url:"http://localhost:8080/rest/cert/send",
                    method:"post",
                    data:{certEmail : email},
                    success:function(){
                        $(".btn-send").prop("disabled",false);
                        $(".btn-send").find(".fa-spinner").hide();
                        $(".btn-send").find("span").text("보내기");
                        // window.alert("이메일 확인하세요");

                        $(".cert-wrapper").show();
                        window.email = email;
                    },
                });
            });
            // 확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사 
            $(".btn-cert").click(function(){
            //    var email = $("[name=memberEmail]").val();
                var email = window.email;
                var number = $(".cert-input").val();

                if(email.length == 0 || number.length == 0)return;

                $.ajax({
                    url:"http://localhost:8080/rest/cert/check",
                    method:"post",
                    data:{
                        certEmail : email,
                        certNumber : number
                    },
                    success:function(response){
                        // console.log(response);
                        if(response.result){//인증성공 
                            $(".cert-input").removeClass("success fail").addClass("success");
                            $(".btn-cert").prop("disabled",true);
                            //상태객체에 상태 저장하는 코드
                        }
                        else{
                            $(".cert-input").removeClass("success fail").addClass("fail");
                            //상태객체에 상태 저장하는 코드
                        }
                    },
                });
            });
        });
        
        /* 인증번호 보내기 클릭 시 타이머  */
  document.addEventListener("DOMContentLoaded", function () {
    var timer; // 타이머 변수

    // 인증 버튼 클릭 시 동작
    document.getElementById("id_Confirm").addEventListener("click", function () {
      // 여기에 인증 동작 및 서버 요청 등을 추가

      // 인증 버튼 비활성화
      this.disabled = true;

      // 5분(300초) 타이머 설정
      var totalSeconds = 10;
      updateTimerDisplay(totalSeconds); // 초기 표시 업데이트
      timer = setInterval(function () {
        totalSeconds--;

        // 남은 시간을 버튼 옆에 표시
        updateTimerDisplay(totalSeconds);

        // 시간이 다 되면 타이머 종료 및 버튼 활성화
        if (totalSeconds <= 0) {
          clearInterval(timer);
          document.getElementById("id_Confirm").disabled = false;
        }
      }, 1000);
    });

    // 다른 버튼(확인 버튼 등) 클릭 시 타이머 종료
    document.getElementById("otherButton").addEventListener("click", function () {
      clearInterval(timer);
    });

    // 시간을 표시하는 함수
    function updateTimerDisplay(totalSeconds) {
      var minutes = Math.floor(totalSeconds / 60);
      var seconds = totalSeconds % 60;
      document.getElementById("timerDisplay").innerText = "남은 시간: " + minutes + "분 " + seconds + "초";
    }
  });
        
        /* 이메일 재전송  */
       var isTimerRunning = false; // 타이머가 실행 중인지 여부를 나타내는 변수

$(".btn-send").click(function() {
    // 이메일 전송 코드...
    // 타이머 시작
    startTimer();
});

$(".btn-cert").click(function() {
    // 인증 확인 코드...
    if (response.result) { // 인증 성공
        $(".cert-input").removeClass("success fail").addClass("success");
        $(".btn-cert").prop("disabled", true);

        // 타이머 종료
        stopTimer();

        // 아래의 코드를 추가
        // 확인 버튼을 클릭하면 재전송 버튼 표시
        $(".btn-send").prop("disabled", false);
        $(".btn-send").find(".fa-spinner").hide();
        $(".btn-send").find("span").text("재전송");
    } else {
        $(".cert-input").removeClass("success fail").addClass("fail");
    }
});

// 타이머 시작 함수
function startTimer() {
    if (!isTimerRunning) {
        document.getElementById('timerDisplay').style.display = 'block';
        isTimerRunning = true;

        // 타이머 로직...
    }
}

// 타이머 종료 함수
function stopTimer() {
    document.getElementById('timerDisplay').style.display = 'none';
    clearInterval(timer);
    isTimerRunning = false;
}

$(".btn-send").click(function() {
    // 재전송 코드...
    // 타이머 시작
    startTimer();
});


let timeLeft = 300; // 5분

function startTimer() {
    document.getElementById('timerDisplay').style.display = 'block';
    
    const timerElement = document.getElementById('timer');

    const timerInterval = setInterval(() => {
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;

        timerElement.textContent = `${minutes}:${seconds}`;

        if (timeLeft === 0) {
            clearInterval(timerInterval);
            document.getElementById('timerDisplay').style.display = 'none';
        } else {
            timeLeft--;
        }
    }, 1000);
}

</script>

<!-- ---------------------------------------------------------------------------------------- -->


<form class="join-form" action="" method="post" autocomplete="off"
	novalidate>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10 offset-md-1">

				<div class="container text-center mt-5 box">
					<div class="row">
						<div class="col align-self-start">

							<div class="mt-5">
								<h2>회원가입</h2>
							</div>


							<!-- 이메일 입력 부분 -->
							<div class="col-md-4 offset-md-4 text-start">
								<div class="d-flex mt-2">
									<div class="text-start">
										<label>Email</label> <input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
									</div>
									<div class="ms-3 mt-4">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-success btn-send" onclick="startTimer()">인증</button>
									</div>
								</div>
							</div>

							<!-- 인증번호 입력 부분 -->
							<div class="col-md-4 offset-md-4 text-start d-flex">
								<div class="d-flex ">
									<div class="text-start">
										<label>인증번호</label> <input type="text" class="form-control ">

									</div>
									<div class="ms-3 mt-4">
										<button class="btn btn-success btn-send" type="button">확인</button>
									</div>
								</div>
							</div>
							<!-- 시간 표시 부분 -->
							<div id="timerDisplay" style="display: none; color: darkorange;"
								class="col-md-4 offset-md-4 text-start">
								남은 시간: <span id="timer"></span>
							</div>

							<!-- 타이머 시간 끝났을때 재전송  -->

							<!-- <div class="col-md-4 offset-md-4 text-start">
								<div class="d-flex mt-2">
									<div class="text-start">
										<label>Email</label> <input type="text" name="memberEmail"
											placeholder="everyfit@every.fit" id="id" class="form-control">
									</div>
									<div class="ms-3">
										<button type="button" id="id_Confirm" value="중복확인"
											class="btn btn-success btn-send">인증</button>
									</div>
								</div>
							</div>

							<div class="col-md-4 offset-md-4 text-start d-flex">
								<div class="d-flex ">
									<div class="text-start">
										<label>인증번호</label> <input class="form-control">
									</div>
								</div>
								<div>
									<button class="btn btn-success">확인</button>
								</div>
							</div> -->

							<div class="col-md-4 offset-md-4 text-start">
								<!-- 가입하기 버튼 눌렀을 때 비밀번호가 정규표현식에 맞지 않으면 제대로 입력하라고 알림창 띄우기 -->
								<label>비밀번호</label> 
								<input type="password" name="memberPw" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								<label> 비밀번호 확인 </label> 
								<input type="password" required class="form-control"
									name="memberPwConfirm" id="passwordConfirm">
							</div>



							<div class="col-md-4 offset-md-4 text-start">
								닉네임<input type="text" name="memberNick" class="form-control">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								성별<select class="form-select">
									<option>man</option>
									<option>woman</option>
								</select>
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								전화번호<input type="text" name="memberContact" class="form-control"
									placeholder="- 제외하고 입력">
							</div>

							<div class="col-md-4 offset-md-4 text-start">
								생년월일<input type="date" name="memberBirth" class="form-control">
							</div>

							<div class="mt-4 col-md-4 offset-md-4 text-center"
								style="margin-bottom: 150px;">
								<button type="submit" class="btn btn-info">회원가입</button>
							</div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
</form>

<jsp:include page="../template/Footer.jsp"></jsp:include>