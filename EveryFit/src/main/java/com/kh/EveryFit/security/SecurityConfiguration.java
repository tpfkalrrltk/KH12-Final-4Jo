package com.kh.EveryFit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@SuppressWarnings("deprecation")
@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	CustomSessionExpiredStrategy customSessionExpiredStrategy;
	
	@Override
protected void configure(HttpSecurity http) throws Exception {

			// ...

			http.sessionManagement()
			        .sessionFixation().changeSessionId()
			        .maximumSessions(1)
			        .expiredSessionStrategy(customSessionExpiredStrategy)
			        .maxSessionsPreventsLogin(false)
			        .sessionRegistry(sessionRegistry())
			        .expiredUrl("/login?expired");
			http.csrf().disable();
	}

	// ...

	@Bean
	public SessionRegistry sessionRegistry() {
	    return new SessionRegistryImpl();
	}
	
	@Bean
	public static ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
	    return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
	}
}