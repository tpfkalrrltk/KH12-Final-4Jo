package com.kh.EveryFit.service;

import java.io.IOException;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public interface EmailService {
	
	
	
	void sendCelebration(String email) throws MessagingException, IOException;
	
}
