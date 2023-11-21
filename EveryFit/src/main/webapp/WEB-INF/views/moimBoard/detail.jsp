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
<body>


	<script>
		$(function() {
			$(".reply-insert-form").submit(function(e) {
				e.preventDefault();
				$.ajax({
					url : window.contextPath + "/rest/moimBoardReply/add",
					method : "post",
					data : $(e.target).serialize(),
					success : function(response) {
						console.log(response);
						$("[name=moimBoardReplyContent]").val("");
						reloadList();
					}
				});
			});

			reloadList();
			function reloadList() {
				var params = new URLSearchParams(location.search);
				var moimBoardNo = params.get("moimBoardNo");
				var memberId = "${sessionScope.name}";

				$
						.ajax({
							url : window.contextPath
									+ "/rest/moimBoardReply/list",
							method : "post",
							data : {
								moimBoardNo : moimBoardNo
							},
							success : function(response) {
								$(".reply-list").empty();
								for (var i = 0; i < response.length; i++) {
									var reply = response[i];
									var template = $("#reply-template").html();
									var htmlTemplate = $.parseHTML(template);

									$(htmlTemplate).find(".replyWriter").text(
											reply.memberEmail || "unknown");
									$(htmlTemplate).find(".replyContent").text(
											reply.moimBoardReplyContent);

									$(htmlTemplate).find(".moimBoardReplyNo")
											.text(reply.moimBoardReplyNo);

									if (memberId.length == 0
											|| memberId != reply.memberEmail) {

										$(htmlTemplate).find(".replyButton")
												.empty();
									}
									$(htmlTemplate)
											.find(".btn-delete")
											.attr("data-reply-no",
													reply.moimBoardReplyNo)
											.click(
													function(e) {
														var moimBoardReplyNo = $(
																this)
																.attr(
																		"data-reply-no");
														$
																.ajax({
																	url : window.contextPath
																			+ "/rest/moimBoardReply/delete",
																	method : "post",
																	data : {
																		moimBoardReplyNo : moimBoardReplyNo
																	},
																	success : function(
																			response) {
																		reloadList();
																	},
																});
													});

									$(htmlTemplate)
											.find(".btn-edit")
											.attr("data-reply-no",
													reply.moimBoardReplyNo)
											.click(
													function() {
														var editTemplate = $(
																"#reply-edit-template")
																.html();
														var editHtmlTemplate = $
																.parseHTML(editTemplate);

														var moimBoardReplyNo = $(
																this)
																.attr(
																		"data-reply-no");

														var moimBoardReplyContent = $(
																this)
																.parents(
																		".view-container")
																.find(
																		".replyContent")
																.val();

														$(editHtmlTemplate)
																.find(
																		"[name=moimBoardReplyNo]")
																.val(
																		moimBoardReplyNo);
														$(editHtmlTemplate)
																.find(
																		"[name=moimBoardReplyContent]")
																.val(
																		moimBoardReplyContent);

														$(editHtmlTemplate)
																.find(
																		".btn-cancel")
																.click(
																		function() {
																			$(
																					this)
																					.parents(
																							".edit-container")
																					.prev(
																							".view-container")
																					.show();
																			$(
																					this)
																					.parents(
																							".edit-container")
																					.remove();
																		});

														$(editHtmlTemplate)
																.submit(
																		function(
																				e) {

																			e
																					.preventDefault();
																			$
																					.ajax({
																						url : window.contextPath
																								+ "/rest/moimBoardReply/edit",
																						method : "post",
																						data : $(
																								e.target)
																								.serialize(),
																						success : function(
																								response) {
																				
																							reloadList();
																						}
																					});
																		});
														$(this)
																.parents(
																		".view-container")
																.hide()
																.after(
																		editHtmlTemplate);
													});
									$(".reply-list").append(htmlTemplate);
								}
							},
						});
			}
		});
	</script>






	<script id="reply-template" type="text/template">
		<div class="row bg-primary view-container container" 
style="border-width: 0px 0px 1px 0px ; border-style: solid ;  border-color: white;" >

<div class="row">
			<div class="col  text-light">
<div class= "row ">
		<div class="col-1 ">name :</div>
		<div class="col-9 "><p class="replyWriter">작성자</p>
</div>		
</div>

<div class= "row">
		<div class="col-1 pe-0"> content : </div>
		<div class="col-9 "><pre class="replyContent">내용</p>
</div>
</div>
	
				

			</div>
