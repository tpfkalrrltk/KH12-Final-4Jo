<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="/WEB-INF/views/template/Header.jsp"%>

<style>
.jungmo-image {
/*    width: 250px; */
   height: 200px;
}
.member-profile {
   width: 50px;
   height: 50px;
}
.profile-image {
/*    width: 400px; */
   height: 400px;
}
.popup-menu {
    display: none;
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 10px;
    z-index: 1000;
}

.bar-popup-menu {
    display: none;
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 10px;
    z-index: 1000;
}

.fa-bars {
   position: relative;
   display: inline-block;
   cursor: pointer; /* 클릭 가능한 커서로 변경 */
}

/* 이미지를 감싸는 컨테이너의 스타일 */
.image-container {
   position: relative;
   display: inline-block;
   cursor: pointer; /* 클릭 가능한 커서로 변경 */
}

.disabled {
   pointer-events: none;
   opacity: 0.5; 
}

textarea {
    resize: none;
}

a {
   text-decoration: none;
}

.miom-content {
    min-height: 100px; 
    padding: 5em;   
    line-height: 2;  
}

.moim-member-profile {
   width: 200px;
   height: 200px;
}


#moim-badge {
   padding:0 !important;
}

.fa-crown {
  position: absolute;
  bottom: 0;
  left: 2.65em;
  width: 100%;
  max-width: 1200px; /* 필요에 따라 조절 */
}


.member-list {
/* 	height: 400px; */
/* 	min-height: 200px; */
	overflow-y:scroll;
	overflow-x: hidden;
	padding-bottom: 20px;
}

::-webkit-scrollbar {
    width: 1px;
}
::-webkit-scrollbar-thumb {
    background: var(--bs-secondary); /* 스크롤바 배경 색상 */
    border-radius: 5px; /* 스크롤바 엄지 모서리 둥글게 */
}

.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
}

.box {
/*    margin: 20px; */
   padding: 30px;
   border: 1px solid lightgray;
   border-radius: 14px;
}

.cursor{
  cursor:pointer;
 }
</style>

<title>모임 상세페이지</title>

<div class="modal" id="myModal" 
tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- 모달 내용 -->
      <div class="myModal-body p-4">
        <span class="col">모임이 비활성화 되었습니다. </span><br>
        <span class="col"><a href="${pageContext.request.contextPath}/pay?productNo=2">프리미엄 모임권으로 업그레이드하세요!</a></span>
        <div class="text-end text-danger mt-4   ">
        <a class="dropdown-item" href="member/exit?moimNo=${moimDto.moimNo}">탈퇴하기</a>
        </div>
        <div class="text-end text-primary">
        <label><a class="link" href="${pageContext.request.contextPath}/default/${moimDto.chatRoomNo}" style="text-decoration: none;">채팅방</a></label>       
        </div>
        <div class="text-end text-primary">
        <label><a class="link" href="${pageContext.request.contextPath}/faq/list" style="text-decoration: none;">문의하기</a></label>       
        </div>
      </div>
    </div>
  </div>
</div>


<div class="container-fluid">
   <div class="row">
      <div class="col-md-8 col-lg-6 offset-md-2">
      
         <div class="row text-end">
            <i class="fa-solid fa-bars" style="color: #b0b0b0;" id="barToggleMenu" ></i>
         </div>
         <div class="bar-popup-menu bar-dropdown-menu" id="approvedMenu" style="left:65%;">
             <!-- Y일 때 보여질 팝업 메뉴 내용 모임장,매니저 일 때 -->
             <a class="dropdown-item exit-btn" href="${pageContext.request.contextPath}/member/exit?moimNo=${moimDto.moimNo}">탈퇴하기</a>
             <button class="dropdown-item edit-mode">모임관리</button>
         </div>
         
         <div class="bar-popup-menu bar-dropdown-menu" id="blockedMenu" style="left:65%;">
             <!-- N일 때 보여질 팝업 메뉴 내용 -->
             <a class="dropdown-item exit-btn" href="${pageContext.request.contextPath}/member/exit?moimNo=${moimDto.moimNo}">탈퇴하기</a>
         </div>
         
         
         <div class="row">
         <div class="col-10">
         <label class="fs-1 fw-bold">${moimDto.moimTitle}</label>
         <span class="badge rounded-pill text-bg-info" style="bottom:2.5em;"> ${moimDto.moimState}</span>
         </div>
         <div class="col-2 text-end">
         <i class="fa-solid fa-heart fa-2xl mr-2 heart" style="color: #ff8080; margin-top:1em;"></i>
         <span class="heart-span" style="color: #ff8080;"></span>
         </div>
<!--          <i class="fa-regular fa-heart red"></i>  -->
<!--          <i class="fa-solid fa-heart fa-2xl" style="color: #ff8080;"></i> -->
<!--          <span class="heart-span" style="color: #ff8080;"></span> -->
         <!-- 세션값의 모임멤버 레벨이 모임장일 때 보여줌 -->
<!--          <div class="row mt-3 ml-0"> -->
<!--          <button type="button" class="btn btn-danger opacity-50 profile-delete">사진삭제</button> -->
         
<!--          </div> -->
         </div>

               <div class="row">

                  <c:choose>
                     <c:when test="${profile == null}">
                        <img src="${pageContext.request.contextPath}/images/add-moim-image.png" class="rounded profile-image w-100 object-fit-cover">
                     </c:when>
                     <c:otherwise>
                        <img src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${profile}"
                           class="rounded profile-image w-100 object-fit-cover">
                     </c:otherwise>
                  </c:choose>
                  <div class="col text-end">
                  <label> 
                  <!--  라벨을 만들고 파일선택창을 숨김 -->
                  <input type="file" class="profile-chooser"
                     accept="image/*" style="display:none;">
<!--                      <i class="fa-solid fa-user fa-2x"></i> -->
                     <i class="fa-solid fa-image fa-2x" style="color: #4582ec; display:none;"></i>
                  </label> 
                  
                     <i class="fa-solid fa-square-xmark profile-delete fa-2x" style="color: #4582ec; display:none"></i>
                  </div>
                  
                  </div>
