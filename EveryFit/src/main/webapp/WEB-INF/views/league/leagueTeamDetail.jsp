<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<div class="container-fluid">
	<div class="row"><div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1">
		<div class="p-5 bg-primary text-light rounded mb-5">
			<div class="row">
				<div class="col-3">
			        <img src="${pageContext.request.contextPath}/league/leagueTeamImage?leagueTeamNo=${leagueTeamDto.leagueTeamNo}" 
			        	class="rounded m-2 w-100" onerror="this.onerror=null; this.src='/images/no-image.png';">
			    </div>
			    <div class="col">
			    	<div class="row"><div class="col">
						<h1>
							${leagueTeamDto.leagueTeamName}
						</h1>
			    	</div></div>
					<hr>
					<div class="row mt-4"><div class="col">
						리그 : ${leagueDto.leagueTitle}
					</div></div>
					<div class="row mt-4 text-end"><div class="col">
						<a href="${pageContext.request.contextPath}/moim/detail?moimNo=${moimDto.moimNo}" class="btn btn-outline-success bg-light">모임정보</a>
						<a href="${pageContext.request.contextPath}/league/leagueDetail?leagueNo=${leagueDto.leagueNo}" class="btn btn-outline-success bg-light">리그페이지</a>
					</div></div>
			    
			    </div>
			</div>
		</div>


		<c:forEach var="matchDto" items="${leagueMatchList}">
			<div class="row mt-5 p-3 border border-light rounded shadow-sm"><div class="col">
				<div class="row text-center">
					<div class="col-2">
						<a href="${pageContext.request.contextPath}/league/leagueTeamDetail?leagueTeamNo=${matchDto.leagueMatchHome}">
							<img src="${pageContext.request.contextPath}/league/leagueTeamImage?leagueTeamNo=${matchDto.leagueMatchHome}" class="rounded w-100 m-2">
						</a>
					</div>
					<div class="col">
						<div class="row m-2"><div class="col">
							<c:choose>
								<c:when test="${matchDto.parsedLeagueMatchDate==null}">
									아직 경기 일정이 없습니다
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${matchDto.parsedLeagueMatchDate}" pattern="yyyy-MM-dd"/>
								</c:otherwise>
							</c:choose>
						</div></div>
						<div class="row m-2"><div class="col">
							${matchDto.leagueMatchLocation}
						</div></div>
						<div class="row m-2"><div class="col">
							<c:choose>
								<c:when test="${matchDto.leagueMatchHomeScore == null && matchDto.leagueMatchAwayScore == null}">
									<h2><fmt:formatDate value="${matchDto.parsedLeagueMatchDate}" pattern="hh:mm"/>(경기전)</h2>									
								</c:when>
								<c:otherwise>
									<h2>${matchDto.leagueMatchHomeScore} : ${matchDto.leagueMatchAwayScore}</h2>
								</c:otherwise>
							</c:choose>
						</div></div>
					</div>
					<div class="col-2">
						<a href="league/leagueTeamDetail?leagueTeamNo=${matchDto.leagueMatchAway}">
							<img src="${pageContext.request.contextPath}/league/leagueTeamImage?leagueTeamNo=${matchDto.leagueMatchAway}" class="rounded w-100 m-2">
						</a>
					</div>
					<div class="row"><div class="col">
						<h5>${matchDto.homeTeamName} vs ${matchDto.awayTeamName}</h5>
					</div></div>
					<div class="row"><div class="col">
						<button class="btn btn-info me-1 edit-btn" data-league-match-no="${matchDto.leagueMatchNo}">경기수정</button>
						<button class="btn btn-info ms-1 result-btn" data-league-match-no="${matchDto.leagueMatchNo}">결과등록</button>
					</div></div>
				</div>
			</div></div>
		</c:forEach>



	</div></div>
</div>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%> 