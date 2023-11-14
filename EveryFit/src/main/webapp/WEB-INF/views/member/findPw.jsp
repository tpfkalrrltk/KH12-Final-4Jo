<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
    <jsp:include page="../template/Header.jsp"></jsp:include>
    
    <h3>비밀번호 찾기</h3>
    
    <form action="findPw" method="post">
    	<div class="container-fluid">
    	<div class="row">
    	<div class="col-md-4 offset-md-4">
    	<div class="d-flex flex-row mb-3">
    	이메일<input type="text" name="memberEmail" class="form-control" required>
    	<button type="submit" class="btn btn-Danger ms-2">비밀번호 찾기</button>
    	</div>
    	</div>
    	</div>
    	</div>
    </form>
    
    <jsp:include page="../template/Footer.jsp"></jsp:include>