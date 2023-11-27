package com.kh.EveryFit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.EveryFit.dao.MoimDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MoimServiceImpl implements MoimService {

	@Autowired MoimDao moimDao;
//	@Scheduled(cron = "0/30 * * * * ?")
	@Override
	public void moimManagement() {
		//그냥 일단 moim_end_time이 오늘날짜(날짜만해당)/업그레이드 N 이면 비활성화
		moimDao.updateMoimStateByScheduler();
		//moim_end_time 이후로 30일이 지나면 ~ 삭제하자!
		moimDao.deleteMoim();
	}
}
