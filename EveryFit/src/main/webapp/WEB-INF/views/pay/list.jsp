<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../template/Header.jsp"%>
<style>
  .ataglink {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007BFF;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
</style>
<div class="row ms-2">
<h1>${memberDto.memberEmail} 님이 보유한 프리미엄 카드 리스트</h1>

  <div class="col">
    <c:if test="${memberDto.memberLevel == '프리미엄'}">
      <h3>프리미엄 회원권 카드</h3>
      <div class="col text-start"><img src="/images/moinCard.png" ></div>
    </c:if>
    <hr>

    <c:forEach var="PaymentListByMemberVO" items="${PaymentListByMemberVO}">
      <div>
        <h3>[${PaymentListByMemberVO.moimTitle}] 모임을 위한 프리미엄 카드</h3>
      </div>
       <div class="col text-start"><img src="/images/moinCard.png" ></div>
      <div>
        <a href="#" class="ataglink" onclick="confirmCancellation(${PaymentListByMemberVO.periodPaymentNo})">
          [${PaymentListByMemberVO.moimTitle}] 프리미엄 카드 구독 취소
        </a>
      </div>
    </c:forEach>
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
      window.location.href = "periodCancel?periodPaymentNo=" + periodPaymentNo;
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