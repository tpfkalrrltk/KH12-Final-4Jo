package com.kh.EveryFit.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.EveryFit.component.DateFormatUtils;
import com.kh.EveryFit.configuration.FileUploadProperties;
import com.kh.EveryFit.dao.AttachDao;
import com.kh.EveryFit.dao.ChatDao;
import com.kh.EveryFit.dao.LeagueDao;
import com.kh.EveryFit.dao.MemberDao;
import com.kh.EveryFit.dao.MoimDao;
import com.kh.EveryFit.dto.AttachDto;
import com.kh.EveryFit.dto.EventDto;
import com.kh.EveryFit.dto.LeagueApplicationDto;
import com.kh.EveryFit.dto.LeagueDto;
import com.kh.EveryFit.dto.LeagueListDto;
import com.kh.EveryFit.dto.LeagueMatchDto;
import com.kh.EveryFit.dto.LeagueTeamDto;
import com.kh.EveryFit.dto.LeagueTeamRoasterDto;
import com.kh.EveryFit.dto.LocationDto;
import com.kh.EveryFit.dto.MoimDto;
import com.kh.EveryFit.vo.LeagueListVO;
import com.kh.EveryFit.vo.LeagueTeamRankListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/league")
public class LeagueController {

	@Autowired private LeagueDao leagueDao;
	@Autowired private MemberDao memberDao;
	@Autowired private MoimDao moimDao;
	@Autowired private AttachDao attachDao;
	@Autowired private ChatDao chatDao;
	
	@RequestMapping("/leagueList")
	public String leagueList(Model model,@ModelAttribute(name="vo") LeagueListVO vo) {
		List<LeagueListDto> list = leagueDao.selectLeagueListSearch(vo);
		List<EventDto> eventList = memberDao.selectEventList();
		List<LocationDto> locationList = memberDao.selectLocationList();
		model.addAttribute("list", list);
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueList";
	}
	
	@GetMapping("/leagueInsert")
	public String leagueInsert(Model model) {
		List<EventDto> eventList = memberDao.selectEventList();
		List<LocationDto> locationList = memberDao.selectLocationList();
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueInsert";
	}
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	//모든 로딩이 끝나면 자동으로 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	@PostMapping("/leagueInsert")
	public String leagueInsert(@ModelAttribute LeagueDto leagueDto, 
								@RequestParam MultipartFile attach, 
								HttpSession session) throws IllegalStateException, IOException {
		//String leagueManager = (String)session.getAttribute("name");
		String leagueManager = "leaguetest1";
		int leagueNo = leagueDao.leagueSequence();
		int chatRoomNo = chatDao.sequence();
		chatDao.insertChatRoom(chatRoomNo);
		
		leagueDto.setLeagueManager(leagueManager);
		leagueDto.setLeagueNo(leagueNo);
		leagueDto.setChatRoomNo(chatRoomNo);
		leagueDao.insertLeague(leagueDto);
		
		chatDao.addChatMember(chatRoomNo, leagueManager);
		if(!attach.isEmpty()) {
			//첨부파일등록(파일이 있을때만)
			int attachNo = attachDao.sequence();

			File target = new File(dir, String.valueOf(attachNo)); //저장할 파일
			attach.transferTo(target);
			
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);

			//연결(파일이 있을때만)
			leagueDao.insertLeagueImage(leagueNo, attachNo);
		}
		
		
		
