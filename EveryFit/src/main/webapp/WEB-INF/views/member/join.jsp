<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
		
		<div>
			<h2>join</h2>
		</div>
		
		<form action="join" method="post"> 
		<div>
			name<input type="text" name="memberName" placeholder="빵빵이">
		</div>
		
		<div>
			email<input type="text" name="memberEmail" placeholder="everyfit@every.fit" id="id" >
			<input type="button" id="id_Confirm" value="중복확인">
		</div>
		
		<div>
			pw<input type="password" name="memberPw" placeholder="test!">
		</div>
		
		<div>
			nick<input type="text" name="memberNick"> 
		</div>
		
		<div>
			gender<select>
					<option>man</option>
					<option>woman</option>
				</select>
		</div>
		
		<div>
			contact<input type="text" name="memberContact">
		</div>
		
		<div>
			birth<input type="date" name="memberBirth">
		</div>
		
		<button type="submit">join</button>
		
		
		</form>
<!-- ---------------------------------------------------------------------------------------- -->
		<script>
		 function{
		 $("#id").blur(function() {
		 	let idCheck = /^[a-zA-Z0-9]{8,16}$/;
		 	
		 	if ($("#id").val() == "") {
		         $("#idcheck_blank").css("color", "red");
		         $("#idcheck_blank").text("아이디는 필수 입력");
		         id = false;
		 	}else if(!idCheck.test($("#id").val())) {
		         $("#idcheck_blank").css("color", "red");
		         $("#idcheck_blank").text("영문과 숫자 조합하여 8~16자만 가능");
		         id = false;
		    }else {
		    	$("#idcheck_blank").css("color", "blue");
		    	$("#idcheck_blank").text("괜찮은 아이디입니다. 중복확인을 해보세요");
		    	id = true;
		    }
		 	
		 	if(id == true) {
		 		$("#id_Confirm").show();
		 	}else {
		 		$("#id_Confirm").hide();
		 	}
		 });
		 
		 //////아이디 중복 검사////////
		 $("#id_Confirm").click(function() {
		 	if( $("#id").val() == "" ) {
		 		alert("아이디를 입력해주세요.");
		 	}else {
		 		$.ajax({
		 			url: "idcheck.do",
		 			type: "post",
		 			data: {'m_id':$("#id").val()},
		 			success: function(data) {
						//alert(data);
						if(data = "YES") {
							$("#idcheck_blank").css("color", "blue");
					    	$("#idcheck_blank").text("사용가능한 아이디입니다.");
					    	id_check = true;
						}else {
							$("#idcheck_blank").css("color", "red");
					    	$("#idcheck_blank").text("중복된 아이디입니다.");
					    	id_check = false;
					    	$("#id").val("");
						}
					},
					error: function() {
						alert("e");
					}
		 		});
		 	}
		 });
		 };
		</script>