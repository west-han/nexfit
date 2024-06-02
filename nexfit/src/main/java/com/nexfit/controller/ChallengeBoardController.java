package com.nexfit.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.ChallengeBoardDAO;
import com.nexfit.dao.ChallengeDAO;
import com.nexfit.domain.ChallengeBoardDTO;
import com.nexfit.domain.ChallengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.FileManager;
import com.nexfit.util.MyMultipartFile;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class ChallengeBoardController {
	@RequestMapping("/chboard/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("chboard/list");
		
		ChallengeBoardDAO dao= new ChallengeBoardDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 전체 데이터 개수
			int dataCount = dao.dataCount();
			
			// 전체 페이지수
			int size = 12;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<ChallengeBoardDTO> list = dao.listChallengeboard(offset, size);
			
			// 페이징
			String cp = req.getContextPath();
			String listUrl = cp + "/chboard/list";
			String articleUrl = cp + "/chboard/article?page=" + current_page;
			String paging = util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 list에 전달할 속성
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/chboard/write", method = RequestMethod.GET )
	public ModelAndView newChboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ChallengeDAO dao = new ChallengeDAO();
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
			
		}
		
		List<ChallengeDTO> list = dao.listChallenge();
		
		ModelAndView mav = new ModelAndView("chboard/write");
		
		mav.addObject("list", list);
		
		return mav;
	}
	
	@RequestMapping(value = "/chboard/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ChallengeBoardDAO dao = new ChallengeBoardDAO();
		
		HttpSession session = req.getSession();
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		try {
			ChallengeBoardDTO dto = new ChallengeBoardDTO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setChallengeId(Long.parseLong(req.getParameter("challengeId")));
			dto.setCh_subject(req.getParameter("ch_subject"));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			dto.setContent(req.getParameter("content"));
			
			String filename = null;
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if(multipart != null) {
				filename = multipart.getSaveFilename();
			}
			
			if(filename != null) {
				dto.setImageFilename(filename);
				
				dao.insertchBoard(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list");
	}
	
	@RequestMapping(value = "/chboard/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ChallengeBoardDAO dao = new ChallengeBoardDAO();
		String page = req.getParameter("page");
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			long boardnum = Long.parseLong(req.getParameter("boardnum"));
			
			ChallengeBoardDTO dto = dao.findById(boardnum);
			
			if(dto == null ||! info.getUserId().equals("admin")) {
				return new ModelAndView("redirect:/chboard/list?page=" + page);
			}
			
			ModelAndView mav = new ModelAndView("chboard/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list?page=" + page);
	}
	
	@RequestMapping(value = "/chboard/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ChallengeBoardDAO dao = new ChallengeBoardDAO();
		
		HttpSession session = req.getSession();
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		String page = req.getParameter("page");
		
		try {
			ChallengeBoardDTO dto = new ChallengeBoardDTO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setChallengeId(Long.parseLong(req.getParameter("challengeId")));
			dto.setCh_subject(req.getParameter("ch_subject"));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			dto.setContent(req.getParameter("content"));
			
			String imageFilename = req.getParameter("imageFilename");
			dto.setImageFilename(imageFilename);
			
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			
			if(multipart != null) {
				String filename = multipart.getSaveFilename();
				dto.setImageFilename(filename);
				
				// 기존 파일 지우기
				fileManager.doFiledelete(pathname, imageFilename);
			}
			
			dao.updateChboard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list?page="+page);
	}
}
