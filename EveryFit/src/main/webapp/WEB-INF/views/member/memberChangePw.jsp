<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../template/Header.jsp"></jsp:include>


<style>

</style>

<form  action="" method="post" autocomplete="off">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-10 offset-md-1">

        <div class="col-md-4 offset-md-4 text-center">
          <h4>비밀번호 변경</h4>
        </div>
		
		<!-- <div class="col-md-4 offset-md-4 text-start">
		    <label>현재 비밀번호</label>
		    <input type="password" id="originPw" name="originPw" class="form-control" />
		</div> -->
        <div class="col-md-4 offset-md-4 text-start mt-3">
          <label>변경할 비밀번호</label>
        </div>
        <div class="col-md-4 offset-md-4 text-start">
          <input type="password" class="form-control" name="memberChangePw" />
        </div>

        <div class="col-md-4 offset-md-4 mt-3 text-start">
          <label>변경할 비밀번호 확인</label>
        </div>
        <div class="col-md-4 offset-md-4 text-start">
          <input type="password" class="form-control"  />
        </div>

        <div class="col-md-4 offset-md-4 text-start mt-5">
    <button type="submit" class="btn btn-primary w-100" >변경하기</button>
</div>

      </div>
    </div>
  </div>
</form>

<script>
 /*  function changePassword() {
    var originPw = document.getElementById('changePasswordForm').elements['originPw'].value;
    var changePw = document.getElementById('changePasswordForm').elements['changePw'].value;
    var changePwCheck = document.getElementById('changePasswordForm').elements['changePwCheck'].value;
    console.log(originPw);
    // 여기에 필요한 유효성 검사 로직을 추가하세요.

    // Ajax를 사용하여 서버로 비밀번호 변경 요청을 보냅니다.
    // 예제 코드:
    $.ajax({
      url: "/http://localhost:8080/rest/member/memberchangePw",
      type: "POST",
      data: {
        originPw: originPw,
        changePw: changePw,
        changePwCheck: changePwCheck
      },
      success: function (response) {
        // 성공적으로 비밀번호가 변경되었을 때의 동작을 구현하세요.
        console.log("비밀번호가 성공적으로 변경되었습니다.");
        window.alert("비밀번호가 변경되었습니다. 다시 로그인해 주세요. ");
      },
      error: function (xhr, status, error) {
        // 비밀번호 변경 실패 시의 동작을 구현하세요.
       console.log(error);
       
        window.alert("비밀번호 변경 실패 ");
      }
    });
  } */
  
  
  
</script>


<jsp:include page="../template/Footer.jsp"></jsp:include>