package com.kh.EveryFit.restcontroller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Map;
import java.util.Random;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.EveryFit.dao.CertDao;
import com.kh.EveryFit.dto.CertDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {

   
   
   @Autowired
   private JavaMailSender sender;
   
   @Autowired
   private CertDao certDao;
   
   @PostMapping("/send")
   public void send(@RequestParam String certEmail) throws MessagingException, IOException {
      //인증번호 생성
      Random r = new Random();
      int no = r.nextInt(1000000);
      DecimalFormat fm = new DecimalFormat("000000");
      String certNo = fm.format(no);
      
      //메시지 템플릿
//      MimeMessage message1 = sender.createMimeMessage();
//      MimeMessageHelper helper = new MimeMessageHelper(message1,false,"UTF-8");
//      ClassPathResource resource = new ClassPathResource("templates/email.html");
//      File target = resource.getFile();
//      Scanner sc = new Scanner(target);
//      StringBuffer buffer = new StringBuffer();
//      while(sc.hasNextLine()) {
//    	  buffer.append(sc.nextLine());
//      }
//      sc.close();
      //발송
      SimpleMailMessage message = new SimpleMailMessage();
      message.setTo(certEmail);
      message.setSubject("[Every Fit] 이메일 인증번호를 안내드립니다");
      message.setText("인증번호 확인 후 입력하세요. [ "+certNo+" ]");
      sender.send(message);
   
      certDao.delete(certEmail);
      CertDto certDto = new CertDto();
      certDto.setCertEmail(certEmail);
      certDto.setCertNumber(certNo);
      certDao.insert(certDto);
   }
   
   @PostMapping("/check")
   public String check(@ModelAttribute CertDto certDto){
      //[1]이메일로 인증정보를 조회
            //CertDto findDto = certDao.selectOne(certDto.getCertEmail());//기간제한 없음
            CertDto findDto = certDao.selectOne(certDto.getCertEmail());//5분제한
            if(findDto !=null ) {
               //[2]인증번호 비교
               boolean isValid = findDto.getCertNumber().equals(certDto.getCertNumber());
               if(isValid) {
                  //인증 성공하면 인증번호를 삭제
                  certDao.delete(certDto.getCertEmail());

                  return"Y";

               }
            }
            return "N";
         }
   
}