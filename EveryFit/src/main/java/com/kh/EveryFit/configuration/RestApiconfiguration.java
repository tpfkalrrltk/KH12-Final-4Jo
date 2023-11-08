package com.kh.EveryFit.configuration;

import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;

@OpenAPIDefinition(
				info = @Info(
						title = "테스트용 REST API 서비스",
						description = "every fit",
						version = "V1",
						contact = @Contact(
								
								)
						)
					)

@Configuration
public class RestApiconfiguration {

}
