<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<style>
  .ataglink {
    display: inline-block;
    padding: 10px 20px;
    background-color: orange;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
      .box {
	margin: 20px;
	padding: 30px;
	border: 1px solid orange;
	border-radius: 14px;
}
.main-image {
	width: 100%;
	height: 300px;
	 max-width : 700px;
	/* 	max-width: 500px;
	max-height: 300px; */
}
</style>

<div class="container-fluid ">
	<div class="row">
		<div class="col-md-10 offset-md-1">
<h2 class="ms-3">프리미엄 카드 내역</h2>
<div class="ms-3" style="border-top: 1px solid gray; width: 700px; margin: 10px 0;"></div>
<h4 class="ms-3">[${memberDto.memberName}(${memberDto.memberEmail})]</h4>

<c:if test="${memberDto.memberLevel != '프리미엄'}">
<div class="ms-3"><br>프리미엄 회원권이 존재하지 않습니다</div>
</c:if>

<c:if test="${memberDto.memberLevel == '프리미엄'}">
	<div class="d-flex ">
		<div class="box ">
			<div>
				<div class="row">
					<div class="col">
      						<h3>♥프리미엄 회원권♥</h3>
     					 <div class="col main-image"><img src="/images/moinCard.png" ></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
   					

					 <c:forEach var="PaymentListByMemberVO" items="${PaymentListByMemberVO}">
		
      <c:if test="${PaymentListByMemberVO.moimMemberLevel == '모임장'}">
<div class="d-flex ">
		<div class="box ">
			<div>
				<div class="row">
					<div class="col">
      <%-- ${PaymentListByMemberVO} --%>
      <div>
        <h3>♥프리미엄 모임권♥ - 모임 : [${PaymentListByMemberVO.moimTitle}]</h3>
        <p>[${PaymentListByMemberVO.moimTitle}] 은 "${PaymentListByMemberVO.moimEndTime}" 까지 프리미엄 유지됩니다.</p>
      </div>
       <div class="col text-start"><img src="/images/moinCard.png" ></div>
      <div class="text-start">
      
<a href="#" class="ataglink" onclick="confirmCancellation('${PaymentListByMemberVO.periodPaymentNo}', '${PaymentListByMemberVO.moimTitle}', '${PaymentListByMemberVO.moimEndTime}')">
  [${PaymentListByMemberVO.moimTitle}] 프리미엄 카드 구독 취소
</a>
      </div>
					</div>
				</div>
			</div>
		</div>
</div>
      </c:if>
    </c:forEach>



</div>
</div>
</div>

				

<!-- 모달 코드 추가 -->
<div class="modal fade" id="cancellationModal" tabindex="-1" role="dialog" aria-labelledby="cancellationModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="cancellationModalLabel">알림</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        프리미엄 카드 구독이 취소되었습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<script>
  function confirmCancellation(periodPaymentNo, moimTitle, moimEndTime) {
    var confirmMessage = "[" + moimTitle + "] 프리미엄 카드 구독을 \n취소하시겠습니까?\n\n";
    confirmMessage += "정기결제 취소를 하시더라도 " + "\"" + moimEndTime + "\" 까지 프리미엄 유지됩니다.";

    var confirmCancel = confirm(confirmMessage);
    if (confirmCancel) {
      // If user clicks OK, navigate to the cancellation URL
      window.location.href = "${pageContext.request.contextPath}/pay/periodCancel?periodPaymentNo=" + periodPaymentNo;
    }
    // If user clicks Cancel, do nothing
  }

  // 취소 상태 속성을 확인하고 존재하면 모달 표시
  <c:if test="${not empty cancellationStatus}">
    $(document).ready(function() {
      // 모달 표시
      $('#cancellationModal').modal('show');
    });
  </c:if>
</script>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%>