package com.kh.EveryFit.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.EveryFit.interceptor.MemberBlockInterceptor;
import com.kh.EveryFit.interceptor.MemberInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
@Autowired
MemberInterceptor memberInterceptor;

//@Autowired
//MemberBlockInterceptor memberBlockInterceptor;


@Override
	public void addInterceptors(InterceptorRegistry registry) {
	registry.addInterceptor(memberInterceptor).addPathPatterns(		
			"/freeBoard/**",
			"/rest/freeBoardReply/**",
			"/rest/moimBoardReply/**",
			"/member/**",
			"/pay/**"
			,"/report/**"
	)
	.excludePathPatterns(
			"/freeBoard/list",
			"/freeBoard/detail**",
			"/member/join*",
			"/member/login",
			"/member/exitFinish",
			"/member/find**",
			"/rest/freeBoardReply/list"

	);
	
	
//	registry.addInterceptor(memberBlockInterceptor)
//	.addPathPatterns(
//			"/freeBoard/**",
//			"/rest/freeBoardReply/**",
//			"/rest/moimBoardReply/**",
//			"/member/**",
//			"/pay/**"
//			,"/report/**")
//	.excludePathPatterns(
//
//			"/member/join*",
//			"/member/login",
//			"/member/exitFinish",
//			"/member/find**"
//);

	
}
}

