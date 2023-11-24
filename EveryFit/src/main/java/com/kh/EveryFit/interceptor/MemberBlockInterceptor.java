//package com.kh.EveryFit.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import com.kh.EveryFit.dao.MemberDao;
//import com.kh.EveryFit.dto.MemberDto;
//import com.kh.EveryFit.error.AuthorityException;
//
//@Component
//public class MemberBlockInterceptor implements HandlerInterceptor {
//
//	@Autowired
//	MemberDao memberDao;
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		HttpSession session = request.getSession();
//
//		String memberId = (String) session.getAttribute("name");
//		MemberDto memberDto = memberDao.selectOne(memberId);
//		String memberBlock = memberDto.getMemberBlock();
//
//		boolean isBlock = memberBlock== "Y";
//
//		if (isBlock) {
//			return true;
//		} else {
//			throw new AuthorityException("차단당한 회원입니다. 관리자에게 문의 하세요");
//			 //esponse.sendRedirect(request.getContextPath()+"/error/MemberBlockException");
//			// response.sendRedirect(request.getContextPath()+"/member/login");
//			// return false;
//		}
//	}
//}
