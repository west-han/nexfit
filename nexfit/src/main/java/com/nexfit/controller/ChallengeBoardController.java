package com.nexfit.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.Ch_applFormDAO;
import com.nexfit.dao.ChallengeBoardDAO;
import com.nexfit.dao.ChallengeDAO;
import com.nexfit.domain.Ch_applFormDTO;
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
			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}

			// GET 방식인 경우 디코딩
			if (req.getMethod().equalsIgnoreCase("GET")) {
				kwd = URLDecoder.decode(kwd, "utf-8");
			}
			
			// 전체 데이터 개수
			int dataCount;
			if (kwd.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(schType, kwd);
			}
			// 전체 페이지수
			int size = 6;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
						
			List<ChallengeBoardDTO> list = null;
			if (kwd.length() == 0) {
					list = dao.listChallengeboard(offset, size);
			} else {
					list = dao.listChallengeboard(offset, size, schType, kwd);
			}
						
			String query = "";
			if (kwd.length() != 0) {
				query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
			}
			// 페이징
			
			
			String cp = req.getContextPath();
			String listUrl = cp + "/chboard/list";
			String articleUrl = cp + "/chboard/article?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			String paging = util.paging(current_page, total_page, listUrl);
			int procount =dao.inprogressCountlist();
			int endcount = dao.endprogressCountlist();
			// 포워딩할 list에 전달할 속성
			mav.addObject("end", endcount);
			mav.addObject("procount", procount);
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
	public ModelAndView writeChboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ChallengeDAO dao = new ChallengeDAO();
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/chboard/list");
			
		}
		
		List<ChallengeDTO> list = dao.listChallenge();
		
		ModelAndView mav = new ModelAndView("chboard/write");
		
		mav.addObject("list", list);
		mav.addObject("mode", "write");
		
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
			
			long num = Long.parseLong(req.getParameter("num"));
			
			ChallengeDAO dao1 = new ChallengeDAO();
			if(! info.getUserId().equals("admin")) {
				return new ModelAndView("redirect:/chboard/list");
				
			}
			
			
			ChallengeBoardDTO dto = dao.findById(num);
			
			if(dto == null ||! info.getUserId().equals("admin")) {
				return new ModelAndView("redirect:/chboard/list?page=" + page);
			}
			
			List<ChallengeDTO> list = dao1.listChallenge();
			
			ModelAndView mav = new ModelAndView("chboard/write");
			
			mav.addObject("list", list);
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
			dto.setBoardNumber(Long.parseLong(req.getParameter("num")));
			String imageFilename = req.getParameter("imageFilename");
			dto.setImageFilename(imageFilename);
			
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			
			if(multipart != null) {
				String filename = multipart.getSaveFilename();
				dto.setImageFilename(filename);
				
				fileManager.doFiledelete(pathname, imageFilename);
			}
			
			dao.updateChboard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list?page="+page);
	}
	
	
	@RequestMapping(value = "/chboard/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ChallengeBoardDAO dao = new ChallengeBoardDAO();
		Ch_applFormDAO dao1 = new Ch_applFormDAO();
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
			
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			if(kwd.length() != 0) {
				query += "&schType=" + schType
						+ "&kwd=" + URLEncoder.encode(kwd, "utf-8");
			
			}
			
			ChallengeBoardDTO dto = dao.findById(num);
			List<Ch_applFormDTO> app = dao1.findApplFormByNum(num);
			int procount = dao.inprogressCountlist();
			int endcount =dao.endprogressCountlist();
			int countappl = dao1.countappl(num);
			if(dto == null) {
				return new ModelAndView("redirect:/chboard/list?page=" + query);
			}
			
			
			ModelAndView mav = new ModelAndView("chboard/article");
			mav.addObject("countappl", countappl);
			mav.addObject("end", endcount);
			mav.addObject("procount", procount);
			mav.addObject("dto", dto);
			mav.addObject("app", app);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("size", size);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list?" + query);
	}
	
	@RequestMapping(value = "/chboard/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ChallengeBoardDAO dao = new ChallengeBoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";

		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));

			ChallengeBoardDTO dto = dao.findById(num);
			if (dto == null) {
				return new ModelAndView("redirect:/chboard/list?page=" + page);
			}
			
			if (!info.getUserId().equals("admin")) {
				return new ModelAndView("redirect:/chboard/list?page=" + page);
			}

			fileManager.doFiledelete(pathname, dto.getImageFilename());

			// 테이블 데이터 삭제
			dao.deleteChboard(num);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/chboard/list?page="+page);
	}
	
	@RequestMapping(value = "/chboard/applform", method = RequestMethod.GET )
	public ModelAndView applform(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Ch_applFormDAO dao = new Ch_applFormDAO();
		ChallengeBoardDAO dao1= new ChallengeBoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		int count = 0;
		String page = req.getParameter("page");
		long num = Long.parseLong(req.getParameter("num"));
		
		ChallengeBoardDTO dto = dao1.findById(num);
		try {
			count = dao.CountApplForm(Long.parseLong(req.getParameter("num")), info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("chboard/applform");
		
		mav.addObject("dto", dto);
		mav.addObject("page", page);
		mav.addObject("count", count);
		
		return mav;
	}
	
	@RequestMapping(value = "/chboard/applform", method = RequestMethod.POST )
	public ModelAndView applformSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Ch_applFormDAO dao = new Ch_applFormDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			Ch_applFormDTO dto = new Ch_applFormDTO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setBoardNumber(Long.parseLong(req.getParameter("num")));
			dto.setComent(req.getParameter("coment"));
			dto.setUserId(info.getUserId());
			
		   dao.insertApplForm(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chboard/list");
	}
}
