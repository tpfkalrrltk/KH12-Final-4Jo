package com.kh.EveryFit.dao;

import java.util.List;

import com.kh.EveryFit.dto.AppealDto;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.JungmoDto;
import com.kh.EveryFit.dto.MemberDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.dto.ReportDto;
import com.kh.EveryFit.vo.AdminAppealSearchVO;
import com.kh.EveryFit.vo.AdminJungmoSearchVO;
import com.kh.EveryFit.vo.AdminMemberSearchVO;
import com.kh.EveryFit.vo.AdminMoimMemberCountVO;
import com.kh.EveryFit.vo.AdminMoimSearchVO;
import com.kh.EveryFit.vo.AdminReportSearchVO;

public interface AppealDao {

	List<AppealDto>List();

	int sequence();

	List<AppealDto> adminAppealSearch(AdminAppealSearchVO adminAppealSearchVO);

	AppealDto Detail(int appealNo);

	void appealApply(AppealDto reportDto); 

}
