//package com.kh.EveryFit.interceptor;
//
//import javax.security.sasl.AuthenticationException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import com.kh.EveryFit.dao.AdminDao;
//
//
//
//
//@Component
//public class AdminOwnerInterceptor implements HandlerInterceptor {
//@Autowired 
//AdminDao adminDao;
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		
//		HttpSession session = request.getSession();
//		String memberLevel =(String) session.getAttribute("level");
//
//	
//		boolean isAdmin =memberLevel !=null && memberLevel.equals("관리자");
//		
//		if(isAdmin) { 
//			return true;
//		}
//		else { 
//				throw new AuthenticationException("관리자가 아닙니다. 돌아가 주세요."); 
//		}
//	
//	}
//}