<%--             <h1 class="display-4 bg-primary opacity-75 rounded text-light p-5">${moimDto.moimTitle}</h1> --%>

               <div class="row p-0 m-0 pt-2"><div class="col" id="moim-badge">
               <span class="badge rounded-pill text-bg-primary">${locationDto.locationDepth1}</span>
               <span class="badge rounded-pill text-bg-primary">${locationDto.locationDepth2}</span>
               <span class="badge rounded-pill text-bg-primary"> ${eventDto.eventName}</span>
               <c:if test="${moimDto.moimUpgrade == 'Y'}">
                  <span class="badge rounded-pill text-bg-info gender-check">프리미엄</span>
               </c:if>
               <c:if test="${moimDto.moimGenderCheck == 'Y'}">
                  <span class="badge rounded-pill text-bg-warning gender-check">여성전용</span>
                  <input type="checkbox" name="moimGenderCheck"
                     style="display: none;">
               </c:if>
               <span class="badge rounded-pill text-bg-primary">멤버 ${memberCount}</span>
            </div></div>

            <div class="miom-content mt-4 mb-4 p-3 ">${moimDto.moimContent}</div>
         
         
         
         
   <div class="row">
   <div class="col">
   <div class="card-body">
      
<%--       ${profile} --%>
<%--       ${moimDto} --%>
      <div class="row">
      <div class="col text-end">
      
      <button class="moim-edit btn btn-primary" style="display:none;">모임수정</button>

      <div class="row"><div class="col">

      </div></div>
      <div class="row"><div class="col">
      </div></div>
      <div class="row"><div class="col">   
      </div></div>
      </div>
      </div>
   </div>

   <button class="btn btn-primary jungmo-create"  type="button" style="display:none;">정모등록</button>

         
         </div>
<h3>정기모임</h3>
   <div class="mb-1 items-center" style="max-width: 50rem;">
      <c:forEach var="jungmoList" items="${jungmoTotalList}">
<!--       <div class="card-body  p-0"> -->
            <div class="card mb-1">
               <div class="card-body">
               <div class="row">
               <div class="col-10">
            <fmt:formatDate value="${jungmoList.jungmoListVO.jungmoSchedule}" 
            pattern="M월 d일 (E)"/>
               <span class="text-danger"> 
                  <c:choose>
                  <c:when test="${jungmoList.jungmoListVO.dday == 0}">
                     D - ${jungmoList.jungmoListVO.dday + 1} 
                  </c:when>
                  <c:otherwise>
                  D - ${jungmoList.jungmoListVO.dday}
                  </c:otherwise>
                  </c:choose>
                  <span class="badge bg-info p-1" >${jungmoList.jungmoListVO.jungmoStatus}</span>
               </span>
               </div>
               <div class="col-2 text-end">
               <label class="jungmo-edit" style="display:none;" data-jungmo-no="${jungmoList.jungmoListVO.jungmoNo}"><i class="fa-regular fa-calendar-check" style="color: #4582ec;"></i></label>
               <label class="jungmo-cancel" style="display:none;" data-jungmo-no="${jungmoList.jungmoListVO.jungmoNo}"> 
               <a href="${pageContext.request.contextPath}/jungmo/cancel?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}" 
               style="text-decoration: none;">
               <i class="fa-regular fa-calendar-xmark" style="color: #4582ec;"></i>
               </a>
               </label>
               </div>
               </div>
               <h4 class="mt-2">${jungmoList.jungmoListVO.jungmoTitle}</h4>               
               <div class="row">
               <div class="col-5 p-1">
               <c:choose>
               <c:when test="${jungmoList.jungmoListVO.jungmoImageAttachNo != null}">
                  <img class="jungmo-image rounded object-fit-cover w-100" src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${jungmoList.jungmoListVO.jungmoImageAttachNo}">
               </c:when>
               <c:otherwise>
                  <img class="jungmo-image rounded object-fit-cover w-100" src="${pageContext.request.contextPath}/images/user.png">
               </c:otherwise>
               </c:choose>         
               </div>
               <div class="col-7 p-3">      
               <div class="row">            
                  <label class="form-label">일시 : <fmt:formatDate value="${jungmoList.jungmoListVO.jungmoSchedule}" pattern="yy년 MM월 dd일 (E) a hh:mm"/>
                  </label>      
               <div class="row">
                  <span class="form-label">장소: ${jungmoList.jungmoListVO.jungmoAddr}
                  <c:if test="${jungmoList.jungmoListVO.jungmoAddrLink != null}">
                  <a href="${jungmoList.jungmoListVO.jungmoAddrLink}" style="text-decoration: none;">지도보기</a>
                  </c:if>                  
                  </span>
               </div>
                  
               </div>
               <div class="row">
                  <span class="form-label">참가비 : 
                  <fmt:formatNumber value="${jungmoList.jungmoListVO.jungmoPrice}" pattern="#,##0원"/></span>
               </div>
               <div class="row">
               <label class="form-label">인원 : ${jungmoList.jungmoListVO.memberCount != null ? jungmoList.jungmoListVO.memberCount : 0}
                  / ${jungmoList.jungmoListVO.jungmoCapacity}</label>
               </div>
               <div class="row">
               <label><a class="link chat-link" href="${pageContext.request.contextPath}/default/${jungmoList.jungmoListVO.chatRoomNo}" style="text-decoration: none;">채팅방가기</a></label>       
               </div>
                              