		return "redirect:leagueGuide?leagueNo="+leagueNo;
	}
	
	@RequestMapping("leagueGuide")
	public String leagueGuide(@RequestParam int leagueNo, Model model) throws ParseException {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		EventDto eventDto = memberDao.selectOneByEventNo(leagueDto.getEventNo());
		LocationDto locationDto = memberDao.selectOneByLocationNo(leagueDto.getLocationNo());
		LeagueApplicationDto applicationDto = leagueDao.selectOneLeagueApplication(leagueNo);
		if(applicationDto!=null) {
			Date applicationStart = DateFormatUtils.parseStringToDate(applicationDto.getLeagueApplicationStart());
			Date applicationEnd = DateFormatUtils.parseStringToDate(applicationDto.getLeagueApplicationEnd());
			model.addAttribute("applicationStart", applicationStart);
			model.addAttribute("applicationEnd", applicationEnd);
		}
		model.addAttribute("locationDto", locationDto);
		model.addAttribute("eventDto", eventDto);
		model.addAttribute("leagueDto",leagueDto);
		return "league/leagueGuide";
	}
	
	@GetMapping("/leagueEdit")
	public String leagueEdit(@RequestParam int leagueNo, Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		EventDto eventDto = memberDao.selectOneByEventNo(leagueDto.getEventNo());
		LocationDto locationDto = memberDao.selectOneByLocationNo(leagueDto.getLocationNo());
		List<LocationDto> locationList = memberDao.selectLocationList();
		List<EventDto> eventList = memberDao.selectEventList();
		model.addAttribute("leagueDto", leagueDto);
		model.addAttribute("eventDto", eventDto);
		model.addAttribute("locationDto", locationDto);
		model.addAttribute("eventList", eventList);
		model.addAttribute("locationList", locationList);
		return "league/leagueEdit";
	}
	
	@PostMapping("/leagueEdit")
	public String leagueEdit(@ModelAttribute LeagueDto leagueDto, @RequestParam int leagueNo) {
		leagueDao.updateLeague(leagueNo, leagueDto);
		return "redirect:leagueGuide?leagueNo="+leagueNo;
	}
	
	@RequestMapping("/leagueDelete")
	public String leagueDelete(@RequestParam int leagueNo) {
		leagueDao.deleteLeague(leagueNo);
		return "redirect:leagueList";
	}
	
	@GetMapping("/leagueTeamInsert")
	public String leagueTeamInsert(@RequestParam int leagueNo, 
									@RequestParam int moimNo,
									Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		model.addAttribute("memberList", moimDao.selectAllMoimMembers(moimNo));
		model.addAttribute("leagueDto", leagueDto);
		return "league/leagueTeamInsert";
	}
	
	@PostMapping("/leagueTeamInsert")
	public String leagueTeamInsert(@RequestParam String[] memberEmail, 
									@RequestParam int leagueNo,
									@RequestParam int moimNo, @RequestParam String leagueTeamName) {
		int leagueTeamNo = leagueDao.leagueTeamSequence();
		leagueDao.insertLeagueTeam(LeagueTeamDto.builder()
									.leagueTeamNo(leagueTeamNo)
									.leagueNo(leagueNo)
									.moimNo(moimNo)
									.leagueTeamName(leagueTeamName)
									.build());
		
		for(String email : memberEmail) {
			leagueDao.insertLeagueTeamRoaster(LeagueTeamRoasterDto.builder()
						.leagueTeamRoasterNo(leagueDao.leagueTeamRoasterSequence())
						.leagueNo(leagueNo)
						.leagueTeamNo(leagueTeamNo)
						.memberEmail(email)
						.build());
		}
		return "redirect:leagueTeamDetail?leagueTeamNo="+leagueTeamNo;
	}
	
	@RequestMapping("/leagueTeamDetail")
	public String leagueTeamDetail(@RequestParam int leagueTeamNo, Model model) {
		LeagueTeamDto leagueTeamDto = leagueDao.selectOneLeagueTeam(leagueTeamNo);
		MoimDto moimDto = moimDao.selectOne(leagueTeamDto.getMoimNo());
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueTeamDto.getLeagueNo());
		model.addAttribute("leagueTeamDto", leagueTeamDto);
		model.addAttribute("moimDto", moimDto);
		model.addAttribute("leagueDto", leagueDto);
		return "/league/leagueTeamDetail";
	}
	
	@RequestMapping("/leagueDetail")
	public String leagueDetail(@RequestParam int leagueNo, Model model) {
		LeagueDto leagueDto = leagueDao.selectOneLeague(leagueNo);
		List<LeagueTeamDto> nonApproveList = leagueDao.listLeagueTeamNonApprove(leagueNo);
		List<LeagueTeamRankListVO> rankList = leagueDao.leagueTeamRank(leagueNo);
		model.addAttribute("nonApproveList", nonApproveList);
		model.addAttribute("rankList", rankList);
		model.addAttribute("leagueDto", leagueDto);
		return "league/leagueDetail";
	}
	
	@RequestMapping("/leagueMatch")
	public String leagueMatch(@RequestParam int leagueNo, Model model) {
		List<LeagueMatchDto> leagueMatchList = leagueDao.selectLeagueMatchList(leagueNo);
		model.addAttribute("leagueMatchList", leagueMatchList);
		return "league/leagueMatch";
	}
	
	@GetMapping("/leagueMatchInsert")
	public String leagueMatchInsert(@RequestParam int leagueNo, Model model) {
		return "league/leagueMatchInsert";
	}
	
	@RequestMapping("/leagueImage")
	public ResponseEntity<ByteArrayResource> 
							download(@RequestParam int leagueNo) throws IOException {
		AttachDto attachDto = attachDao.selectOneleague(leagueNo);
		
		if(attachDto == null) {
			return ResponseEntity.notFound().build(); //404반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment()
					.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
					.build().toString()
				)
				.body(resource);
	}
	
}

