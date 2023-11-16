//package com.kh.EveryFit.restcontroller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.PutMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.kh.EveryFit.dao.LeagueDao;
//import com.kh.EveryFit.dto.LeagueDto;
//import com.kh.EveryFit.dto.LeagueListDto;
//import com.kh.EveryFit.vo.LeagueListVO;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@RestController
//@CrossOrigin
//@RequestMapping("/league")
//public class LeagueRestController {
//
//	@Autowired
//	private LeagueDao leagueDao;
//	
//	@GetMapping("/")
//	public List<LeagueListDto>listAll(){
//		return leagueDao.selectLeagueList();
//	}
//	
//	@PostMapping("/leagueList/")
//	public List<LeagueListDto> list(@RequestBody(required = false) LeagueListVO vo){
//		return leagueDao.selectLeagueListSearch(vo);
//	}
//	
//	@GetMapping("/{leagueNo}")
//	public LeagueDto selectOne(@PathVariable int leagueNo) {
//		return leagueDao.selectOneLeague(leagueNo);
//	}
//	
//	@PostMapping("/")
//	public void insert(@RequestBody LeagueDto leagueDto) {
//		leagueDto.setLeagueNo(leagueDao.leagueSequence());
//		leagueDao.insertLeague(leagueDto);
//	}
//	
//	@PutMapping("/{leagueNo}")
//	public void update(@RequestBody LeagueDto leagueDto, @PathVariable int leagueNo) {
//		leagueDao.updateLeague(leagueNo, leagueDto);
//	}
//	
//	@DeleteMapping("/{leagueNo}")
//	public void delete(@PathVariable int leagueNo) {
//		leagueDao.deleteLeague(leagueNo);
//	}
//		
//	
//}