<%--          <a class="btn btn-primary" href="jungmo/edit?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}" class="text-light">정모수정</a> --%>
               <div class="col text-end">
               <a class="btn btn-primary" 
               href="jungmo/join?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light joinButton">참가</a>
               <a class="btn btn-warning" 
               href="jungmo/exit?jungmoNo=${jungmoList.jungmoListVO.jungmoNo}&memberEmail=${sessionScope.name}" class="text-light">취소</a>
               </div>
                     </div>
                     </div>
                     <div class="row">
                     <div class="col p-2">
                           <c:forEach var="jungmoMember" items="${jungmoList.jungmoMemberList}">
                                 <c:choose>
                                 <c:when test="${jungmoMember.attachNo != null}">
                                 <img class="member-profile rounded-circle object-fit-cover" src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${jungmoMember.attachNo}" >
                                 </c:when>
                         <c:otherwise>
                                 <img class="member-profile rounded-circle" src="${pageContext.request.contextPath}/images/user.png" >
                         </c:otherwise>
                                 </c:choose>
                          </c:forEach>
                     </div>
                     </div>


               </div>
            </div>
<!--             </div> -->
         </c:forEach>
      </div>
          
             
                   </div>

               </div>
               
<div class="col-lg-2 col-md-3">
            <div class="row box" >
            <c:forEach var="moimMemberDto" items="${memberList}">
               <c:if test="${sessionScope.name == moimMemberDto.memberEmail}">
               <div class="row"><div class="col-4 d-flex align-items-center justify-content-center p-0">
                  <img src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${moimMemberDto.attachNo}" 
                  class="rounded-circle object-fit-cover" width="60px;" height="60px;" >
               </div>
               <div class="col-8">
                  <label class="form-label mb-0">${moimMemberDto.memberNick}</label>
                  <label class="form-label" style="font-size:14px;">${moimMemberDto.moimMemberJoin} 가입</label>
                  
               </div>
               </div>
               <div class="row mt-4"><div class="col">
               <label class="form-label">${moimMemberDto.moimMemberLevel}</label>
               </div></div>
               <div class="row"><div class="col">
               <label class="form-label">취소 카운트 : </label>               
               <label class="form-label">${moimMemberDto.moimMemberCancelCount}</label>
               </div></div>
               <div class="row"><div class="col">
               <label class="form-label">내 상태 : </label>               
               <label class="form-label">${moimMemberDto.moimMemberStatus}</label>
               </div></div>
               <div class="row"><div class="col">
               </div></div>
               <div class="row"><div class="col">
               </div></div>
               <div class="row"><div class="col">
               </div></div>
               </c:if>
            </c:forEach>
            </div>
   
            <nav id="sidebar" class="row">
                <!-- Sidebar Content -->
                <ul class="nav flex-column text-center box">
                    <li class="nav-item p-3 moim-member-list cursor">
                  <span class="text-primary fs-6 fw-bold">회원목록 <i class="fa-solid fa-users" style="color: #6582e4;"></i></span>
                    </li>
                    <li class="nav-item p-3">
                        <a href="${pageContext.request.contextPath}/default/${moimDto.chatRoomNo}"><span class="fs-6 fw-bold chat-link">채팅방 <i class="fa-solid fa-comment" style="color: #6380e0;"></i></span></a>
                    </li>
                    <li class="nav-item p-3">

                  <a href="${pageContext.request.contextPath}/moim/board/photoList?moimNo=${moimDto.moimNo}"><span class="fs-6 fw-bold">모임 게시판</span>
                  <i class="fa-solid fa-table-list" style="color: #6582e4;"></i></a>

                    </li>
                    <!-- 추가적인 메뉴 항목들을 필요에 따라 추가하세요 -->
                     <c:if test="${leagueList.size()>0}">
                       <li class="nav-item p-3 cursor league-list-btn cursor">
                          <span class="text-primary fs-6 fw-bold">참여중인 리그 <i class="fa-solid fa-ranking-star"></i></span>
                       </li>
                    </c:if>
                </ul>
            </nav>

            </div>
            </div>
         </div>
         
         
<!-- 모달창 -->
<div class="modal fade" id="applicationModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel ">모임 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <!-- 모임 수정내용 -->
      <div class="moim-edit-inputs" style="display: none;">
      <form id="appInsert" method="post" autocomplete="off">
         <input type="hidden" name="moimNo" value="${moimDto.moimNo}"  class="form-control">
         <input type="hidden" name="LocationNo" value="${moimDto.locationNo}"  class="form-control">
         <input type="hidden" name="eventNo" value="${moimDto.eventNo}"  class="form-control">
         <label class="form-label">모임명</label> 
         <input type="text" name="moimTitle" data-original-value="${moimDto.moimTitle}" class="form-control">
         <label class="form-label">모임소개</label> 
         <textarea rows="5" class="form-control" id="summernote" name="moimContent" data-original-value="${moimDto.moimContent}" >${moimDto.moimContent}</textarea>
<%--          <input type="text" name="moimContent" data-original-value="${moimDto.moimContent}" class="form-control"> --%>
         <label class="form-label">모임상태</label> 
         <select name="moimState" data-original-value="${moimDto.moimState}" class="form-select">
            <option>모집중</option>
            <option>마감</option>
         </select>
         <c:if test="${moimDto.moimGenderCheck == 'Y'}">
         <label class="form-check-label">여성전용모임해제</label>
         <input type="checkbox"  id="moimGenderCheck" 
         name="moimGenderCheck" ${moimDto.moimGenderCheck == 'N' ? 'checked' : ''}
         data-original-value="${moimDto.moimGenderCheck}" class="form-check-input`">
         </c:if>
      </form>
      </div>
      
      <!-- 정모 등록/수정 내용 -->
      <div id="jungmoInsert" class="jungmo-create-inputs" style="display: none;">
      <form id="jungmoInsertForm" autocomplete="off" enctype="multipart/form-data" >
         <div class="preview-wrapper1"></div>
         <input type="file" name="attach" accept="image/*" multiple id="attach-selector" class="form-control jungmo-create-inputs">
         <input type="hidden" name="moimNo" value="${moimDto.moimNo}">
         <input type="hidden" name="jungmoNo" value="">
         <label class="form-label">정모명</label>
         <input type="text" name="jungmoTitle" class="form-control jungmo-create-inputs"> 
         <label class="form-label">장소</label>
         <input type="text" name="jungmoAddr" class="form-control jungmo-create-inputs"> 
         <label class="form-label">장소url</label>
         <input type="text" name="jungmoAddrLink" class="form-control jungmo-create-inputs"> 
         <label class="form-label">인원</label>
         <input type="number" name="jungmoCapacity" class="form-control jungmo-create-inputs" min="0"> 
         <label class="form-label">참가비</label>
         <input type="number" name="jungmoPrice" class="form-control jungmo-create-inputs" min="0"> 
         <label class="form-label jungmo-create-inputs">일정</label>
         <input type="datetime-local" name="jungmoDto.jungmoScheduleStr" 
         id="jungmoScheduleStr" 
         class="from-control">
      </form>
      </div>
      
      
   <!-- 회원 정보 내용 -->
   <div class="moim-member-info" style="display: none;">
    </div>
 
    </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="appBtn" style="display: none;">모임수정</button>
        <button type="button" class="btn btn-primary" id="jungmoInsertBtn" style="display: none;">정모등록</button>
        <button type="button" class="btn btn-primary" id="jungmoEditBtn" style="display: none;">정모수정</button>
      </div>
    </div>
