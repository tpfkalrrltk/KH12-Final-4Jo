<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/views/template/Header.jsp"%>
<div class="row"><div class="col-md-8 offset-md-2">

<div class="row"><div class="col">
	<h1>팀이름 : ${moimDto.moimTitle}</h1>
</div></div>

<div class="row"><div class="col">
	<h2>참여중인 리그 : <a href="leagueDetail?leagueNo=${leagueDto.leagueNo}">${leagueDto.leagueTitle}</a></h2>
</div></div>

<div class="row"><div class="col">
	
</div></div>






</div></div>
<%@ include file="/WEB-INF/views/template/Footer.jsp"%> 