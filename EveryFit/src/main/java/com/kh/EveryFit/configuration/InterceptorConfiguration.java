package com.kh.EveryFit.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//import com.kh.EveryFit.interceptor.AdminOwnerInterceptor;
import com.kh.EveryFit.interceptor.MemberBlockInterceptor;
import com.kh.EveryFit.interceptor.MemberInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
@Autowired
MemberInterceptor memberInterceptor;

@Autowired
MemberBlockInterceptor memberBlockInterceptor;

//@Autowired
//AdminOwnerInterceptor adminOwnerInterceptor;


@Override
	public void addInterceptors(InterceptorRegistry registry) {
	registry.addInterceptor(memberInterceptor)
	.order(1)
	.addPathPatterns(	
			
			"/freeBoard/**",
			"/rest/freeBoardReply/**",
			"/rest/moimBoardReply/**",
			"/member/**",
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
			"/faq/detail**"

	);
	
	
	registry.addInterceptor(memberBlockInterceptor)
	.order(3)
	.addPathPatterns(
			"/freeBoard/*",
			"/rest/freeBoardReply/**",
			"/rest/moimBoardReply/**",
			"/member/**",
			"/pay/**",
			"/report/**",	
			"/moim/**",
			//"/league/**",
			"/faq/**"
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
			"/member/find**"
);
	
//	registry.addInterceptor(adminOwnerInterceptor)
//	.order(5).addPathPatterns("/admin/**");
	
//	"/league/leagueInsert",
//	"/league/leagueEdit"
	//리그는 이거 관리자 이거 두개만 막으면 돼요
}
}