</div>
</div>



<!-- 모임멤버모달 -->
<div class="modal" id="modal3">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="list-modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body" >
            <!-- 모임멤버 -->
       <div class="row member-list" style="display:none;">
         <c:forEach var="moimMemberDto" items="${memberList}">
              <div class="image-container">
              <c:choose>
            <c:when test="${moimMemberDto.attachNo != null}">
            <img class="member-profile rounded-circle object-fit-cover" src="${pageContext.request.contextPath}/rest/attach/download?attachNo=${moimMemberDto.attachNo}" data-target="menu-${moimMemberDto.memberEmail}">
            </c:when>
            <c:otherwise>
            <img class="member-profile rounded-circle" src="${pageContext.request.contextPath}/images/user.png" data-target="menu-${moimMemberDto.memberEmail}">
            </c:otherwise>
            </c:choose>
            <c:if test="${moimMemberDto.moimMemberLevel == '모임장'}">
            <i class="fa-solid fa-crown text-warning" ></i>
            </c:if>
            <label>${moimMemberDto.memberNick}
            <c:if test="${sessionScope.name eq moimMemberDto.memberEmail}">
                  <span class="badge p-1"><i class="fa-solid fa-seedling" style="color: #6582e4;"></i></span>
              </c:if>
            </label>
            
            <c:if test="${sessionScope.name != moimMemberDto.memberEmail}" >
             <div class="popup-menu dropdown-menu moimjang-menu" id="menu-${moimMemberDto.memberEmail}" style="display:none;">
                 <c:if test="${moimMemberDto.moimMemberStatus == '미승인'}">
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberApproval?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}" >승인</a>
                 </c:if>
                 <c:choose>
                 <c:when test="${moimMemberDto.moimMemberStatus == '차단'}">
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberApproval?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}" >차단해제</a>
                 </c:when>
                 <c:otherwise>
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberBlock?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}">차단</a>                 
                 </c:otherwise>
                 </c:choose>
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberTransfer?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}">모임장권한넘기기</a>
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberManager?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}">매니저임명하기</a>
                 <a class="dropdown-item" 
                 data-target="menu-${moimMemberDto.memberEmail}" onclick="getMemberInfo('${moimMemberDto.memberEmail}')">회원상세페이지</a>
             </div>
             <div class="popup-menu dropdown-menu manager-menu" id="menu-${moimMemberDto.memberEmail}" style="display:none;">
                 <c:if test="${moimMemberDto.moimMemberStatus == '미승인'}">
                 <a class="dropdown-item" 
                 href="memberApproval?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}" >승인</a>
                 </c:if>
                 <a class="dropdown-item" 
                 href="${pageContext.request.contextPath}/memberBlock?memberEmail=${moimMemberDto.memberEmail}&moimNo=${moimMemberDto.moimNo}">차단</a>
                 <a class="dropdown-item" 
                 data-target="menu-${moimMemberDto.memberEmail}" onclick="getMemberInfo('${moimMemberDto.memberEmail}')">회원상세페이지</a>
             </div>
             <div class="popup-menu dropdown-menu member-menu" id="menu-${moimMemberDto.memberEmail}" style="display:none;">
                 <a class="dropdown-item" 
                 data-target="menu-${moimMemberDto.memberEmail}" onclick="getMemberInfo('${moimMemberDto.memberEmail}')">회원상세페이지</a>
             </div>
             </c:if>
             </div>

              <div class="member-block">
              <c:if test="${moimMemberDto.moimMemberStatus == '차단'}">
                 <label class="badge bg-secondary p-1">모임차단</label>
              </c:if>
              <c:if test="${moimMemberDto.memberBlock == 'Y'}">                    
                 <span class="badge bg-danger p-1">차단회원</span>
              </c:if>
            </div>
         </c:forEach>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<!-- 참여중인 리그 모달 -->
<div class="modal fade" id="leagueList" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">참여중인 리그</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary leagueListClose">닫기</button>
            </div>
        </div>
    </div>
</div>




<div class="modal-overlay"></div>
    
    <c:if test="${sessionScope.name != null}">
    <script>
    
      var moimNo = "${moimDto.moimNo}";
       
       //좋아요 처리
       //[1] 페이지가 로드되면 비동기 통신으로 좋아요 상태를 체크하여 하트 생성
       //[2] 하트에 클릭 이벤트를 설정하여 좋아요 처리가 가능하도록 구현
       $(function(){
//           var params = new URLSearchParams(location.search);
//           var moimNo = params.get("moimNo");
//           console.log(moimNo)

          $.ajax({
             url:window.contextPath+"/rest/moim/likeCheck",
             method:"post",
             data:{moimNo : moimNo},
             success:function(response) {
                //response는 {"check":true, "count":0} 형태의 JSON이다
                if(response.check){
                   $(".fa-heart").removeClass("fa-solid fa-regular")
                                  .addClass("fa-solid");      
                }
                else {
                   $(".fa-heart").removeClass("fa-solid fa-regular").
                                  addClass("fa-regular");      
                }
                //전달받은 좋아요 개수를 하트 뒤의 span에 출력
                $(".fa-heart").next("span").text(response.count);
             }
          });

          //[2]
          $(".fa-heart").click(function() {
             $.ajax({
                url:window.contextPath+"/rest/moim/likeAction",
                method:"post",
                data:{moimNo : moimNo},
                success:function(response) {
                   if(response.check){
                      $(".fa-heart").removeClass("fa-solid fa-regular")
                                     .addClass("fa-solid");      
                   }
                   else {
                      $(".fa-heart").removeClass("fa-solid fa-regular").
                                     addClass("fa-regular");      
                   }
                   //전달받은 좋아요 개수를 하트 뒤의 span에 출력
                   $(".fa-heart").next("span").text(response.count);
                }
             });
             
          });
       });
    </script>

    </c:if>   
         
