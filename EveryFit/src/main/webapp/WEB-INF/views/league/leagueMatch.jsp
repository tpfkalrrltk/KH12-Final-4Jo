<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<div class="row"><div class="col-md-8 offset-md-2">

<div class="row"><div class="col">
	<h1>경기 일정</h1>
</div></div>

<div class="row"><div class="col">
	<button class="btn btn-primary">경기등록</button>
</div></div>

<form method="post" class="leagueMatchForm">
<input type="hidden" name="leagueNo" value="${param.leagueNo}">
<div class="row"><div class="col">
	<label class="form-label">홈팀</label>
	<input class="form-control" name="leagueMatchHome">
</div></div>
<div class="row"><div class="col">
	<label class="form-label">어웨이팀</label>
	<input class="form-control" name="leagueMatchAway">
</div></div>
<div class="row"><div class="col">
	<label class="form-label">경기일정</label>
	<input type="datetime-local" class="form-control" name="leagueMatchDate">
</div></div>
<div class="row"><div class="col">
	<label class="form-label">장소</label>
	<input class="form-control" name="leagueMatchLocation">
</div></div>
<div class="row"><div class="col">
	<button type="submit" class="btn btn-primary">등록</button>
</div></div>
</form>
</div></div>

<script>
$(".leagueMatchForm").style
</script>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%>