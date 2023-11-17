//package com.kh.EveryFit.service;
//
//import org.springframework.mail.SimpleMailMessage;
//import org.springframework.stereotype.Repository;
//
//import com.kh.EveryFit.dto.MemberDto;
//
//@Repository
//public class MemberServiceImpl {
//	 // 메일 내용을 생성하고 임시 비밀번호로 회원 비밀번호를 변경 
//    @Override
//    public MemberDto createMailAndChangePassword(String memberEmail) {
//        String str = getTempPassword();
//        MemberDto dto = new MailDTO();
//        dto.setAddress(memberEmail);
//        dto.setTitle("Cocolo 임시비밀번호 안내 이메일 입니다.");
//        dto.setMessage("안녕하세요. Cocolo 임시비밀번호 안내 관련 이메일 입니다." + " 회원님의 임시 비밀번호는 "
//                + str + " 입니다." + "로그인 후에 비밀번호를 변경을 해주세요");
//        updatePassword(str,memberEmail);
//        return dto;
//    }
//
//    //임시 비밀번호로 업데이트
//    @Override
//    public void updatePassword(String str, String userEmail){
//        String memberPassword = str;
//        Long memberId = mr.findByMemberEmail(userEmail).getId();
//        mmr.updatePassword(memberId,memberPassword);
//    }
//
//    //랜덤함수로 임시비밀번호 구문 만들기
//    @Override
//    public String getTempPassword(){
//        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
//                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
//
//        String str = "";
//
//        // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
//        int idx = 0;
//        for (int i = 0; i < 10; i++) {
//            idx = (int) (charSet.length * Math.random());
//            str += charSet[idx];
//        }
//        return str;
//    }
//    // 메일보내기
//    @Override
//    public void mailSend(MemberDto memberDto) {
//        System.out.println("전송 완료!");
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setTo(memberDto.getAddress());
//        message.setSubject(memberDto.getTitle());
//        message.setText(memberDto.getMessage());
//        message.setFrom("보낸이@naver.com");
//        message.setReplyTo("보낸이@naver.com");
//        System.out.println("message"+message);
//        mailSender.send(message);
//    }
//
//    //비밀번호 변경
//    @Override
//    public void updatePassWord(Long memberId, String memberPassword) {
//        mmr.updatePassword(memberId,memberPassword);
//    }
//}
