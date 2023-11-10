package com.kh.EveryFit.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "custom.periodkakaopay")
public class PeriodKakaoPayProperties {
	private String cid, key;
}
