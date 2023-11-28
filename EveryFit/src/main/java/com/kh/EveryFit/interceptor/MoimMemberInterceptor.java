package com.kh.EveryFit.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.MoimMemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MoimMemberInterceptor implements HandlerInterceptor {

	
	@Autowired private MoimDao moimDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String memberEmail = (String) session.getAttribute("name");
		
		String requestURI = request.getRequestURI();
		String moimNoParam = request.getParameter("moimNo");
		if (moimNoParam != null) {
		    Integer moimNo = Integer.parseInt(moimNoParam);
		    	
		    MoimMemberDto moimMemberDto = moimDao.findMoimMemberInfo(memberEmail, moimNo);
		    if(moimMemberDto != null) {
		    	return true;
		    }
		    response.sendRedirect("/error/AuthorityException");
		    return false;
		}
	    response.sendRedirect("/error/AuthorityException");
		return false;
	}
	
}
