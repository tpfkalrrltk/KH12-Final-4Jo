package com.kh.EveryFit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
//스케줄러를 사용하고 싶다면 사용하겠다는 설정을 해야 한다
@EnableScheduling
@SpringBootApplication
public class EveryFitApplication {

	public static void main(String[] args) {
		SpringApplication.run(EveryFitApplication.class, args);
	}

}