<body>
   <c:if test="${param.errorFlag != null}">
       <script>
       alert("인원이 꽉 찼습니다.");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.errorFlag2 != null}">
       <script>
       alert("이미 참가한 정모입니다.");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.block != null}">
       <script>
       alert("차단했습니다.");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.approval != null}">
       <script>
       alert("수정 완료");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.transfer != null}">
       <script>
       alert("모임장 권한 넘기기 완료");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.exitError != null}">
       <script>
       alert("모임장 권한을 넘긴 후 탈퇴 가능합니다.");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
   <c:if test="${param.manager != null}">
       <script>
       alert("매니저 임명 완료.");
       window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
       </script>
   </c:if>
</body>

<script>

//    $(document).ready(function () {
//        loadJungmoList();
//    });
       // 클라이언트 측에서 errorFlag를 확인하여 alert를 띄웁니다.
       
   var moimNo = "${moimDto.moimNo}";
   var moimMemberCount = ${moimDto.moimMemberCount};
   
   $("[name=jungmoCapacity]").change(function(){
	   var input = $(this).val();
	   var maxVal = moimMemberCount;
	   
	   if(input > maxVal) {
		   $(this).val(maxVal);
	   }
   });
   
   $(".profile-chooser").change(function(){

      var input = this;
      if(input.files.length == 0) return;
      
      //ajax로 multipart 업로드
      var form = new FormData();
      form.append("attach", input.files[0]);
      form.append("moimNo", moimNo);
      //만일 정모이미지를 변경한다면?
//       form.append("jungmoNo", jungmoNo);
      
      $.ajax({
         url:window.contextPath+"/rest/attach/upload",
         method:"post",
         processData:false,
         contentType:false,
         data:form,
         success:function(response){
            //응답 형태 - { "attachNo" : 7 }
            //프로필 이미지 교체
            $(".profile-image").attr("src", 
               "${pageContext.request.contextPath}/rest/attach/download?attachNo="+response.attachNo);
         },
         error:function(){
            window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
         },
      });
      
   });
   //삭제아이콘을 누르면 프로필이 제거되도록 구현
   $(".profile-delete").click(function() {
      //확인창
      var choice = window.confirm("정말 프로필을 지우시겠습니까?");
      if(choice == false) return;
      
      //삭제요청
      $.ajax({
         url:window.contextPath+"/rest/attach/delete",
         method:"post",
         data:{moimNo: moimNo},
         success:function(response){
            $(".profile-image").attr("src", "${pageContext.request.contextPath}/images/add-moim-image.png");
         },
      });
   });
   
   $("#moimGenderCheck").on("change", function() {
       // 체크박스가 체크되어 있다면 'N', 체크되어 있지 않다면 'Y' 값을 설정
      if (this.checked) {
         this.value = 'N';
         alert("여성모임을 해제하면 다시 변경이 어렵습니다.");
        } else {
            this.checked = true; // 체크를 해제하지 못하게 함
        }
   });

//     $(".gender-check").click(function(){
//         // 여성전용을 나타내는 span이 클릭되면
//         // 해당하는 체크박스를 토글
//         $("[name=moimGenderCheck]").show();

//         // 체크박스 상태에 따라 서버로 값을 전송
//         var isChecked = $("[name=moimGenderCheck]").prop("checked");
//         var valueToSend = isChecked ? "N" : "Y";

//         // AJAX를 사용하여 서버로 데이터 전송
//         //모임번호랑, 체크여부를 보내면 될 듯 Y면 여성전용 해제..인걸로!
//       var vo = {
//          moimGenderCheck: valueToSend,
//          moimNo: moimNoValue
//       };
        
