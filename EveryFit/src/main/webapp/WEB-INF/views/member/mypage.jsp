<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	
	<h2>mypage</h2>
	
	<table>
		<tr>
		
			<th>email</th>
			<td>${memberDto.memberEmail}</td>
			
			<th>pw</th>
			<td>${memberDto.memberPw}</td>
			
			<th>name</th>
			<td>${memberDto.membername}</td>
			
			<th>nick</th>
			<td>${memberDto.memberNick}</td>
			
			<th>gender</th>
			<td>${memberDto.membeGgender}</td>
			
			<th>contact</th>
			<td>${memberDto.memberContact}</td>
			
			<th>birth</th>
			<td>${memberDto.memberBirth}</td>
		
		</tr>
	</table>