package com.kh.EveryFit.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//import com.kh.EveryFit.interceptor.AdminOwnerInterceptor;
import com.kh.EveryFit.interceptor.MemberBlockInterceptor;
import com.kh.EveryFit.interceptor.MemberInterceptor;
import com.kh.EveryFit.interceptor.MoimMemberInterceptor;
import com.kh.EveryFit.interceptor.WebSocketServerInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
@Autowired
MemberInterceptor memberInterceptor;

@Autowired
MemberBlockInterceptor memberBlockInterceptor;

@Autowired
WebSocketServerInterceptor webSocketServerInterceptor;

@Autowired
MoimMemberInterceptor moimMemberInterceptor;

//@Autowired
//AdminOwnerInterceptor adminOwnerInterceptor;


@Override
	public void addInterceptors(InterceptorRegistry registry) {
	registry.addInterceptor(memberInterceptor)
	.order(1)
	.addPathPatterns(	
			"/member/**",
			"/freeBoard/**",
			"/rest/freeBoardReply/**",
			"/rest/moimBoardReply/**",
			"/pay/**",
			"/report/**",
			"/moim/**",
			"/league/leagueTeamInsert",
			"/league/leagueInsert",
			"/league/leagueEdit"
	)
	.excludePathPatterns(
			"/freeBoard/list",
			"/freeBoard/detail**",
			"/member/join*",
			"/member/login",

			"/member/exitFinish",
			"/member/find**",
			"/rest/freeBoardReply/list",
			"/faq/list",
			"/faq/detail**",
			"/member/memberChangePw"

	);
	
	
	registry.addInterceptor(memberBlockInterceptor)
	.order(3)
	.addPathPatterns(
			"/freeBoard/*",
			"/rest/freeBoardReply/**",
			"/rest/moimBoardReply/**",
			"/pay/**",
			"/report/**",	
			"/moim/**"
			//"/league/**",
			
			)
	.excludePathPatterns(
			"/freeBoard/list",
			"/freeBoard/detail**",
			"/rest/freeBoardReply/list",
			"/member/mypage",
			"/member/join*",
			"/member/login",
			"/member/logout",
			"/member/exitFinish",
			"/member/find**",
			"/member/memberChangePw"
);
	
//	registry.addInterceptor(adminOwnerInterceptor)
//	.order(5).addPathPatterns("/admin/**");
	
//	"/league/leagueInsert",
//	"/league/leagueEdit"
	//리그는 이거 관리자 이거 두개만 막으면 돼요
	
	registry.addInterceptor(webSocketServerInterceptor).order(1).addPathPatterns("/default/**");
	registry.addInterceptor(moimMemberInterceptor).order(1).addPathPatterns("/moim/detail/**");
}
}