//         $.ajax({
//             url: "http://localhost:8080/rest/moim/genderCheck",
//             type: "POST",
//             data: vo,
//             success: function (response) {
//                 if(response == success) {
//                    $("[name=moimGenderCheck]").hide();                   
//                 }
//             },
//         });
//     });
    var Modal = new bootstrap.Modal(document.getElementById('applicationModal'));
    var Modal3 = new bootstrap.Modal(document.getElementById('modal3'));
    
    $("#appBtn").click(function(){

       var formData = $("#appInsert").serialize();

       $.ajax({
               url: window.contextPath+"/rest/moim/infoChange",
               type: "POST",
               data: formData,
               success: function (data) {
                   // 서버 응답에 따른 동작 수행
                  console.log(data); 
                    alert("변경완료");
                   window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
               },
               error: function (error) {
            	   window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
               }
           });
 
       });
    //등록버튼을 눌렀을 때는 insert해주기
    $("#jungmoInsertBtn").click(function(){
    
        var inputValue = $('#jungmoScheduleStr').val();
        var currentDate = new Date();
        var maxDate = new Date();
        maxDate.setMonth(maxDate.getMonth() + 1);

        // 입력 값이 날짜 및 시간 형식이 아니거나, 범위를 벗어난 경우 알림 표시
        if (!(new Date(inputValue) > currentDate && new Date(inputValue) <= maxDate)) {
            confirm('최소 오늘부터 최대 한 달 후까지만 입력 가능합니다.');
            return;
        }
        
       
       var formData = new FormData(document.getElementById("jungmoInsertForm"));
//        var isCreate = !$("input[name='attach']").val();
//        var isCreate = $("input[name='attach']").val();
   
//        // 조건에 따라 필요한 처리를 수행합니다.
//        if (isCreate) {
//           // create 작업일 경우
          formData.delete("jungmoNo");  // jungmoNo를 제거합니다.
//       }

       $.ajax({
               url:window.contextPath+"/rest/moim/jungmo/create",
               type: "POST",
               data: formData,
               contentType: false,
               processData: false,
               success: function (data) {
                   // 서버 응답에 따른 동작 수행
                  console.log(data); 
                    alert("등록완료");
                   window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
               },
               error: function (error) {
            	   window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
               }
           });
 
       });
    
    
    $("#jungmoEditBtn").click(function(){
        var inputValue = $('#jungmoScheduleStr').val();
        var currentDate = new Date();
        var maxDate = new Date();
        maxDate.setMonth(maxDate.getMonth() + 1);

        if (!(new Date(inputValue) > currentDate && new Date(inputValue) <= maxDate)) {
            confirm('최소 오늘부터 최대 한 달 후까지만 입력 가능합니다.');
            return;
        }
       
       
       var formData = new FormData(document.getElementById("jungmoInsertForm"));
       
       $.ajax({
               url: window.contextPath+"/rest/moim/jungmo/edit",
               type: "POST",
               data: formData,
               contentType: false,
               processData: false,
               success: function (data) {
                   // 서버 응답에 따른 동작 수행
                  console.log(data); 
                    alert("수정완료");
                   window.location.href = "${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}";
                   
                   
               },
               error: function (error) {
            	   window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
               }
           });
 
       });
    
    $('.jungmo-edit').click(function () {
        // 클릭된 버튼에서 data-jungmo-no 속성을 가져옴
        var jungmoNo = $(this).data('jungmo-no');

        // AJAX 요청 보내기
        $.ajax({
            url: window.contextPath+"/rest/moim/jungmo/check",
            type: "POST",
            data: { jungmoNo: jungmoNo },
            success: function (data) {
                // 서버 응답에 따른 동작 수행
                console.log(data);
                $('input[name="jungmoNo"]').val(data.jungmoDto.jungmoNo);
                $('input[name="jungmoTitle"]').val(data.jungmoDto.jungmoTitle);
                $('input[name="jungmoAddr"]').val(data.jungmoDto.jungmoAddr);
                $('input[name="jungmoAddrLink"]').val(data.jungmoDto.jungmoAddrLink);
                $('input[name="jungmoCapacity"]').val(data.jungmoDto.jungmoCapacity);
                $('input[name="jungmoPrice"]').val(data.jungmoDto.jungmoPrice);

                var scheduleDate = new Date(data.jungmoDto.jungmoSchedule);
                var formattedDate = scheduleDate.toISOString().substring(0, 16);
                $('input[name="jungmoDto.jungmoScheduleStr"]').val(formattedDate);
                
                if (data.attachNo) {
                    // 이미지 다운로드 URL을 생성
                    var imageUrl = "${pageContext.request.contextPath}/rest/attach/download?attachNo=" + data.attachNo;

                    // 미리보기 엘리먼트에 이미지 추가
                    $("<img>").attr("src", imageUrl)
                          .css("max-width", "300px")
                          .appendTo(".preview-wrapper1");
                }
                
            },
            error: function (error) {
                // 오류 발생 시 동작 수행
            	window.alert("통신 오류 발생 잠시 후 다시 시도해주세요");
            }
        });
    });
    
    $("#applicationModal").on('hidden.bs.modal', function(){
        location.reload();
     });
    
    $("[name=jungmoAddrLink]").blur(function(){
       var inputText = $(this).val();
       var Regex = /^(.*?)(map.kakao|map.naver|kko|naver)(.*?)$/;
        if (!Regex.test(inputText)) {
            alert("올바른 형식이 아닙니다.");
            // 또는 다른 원하는 처리를 수행할 수 있습니다.
        }
    });
    

   //모달창으로 모임 수정
    $(".moim-edit").click(function(){
        // 모든 input, select, checkbox 필드에 대해 초기화
        $("#appInsert input:not([type='hidden']), #appInsert select").each(function () {
          var originalValue = $(this).data("original-value");
          if ($(this).is("select")) {
            // select는 선택된 옵션으로 초기화
            $(this).val(originalValue);
          } 
          else if ($(this).is("input[type='checkbox']")) {
              // checkbox는 checked 상태로 초기화
              $(this).prop("checked", originalValue === "N");
          }
          else {
            // 나머지는 값으로 초기화
            $(this).val(originalValue);
          }
        });
       
//         $("#applicationModal").modal("show");
      Modal.show();
    });

    // 등록 버튼 클릭 시 모달 닫기
    $("#appBtn").click(function(){
//         $("#applicationModal").modal("hide");
      Modal.hide;
      
    });
    
    //모임수정버튼 눌렀을 때 모달창 띄우고 나머지 숨김
    $('.moim-edit').click(function () {
       $("#applicationModal").modal("show");
        $('.moim-edit-inputs').show();
        $('.jungmo-create-inputs').hide();
      $('#appBtn').show();
      $('#jungmoEditBtn').hide();
      $('#jungmoInsertBtn').hide();
        $('.modal-title').text('모임수정'); // 버튼 텍스트를 '수정'으로 변경
      });
    //정모등록버튼 눌렀을 때 
    $('.jungmo-create').click(function () {
       $('.jungmo-create-inputs input[type!="hidden"]').val('');
       $('.jungmo-create-inputs input[type ="file"]').val('');
       $("#applicationModal").modal("show");
        $('.moim-edit-inputs').hide();
        $('.jungmo-create-inputs').show();
      $('#jungmoInsertBtn').show();
      $('#appBtn').hide();
      $('#jungmoEditBtn').hide();
        $('.modal-title').text('정모등록'); // 버튼 텍스트를 '수정'으로 변경
      });
    
    //정모수정버튼 눌렀을 때
    $('.jungmo-edit').click(function () {
       $(".preview-wrapper1").empty();
       $("#applicationModal").modal("show");
        $('.moim-edit-inputs').hide();
        $('.jungmo-create-inputs').show();
        $('#jungmoEditBtn').show();
      $('#appBtn').hide();
      $('#jungmoInsertBtn').hide();
        $('.modal-title').text('정모수정'); // 버튼 텍스트를 '수정'으로 변경
      });

    //사진 미리보기
    $(function(){
        $("#attach-selector").change(function(){
            $(".preview-wrapper1").empty();
           
            if(this.files.length == 0) {
                //초기화
                return;
            }
            
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
    
    
    var Modal2 = new bootstrap.Modal(document.getElementById('myModal'));
 
    
    //모임이 비활성화 일 때 화면 막기
    if (${moimDto.moimState == '비활성화'}) {
       Modal2.show();
    $(document).on('click', '.modal', function(e){
       if(e.target !== this) return; //모달 내부를 클릭한 경우에는 닫히지 않도록 함
       Modal2.show();
    });
    }    
    
    $(document).on('keydown', function(e) {
        if (e.which === 27) { // 27은 ESC 키 코드
            if (${moimDto.moimState == '비활성화'}) {
               Modal2.show();
            }    
        }
      });
    
    
    function getMemberInfo(memberEmail) {
       
       $('#applicationModal .moim-member-info').empty();
       
        $.ajax({
            url: window.contextPath+"/rest/moim/member/info", 
            type: 'GET',
            data: { memberEmail: memberEmail, moimNo: moimNo },
            success: function(response) {
                // 회원 정보를 표시할 HTML 요소를 선택
                console.log(response);
                var memberInfoContainer = $('.moim-member-info');

                // 받아온 회원 정보를 HTML에 추가
                memberInfoContainer.empty(); // 기존 내용 비우기

                // 회원 정보를 2단으로 표시
                var rowDiv = $('<div>').addClass('row');
                var col1Div = $('<div>').addClass('col-6');
                var col2Div = $('<div>').addClass('col-6  outline rounded mt-4');
            
                // 프로필 이미지 추가
                if (response.attachNo !== null) {
                    var profileImage = $('<img>')
                        .addClass('moim-member-profile rounded-circle mt-1 object-fit-cover')
                        .attr('src', '${pageContext.request.contextPath}/rest/attach/download?attachNo=' + response.attachNo);
                    col1Div.append(profileImage);
                } else {
                    // attachNo가 null인 경우 기본 이미지 사용
                    var defaultImage = $('<img>')
                        .addClass('moim-member-profile rounded-circle object-fit-cover')
                        .attr('src', '${pageContext.request.contextPath}/images/user.png');
                    col1Div.append(defaultImage);
                }

//                 col2Div.append('<p>이메일: ' + response.memberEmail + '</p>');
                col2Div.append('<p>닉네임: ' + response.memberNick + '</p>');

                col2Div.append('<p>모임 멤버 레벨: ' + response.moimMemberLevel + '</p>');
                col2Div.append('<p>모임 멤버 상태: ' + response.moimMemberStatus + '</p>');
                col2Div.append('<p>취소카운트 : ' + response.moimMemberCancelCount + '</p>');

                rowDiv.append(col1Div, col2Div);
                memberInfoContainer.append(rowDiv);
                

                // 모달 열기 등의 특정 동작 수행
                $('.modal-title').text('모임회원 정보');
                $('.moim-member-info').show();
                Modal.show();
            },
            error: function(error) {
                console.error(error);
            }
        });
    }

    
    $('input[name="moimTitle"]').on('input', function () {
        var maxLength = 10; // 최대 글자 수
        var currentLength = $(this).val().length;

        if (currentLength > maxLength) {
            // 입력 길이가 제한을 초과한 경우, 알림창 표시
            alert("최대 한글 20글자까지 입력 가능합니다.");

            // 초과된 부분을 자르고 입력값 설정
            var trimmedValue = $(this).val().substring(0, maxLength);
            $(this).val(trimmedValue);
        }
    });
    

    
    
 // fa-bars를 클릭하면 Ajax 요청을 보냄
    $('#barToggleMenu').click(function(e) {
       
//         e.stopPropagation(); // 이벤트 전파 방지
        var menu = $(this).next('.bar-popup-menu');
        menu.toggle().css({
            'top': $(this).offset().top + $(this).outerHeight(),
//             'left': $(this).offset().left
            'left': $(this).offset().left
        });
        
        // Ajax 요청
        $.ajax({
            url: window.contextPath+"/rest/moim/moimjang/check", 
            type: 'POST', 
            data: { 
               memberEmail: '${sessionScope.name}',
               moimNo : moimNo   
            },
            success: function(response) {
                // 서버 응답에 따라 팝업 메뉴를 보여줌
                if (response === 'N') { 
                    $('#blockedMenu').toggle();
                    $('#approvedMenu').hide();
                }
                else { //매니저면
                    $('#approvedMenu').toggle();
                    $('#blockedMenu').hide();
                }
            },
            error: function() {
                console.error('에러');
            }
        });
    });
 
    
    $('.edit-mode').click(function(e) {
       e.stopPropagation();
        $('.jungmo-create, .moim-edit, .jungmo-edit, .fa-image, .profile-delete, .jungmo-cancel').show();
    });

    // 다른 영역을 클릭하면 모든 팝업 메뉴를 닫음
    $(document).mouseup(function(e) {
        var containers = $('.bar-popup-menu');
        if (!containers.is(e.target) && containers.has(e.target).length === 0) {
            containers.hide();
        }
    });

    $('.moim-member-list').on('click', function () {
        // 여기에 moim-member-list를 보여주는 코드를 추가하세요
        $('.list-modal-title').text('모임멤버');

       // 모달 폭 조절
       $('#modal3 .modal-dialog').removeClass('modal-lg').addClass('modal-sm');
   
       // 모달 위치 이동 (옵션)
       $('#modal3').css('left', '30em'); // 원하는 위치로 수정
        
          Modal3.show();

        $('.member-list').show();
        
        $('.modal-overlay, .btn-close, .btn-secondary').on('click', function () {
            $('#modal3').modal('hide');
            $('.modal-overlay').hide();
        });
        
    });
    
   $('#modal3').draggable({
       handle: ".modal-header"
   });
        
   $('.exit-btn').click(function(e) {
       // 기본 동작 중단 (링크 이동 방지)
       e.preventDefault();
   
       // 확인창 띄우기
       var confirmation = confirm("진짜로 탈퇴하시겠습니까?");
   
       if (confirmation) {
           // 확인을 누르면 링크 이동
           window.location.href = this.href;
       } else {
           // 취소를 누르면 아무런 동작 없음
       }
   });
   
   ////////////////////////////////

    
    $('.image-container').click(function() {
        // 클릭할 때마다 팝업 메뉴의 표시 여부를 토글
         $('.popup-menu').toggle();
       
    });
    function escapeSelector(selector) {
        // @ 기호만 인코딩 처리
        return selector.replace(/@/g, "%40");
    }
       
    $('.member-profile').click(function(e) {
        // 클릭한 이미지의 data-target 값을 가져옴
        var targetId = $(this).data('target');
        var escapedId = '#' + CSS.escape(targetId);
        var memberMenu = $(escapedId);

        // 모든 다른 메뉴 숨기기
        $('.popup-menu').not(memberMenu).hide();

        // 클릭한 대상에 해당하는 메뉴만 토글
        memberMenu.toggle();

        // 이벤트 전파 방지 (부모에 대한 클릭 이벤트 전파를 막음)
        e.stopPropagation();

        // AJAX 요청
        $.ajax({
            url: window.contextPath+"/rest/moim/moimjang/check", 
            type: 'POST', 
            data: { 
                memberEmail: '${sessionScope.name}',
                moimNo : moimNo   
            },
            success: function(response) {
                // 서버 응답에 따라 팝업 메뉴를 보여줌
                if (response === 'Y') { // 모임장이면
                    $('.member-menu').hide();
                    $('.manager-menu').hide();
                    $('.moimjang-menu', memberMenu).toggle();
                } else if (response === 'N') { // 일반회원이면
                    $('.moimjang-menu').hide();
                    $('.manager-menu').hide();
                    $('.member-menu', memberMenu).toggle();
                }
                else { //매니저면
                    $('.moimjang-menu').hide();
                    $('.member-menu').hide();
                    $('.manager-menu', memberMenu).toggle();
                   
                }
            },
            error: function() {
                console.error('에러');
            }
        });
    });
    

    // 문서 전체에 클릭 이벤트 추가
    $(document).click(function() {
        // 모든 메뉴 숨김
        $('.popup-menu').hide();
    });
   
    var maxLength = 4000;
   $("[name=moimContent]").summernote({
        tabsize: 2,
      height: 240,
      fontNames: ['NotoSansKR'],
        fontNamesIgnoreCheck: ['NotoSansKR'],
       toolbar: [
             ['style', ['style']],
             ['font', ['bold', 'underline', 'clear']],
             ['color', ['color']],
             ['para', ['ul', 'ol', 'paragraph']],
             ['table', ['table']],
             ['insert', ['link']],
             ['view', ['codeview', 'help']]
           ],
           callbacks: {
              onPaste: function (e) {
                   // 붙여넣기 이벤트에서 태그 제거
                   var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('Text');
                   e.preventDefault();
                   document.execCommand('insertText', false, bufferText);
               },
                onKeyup: function(e) {
                    // 썸머노트의 내용을 가져오는 함수
                    function getSummernoteContent() {
                        return $('[name=moimContent]').summernote('code');
                    }

                    // 썸머노트 입력값의 길이를 계산하는 함수
                    function calculateContentLength() {
                        var content = getSummernoteContent();
                        var lengthInBytes = new Blob([content]).size;
                        return lengthInBytes;
                    }

                    // 현재 입력값의 길이 계산
                    var currentLength = calculateContentLength();

                    // 최대 길이를 초과하는지 확인
                    if (currentLength > maxLength) {
                        alert("최대 길이를 초과했습니다. 더 이상 입력할 수 없습니다.");
                        // 혹은 다음과 같이 최대 길이 이하로 자르거나, 입력을 무시하는 등의 처리 가능
                        $('[name=moimContent]').summernote('undo');
                        var truncatedContent = getSummernoteContent().substring(0, maxLength);
                        $('[name=moimContent]').summernote('code', truncatedContent);
                    }
                }

           }
     });
   
   


    $(".league-list-btn").click(function(e){
       var moimNo = ${moimDto.moimNo};

       $.ajax({
          method:"post",
          data:{moimNo: moimNo},
          url:window.contextPath + "/rest/league/listLeagueByMoimNo",
          success:function(response){
             var leagueList = response;
             
            var modalContent="";       
            
                for (var i = 0; i < leagueList.length; i++) {
                   modalContent += '<div class="card border-primary m-3">';
                   modalContent += '<div class="card-header">' + '리그번호 : '+ leagueList[i].leagueNo + '</div>';
                    modalContent += '<div class="card-body text-center mt-1">';
                    modalContent += '<h4 class="card-title"><a href="${pageContext.request.contextPath}/league/leagueDetail?leagueNo=' 
                                + leagueList[i].leagueNo + '">' + leagueList[i].leagueTitle +'</a></h4>';
                    
                    modalContent += '<p class="card-text mt-2">리그상태 : ' + leagueList[i].leagueStatus + '</p>';
                      modalContent += '</div></div>';
                    console.log(modalContent);
                }
             
                $('#leagueList .modal-body').empty().append(modalContent);
                
                $("#leagueList").modal("show");
             
          
          },
          error:function(err){
             alert("오류가 발생했습니다. 잠시후 다시 시도해주세요.")
          },
       })
       
       
       
    });
    
    $('.leagueListClose').click(function(){
        $('#leagueList').modal('hide');
    });

    
</script>

<%@ include file="/WEB-INF/views/template/Footer.jsp"%>