<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
		
		<div>
			<h2>join</h2>
		</div>
		
		<form action="join" method="post"> 
		
		<!-- <div>
			no<input type="number" name="memberNo">
		</div> -->
		
		<div>		
			name<input type="text" name="memberName" placeholder="빵빵이">
		</div>
		
		<div>
			email<input type="text" name="memberEmail" placeholder="everyfit@every.fit">
		</div>
		
		<div>
			pw<input type="password" name="memberPw" placeholder="test!">
		</div>
		
		<div>
			nick<input type="text" name="memberNick"> 
		</div>
		
		<div>
			gender<select>
					<option>man</option>
					<option>woman</option>
				</select>
		</div>
		
		<div>
			contact<input type="text" name="memberContact">
		</div>
		
		<div>
			birth<input type="date" name="memberBirth">
		</div>
		
		<button type="submit">join</button>
		
		</form>