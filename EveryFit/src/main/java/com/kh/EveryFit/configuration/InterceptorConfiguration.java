package com.kh.EveryFit.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.EveryFit.interceptor.MemberInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
@Autowired
MemberInterceptor memberInterceptor;


@Override
	public void addInterceptors(InterceptorRegistry registry) {
	registry.addInterceptor(memberInterceptor).addPathPatterns(		"/member/**",
			"/board/**",
			"/rest/reply/**",
			"/member/**",
			"/pay/**"
	)
	.excludePathPatterns(
			"/member/join*",
			"/member/login",
			"/member/exitFinish",
			"/member/find**",
			"/board/list*",
			"/board/detail",
			"/rest/reply/list"

	);
	

}
}

