<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/Header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<!-- <h1>기본 웹소켓 예제</h1> -->

<!-- <div class="client-list"></div> -->
<!-- <div class="message-list"></div> -->
<!-- <input type="text" class="message-input form-control"> -->
<!-- <button type="button" class="send-btn btn btn-primary">전송</button> -->

<style>
	h2 {
		opacity:0.4;		
	}
	.message-list {
		height: 60vh;
		overflow-y:scroll;
		padding-bottom: 20px;
	}
	::-webkit-scrollbar {
	 	width: 1px; /* 스크롤바 너비 */
	}
	::-webkit-scrollbar-thumb {
	 	background: var(--bs-secondary); /* 스크롤바 배경 색상 */
	 	border-radius: 5px; /* 스크롤바 엄지 모서리 둥글게 */
	}
	
	@media screen and (max-width:768px) {
		.client-list {
			position:fixed;
			top:0;
			left:-250px;
			bottom:0;
			width:250px;	
			z-index: 999999;
			padding-top:95px;
			transition:left 0.2s ease-out;
			color:white;
		}
		.client-list.active {
			left:0;
		}
	}
	</style>
</head>

<body>
    <div class="container-fluid mt-4">
        <div class="row mt-4">
            <div class="col-md-10 offset-md-1">
				
				${sessionScope.name}
<!-- 				<div class="row"> -->
<!-- 						<h2 class="bg-primary text-light p-3 text-start rounded"> -->
<!-- 							 채팅방 -->
<!-- 						</h2> -->
<!-- 				</div> -->
				
				<div class="row mt-5">
					<div class="col-md-4 client-list"></div>
					<div class="col-md-8">
						
						<!-- 메세지 표시 영역 -->
						<div class="row text-start">
							<div class="col message-list rounded border mt-4"></div>
						</div>
						
						<div class="row">
							<div class="col">
								<div class="input-group">
									<input type="text" class="form-control message-input" placeholder="메세지 내용 작성">
									<button type="button" class="btn btn-primary send-btn">
										<i class="fa-regular fa-paper-plane"></i>
										보내기
									</button>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
            </div>
        </div>        
    </div>

<!-- 웹소켓 서버가 SockJS일 경우 페이지에서도 SockJS를 사용해야 한다 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

<script>
// 	var uri = "ws://localhost:8080/ws/default";
//  	window.socket = new WebSocket("ws://localhost:8080/ws/default");
 	window.socket = new SockJS("http://localhost:8080/ws/default");
	//연결 생성 시점에 연결에서 발생할 수 있는 상황별로 callback 함수를 지정
	//- onopen : 연결이 성공한 직후에 실행하는 함수를 설정하는 자리
	//연결성공한직후에메시지띄우고싶음(입장했다는메시지)
	//- onclose : 연결이 종료된 직후에 실행하는 함수를 설정하는 자리
	//- onerror : 연결에서 오류가 발생한 경우 실행하는 함수를 설정하는 자리
	//- onmessage : 서버에서 메세지가 전송되는 경우 실행하는 함수를 설정하는 자리

	var currentURL = window.location.href;

	// URL을 '/'로 나누고, 마지막 부분을 가져오기
	var urlParts = currentURL.split('/');
	var chatRoomNo = urlParts[urlParts.length - 1];
	
	// 마지막 부분을 출력
	console.log(chatRoomNo);
	
	socket.onopen = function(event) {
        console.log('WebSocket 연결이 열렸습니다.');

        // 서버에게 초기 메시지 전송
        var obj = {
        	type : 'join',
        	chatRoomNo : chatRoomNo
        }
        // JSON 문자열로 직렬화하여 전송
	    var str = JSON.stringify(obj);
		window.socket.send(str);
        
	};
	
   var myId = "${sessionScope.name}";
	
	socket.onmessage = function(e){
		var data = JSON.parse(e.data); //JSON 문자열을 자바스크립트 객체로 해석( <--> JSON.stringify()
		
		// 사용자가 접속하거나 종료했을 때 서버에서 오는 데이터로 목록을 갱신
		// 사용자가 메세지를 보냇을 때 서 버에서 이를 전체에게 전달한다
		//data.clients에 회원 목록이 있다
		if(data.clients) { //목록처리
			$(".client-list").empty();
			var ul = $("<ul>").addClass("list-group");
			for(var i = 0; i < data.clients.length; i++) {
				if(myId == data.clients[i].memberEmail){
					$("<li>")
					.addClass("list-group-item d-flex justify-content-between align-items-center")
					.append($("<span>").text(data.clients[i].memberEmail))
// 					.append(
// 						$("<span>").addClass("badge bg-danger badge-pill").text(data.clients[i].memberLevel)		
// 		 			)
					.appendTo(ul);
				}
			else {
				$("<li>")
				.addClass("list-group-item d-flex justify-content-between align-items-center")
				.append($("<label>").text(data.clients[i].memberEmail))
				.append(
					$("<span>").addClass("badge bg-primary badge-pill").text(data.clients[i].memberLevel)		
	 			)
				.appendTo(ul);
			} 
			}			
			ul.appendTo(".client-list");
		}
		else if(data.content) {//메세지처리
			var memberEmail;
			if(data.dm == true) {
				if(myId == data.memberEmail){
					memberEmail = $("<label>").text(data.target + "님에게 DM");
					console.log(data);
				}
	        	else{
					memberEmail = $("<label>").text(data.memberEmail+ " 님으로부터의 DM");                        
				}
// 		 memberEmail = $("<strong>").text(data.memberEmail + "님으로 부터의 DM")
// 		 						.addClass("text-secondary");
// 		}
			}
			else {
				memberEmail = $("<span>").text(data.memberEmail);			
			}
		
		var memberLevel = $("<strong>").text(data.memberLevel)
											.addClass("badge bg-primary badge-pill ms-2");
		var content = $("<div>").text(data.content);
		 
		if(myId==data.memberEmail){
             $("<div>").addClass("mt-4").addClass("text-end").append(memberEmail)
             .append(memberLevel)
             .append(content)
             .appendTo(".message-list");
		 }
		 else {
			$("<div>")
			.addClass("rounded mt-2")
			.append(memberEmail)
			.append(content)
			.appendTo(".message-list");				 			 
		 }

			//스크롤바를 맨 아래로 이동
			$(".message-list").scrollTop($(".message-list")[0].scrollHeight);
		}
	};
		//이외에 공지 / 채팅방얼리기 등 다양한 방법이 있기 때문에  else if로 처리
		
		// 사용자 목록에서 아이디 클릭 시, @+아이디 입력
