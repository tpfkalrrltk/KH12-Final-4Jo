package com.kh.EveryFit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.error.AuthorityException;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class MemberBlockInterceptor implements HandlerInterceptor {

	@Autowired
	MemberDao memberDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();

		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);

		String memberBlock = "";

		if (memberDto != null) {
			memberBlock = memberDto.getMemberBlock();
		}

		boolean isNotBlock = memberBlock.equals("N") && memberBlock != null;
		if (isNotBlock) {
			log.debug("messageTrue={}", isNotBlock);

			return true;
		} else {
			// throw new AuthorityException("차단당한 회원입니다. 관리자에게 문의 하세요");
			log.debug("messageFalse={}", isNotBlock);
			response.sendRedirect(request.getContextPath() + "/error/MemberBlockException");

		}

		return false;
	}
}

