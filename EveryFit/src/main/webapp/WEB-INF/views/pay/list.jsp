<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../template/Header.jsp"%>
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
<div class="d-flex ">
		<div class="box ">
			<div>
				<div class="row">
					<div class="col">
					 <c:if test="${memberDto.memberLevel == '프리미엄'}">
      						<h3>♥프리미엄 회원권♥</h3>
     					 <div class="col main-image"><img src="/images/moinCard.png" ></div>
   					 </c:if>
					</div>
				</div>
			</div>
		</div>
</div>


<div class="d-flex ">
		<div class="box ">
			<div>
				<div class="row">
					<div class="col">
					 <c:forEach var="PaymentListByMemberVO" items="${PaymentListByMemberVO}">
      <c:if test="${PaymentListByMemberVO.moimMemberLevel == '모임장'}">
      <%-- ${PaymentListByMemberVO} --%>
      <div>
        <h3>♥프리미엄 모임권♥ - 모임 : [${PaymentListByMemberVO.moimTitle}]</h3>
        <p>[${PaymentListByMemberVO.moimTitle}] 은 "${PaymentListByMemberVO.moimEndTime}" 까지 프리미엄 유지됩니다.</p>
      </div>
       <div class="col text-start"><img src="/images/moinCard.png" ></div>
      <div class="text-center">
      
        <a href="#" class="ataglink" onclick="confirmCancellation(${PaymentListByMemberVO.periodPaymentNo})">
          [${PaymentListByMemberVO.moimTitle}] 프리미엄 카드 구독 취소
        </a>
      </div>
      </c:if>
    </c:forEach>
					</div>
				</div>
			</div>
		</div>
</div>

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
<%@ include file="../template/Footer.jsp"%>

<script>
  function confirmCancellation(periodPaymentNo) {
    
	  var confirmCancel = confirm("정말 프리미엄 카드 구독을 취소하시겠습니까?");
    if (confirmCancel) {
      // If user clicks OK, navigate to the cancellation URL
      window.location.href = window.contextPath + "/pay/periodCancel?periodPaymentNo=" + periodPaymentNo;
    }
    // If user clicks Cancel, do nothing
  }
  // 취소 상태 속성을 확인하고 존재하면 모달 표시
/*   <c:if test="${not empty cancellationStatus}">
    $(document).ready(function() {
      // 여기에 모달 표시 코드를 추가하세요
      alert("프리미엄 카드 구독이 취소되었습니다.");
    });
  </c:if> */
  
  // 취소 상태 속성을 확인하고 존재하면 모달 표시
  <c:if test="${not empty cancellationStatus}">
    $(document).ready(function() {
      // 모달 표시
      $('#cancellationModal').modal('show');
    });
  </c:if>
</script>