</div>
			<div class="replyButton row ">
			<button class="btn btn-edit btn-navy text-light  col-5 offset-1">
				<div class=" right bg-success text-center">
		
						<i class="fa-solid fa-edit "></i>
						수정	
				</div>
</button>

<button class="btn btn-orange btn-delete text-light  col-5">
				<div class=" right bg-danger text-center">
						<i class="fa-solid fa-trash"></i>
						삭제
				</div>
</button>
			</div>
		</div>

</script>
	<script id="reply-edit-template" type="text/template">

		<form class="reply-edit-form edit-container   row bg-light">
		<input type="hidden" name="moimBoardReplyNo" value="?">
		<div class="row flex-container p-0 m-0">
			<div class="row" style = "width = 1062px" >
				<textarea name="moimBoardReplyContent" class="form-input  bg-primary text-light" rows="4"  
placeholder="수정 내용을 적어주세요">
</textarea>
			</div>
			<div class="row">
				<div class="col-5 right offset-1" style="height: 21px">
					<button type="submit" class="btn btn-positive bg-success w-100 text-light"  >
						<i class="fa-solid fa-check"></i>
						수정
					</button>
				</div>
				<div class="col-5 right " style="height: 21px">
					<button type="button" class="btn btn-negative btn-cancel bg-danger w-100 text-light"  >
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
			</div>
		</div>
		</form>
</script>





	<div class="container">

		<div class="row">
			<div class="col-4 offset-4 p-5 m-4 bg-primary rounded-3  text-light">
				<h1 class="display-5 fw-bold">${moimBoardDto.moimBoardTitle}</h1>
			</div>
		</div>

		<div class="row">
			<a href="/moim/board/list?moimNo=${moimBoardDto.moimNo}"
				style="text-decoration: none"
				class="text-end btn-light fw-bold  p-4"> 목록으로 돌아가기 </a>
		</div>

		<div class="row">

			<div class="col-1 offset-9">
				<a href="edit?moimBoardNo=${moimBoardDto.moimBoardNo}"
					class="text-light" style="text-decoration: none">
					<div class="text-center bg-info rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-gear"></i></h7>
					</div>
				</a>
			</div>
			<div class="col-1">
				<a href="delete?moimBoardNo=${moimBoardDto.moimBoardNo}"
					class="text-light" style="text-decoration: none">
					<div class="text-center bg-danger rounded-3  text-light">
						<h7 class="display-5"> <i class="fa-solid fa-trash-can"></i></h7>
					</div>
				</a>
			</div>

		</div>
	</div>

	<div class="row mt-3">
		<div class="col-8 offset-2">

			<table class="table">
				<tr class="table-primary text-center ">
					<th class="fw-bold">번호</th>
					<th class="fw-bold">카테고리</th>
					<th class="fw-bold">제목</th>

				</tr>
				<tr class="text-center">

					<td class="fw-bold text-primary">${moimBoardDto.moimBoardNo}</td>
					<td class="fw-bold text-primary">${moimBoardDto.moimBoardCategory}</td>
					<td class="fw-bold text-primary">${moimBoardDto.moimBoardTitle}</td>

				</tr>


			</table>

			<div class="fw-bold text-center text-bg-primary">내용</div>
			<div class="fw-bold text-primary" style="border: 1px solid white;">
				${moimBoardDto.moimBoardContent}
				<hr>
			</div>



			<div class="row  ps-2 ms-2">
				<div class="col-3 offset-4 p-3 m-4 bg-primary rounded-3  text-light"
					style="height: 100px">

					<h1 class="display-5 fw-bold ms-4">Comment</h1>
				</div>
			</div>

			<div class="container reply-list"></div>


			<c:if test="${sessionScope.name != null }">

				<form class="reply-insert-form p-2 m-2" method="post">
					<input type="hidden" name="moimBoardNo"
						value="${moimBoardDto.moimBoardNo}">
					<div class="row ">
						<textarea class="form-input  bg-primary  text-light fw-bold "
							name="moimBoardReplyContent" rows="4"></textarea>
					</div>
					<div class="row">
						<button type="submit"
							class="btn btn-positive w-50 bg-primary text-light fw-bold mt-3 offset-3">
							<i class="fa-solid fa-pen text-light"></i>Comment insert
						</button>
					</div>
				</form>

			</c:if>


		</div>

	</div>
	</div>


	</div>
</body>
</html>
<jsp:include page="../template/Footer.jsp"></jsp:include>