// 		$(".client-list").on("click", "list-group-item label", function() {
// 		    var memberEmail = $(this).text();
// 		    $(".message-input").val("@" + memberEmail + " ");
// 		    $(".message-input").focus();
// 		});
	$(".client-list").on("click", ".list-group-item label", function() {
    var memberEmail = $(this).text();
    var messageInput = $(".message-input");
    var currentMessage = messageInput.val();

    // 현재 입력값이 비어 있지 않다면, 공백과 함께 memberEmail를 추가합니다.
    if (currentMessage.length > 0) {
        return;
    } 
    else {
        // 입력값이 비어 있다면 memberEmail를 그대로 입력합니다.
        messageInput.val("@" + memberEmail + " ");
    }

    // 입력창에 포커스를 주세요.
    messageInput.focus();
});

		
// 		Toastify({
// 			  text: data.content,
// 			  duration: 3000,
// 			  newWindow: true,
// 			  close: true,
// 			  gravity: "bottom", // `top` or `bottom`
// 			  position: "right", // `left`, `center` or `right`
// 			  stopOnFocus: true, // Prevents dismissing of toast on hover
// 			  style: {
// 			    background: "linear-gradient(to right, #00b09b, #96c93d)",
// 			  },
// 			  onClick: function(){} // Callback after click
// 			}).showToast();
	
	var chatRoomNo = "${chatRoomNo}";
	
	//메세지 전송 함수
	function sendMessage() {
	    var input = $(".message-input").val();
	    if (input.length === 0) return;

	    if(input.startsWith("@")) { //@로 시작하면
	    	var space = input.indexOf(" ");
	    	if(space == -1) return;
	    	
	    	var obj = {
	    		type: 'message', 
	    		target : input.substring(1, space),
	    		content : input.substring(space+1),
	    		chatRoomNo : chatRoomNo,
	    	};
		    var str = JSON.stringify(obj);
		    window.socket.send(str);
	    }
	    else {
		    var obj = {
		    	type: 'message',
		        content: input,
		        chatRoomNo : chatRoomNo,
		    };
		    var str = JSON.stringify(obj);
		    window.socket.send(str);    
		}
	    $(".message-input").val("");
	}
	
	//엔터키
	$(".message-input").on("keypress", function(event) {
	    if (event.which === 13) {
	        sendMessage();
	    }
	});
	//전송 버튼을 클릭하면 입력한 메세지를 가져와서 서버로 전달
	$(".send-btn").click(sendMessage);
	
</script>
</body>

<%-- <jsp:include page="/WEB-INF/views/template/Footer.jsp"></jsp:include> --%>