package com.nexfit.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.CertifiedBoardDAO;
import com.nexfit.dao.Ch_applFormDAO;
import com.nexfit.dao.ChallengeBoardDAO;
import com.nexfit.dao.MyChallengeDAO;
import com.nexfit.domain.CertifiedBoardDTO;
import com.nexfit.domain.Ch_applFormDTO;
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
public class CertifiedBoardController {
		
	
	@RequestMapping("/certiboard/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("certifiedboard/list");
		
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		ChallengeBoardDAO dao1 = new ChallengeBoardDAO();
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
			
			List<CertifiedBoardDTO> list = dao.listCertified(offset, size);
			
			// 페이징
			String cp = req.getContextPath();
			String listUrl = cp + "/certiboard/list";
			String articleUrl = cp + "/certiboard/article?page=" + current_page;
			String paging = util.paging(current_page, total_page, listUrl);
			int procount =dao1.inprogressCountlist();
			int endcount = dao1.endprogressCountlist();
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
	
	@RequestMapping(value = "/certiboard/write", method = RequestMethod.GET)
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Ch_applFormDAO dao=new Ch_applFormDAO();
		
		
		try {
			List<Ch_applFormDTO> list = dao.findApplFormByuserId(info.getUserId());
			if(list!=null) {
			ModelAndView mav = new ModelAndView("certifiedboard/write");
			
			mav.addObject("list", list);
			mav.addObject("mode", "write");
			return mav;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		String message = URLEncoder.encode("참가한 챌린지가 없습니다.", StandardCharsets.UTF_8.toString());
		 String redirectUrl = "/certiboard/list?message="+message;
		 
		 return new ModelAndView("redirect:" + redirectUrl);
		
	}
	
	@RequestMapping(value = "/certiboard/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		
		HttpSession session = req.getSession();
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		try {
			CertifiedBoardDTO dto = new CertifiedBoardDTO();
			
			dto.setApplNumber(Long.parseLong(req.getParameter("applnum")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			String filename = null;
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if(multipart != null) {
				filename = multipart.getSaveFilename();
			}
			
			if(filename != null) {
				dto.setImageFilename(filename);
				
				dao.insertPhoto(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/certiboard/list");
	}
	
	@RequestMapping(value = "/certiboard/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			CertifiedBoardDTO dto = dao.findById(num);
			
			if(dto == null) {
				return new ModelAndView("redirect:/certiboard/list?page=" + page);
			}
			int isAcceptance = dao.isAcceptance(num);
			ModelAndView mav = new ModelAndView("certifiedboard/article");
			
			
			mav.addObject("isAcceptance", isAcceptance);
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/certiboard/list?page=" + page);
	}
	
	@RequestMapping(value = "/certiboard/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		String page = req.getParameter("page");
		Ch_applFormDAO dao1=new Ch_applFormDAO();
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			long num = Long.parseLong(req.getParameter("num"));
			
			CertifiedBoardDTO dto = dao.findById(num);
			List<Ch_applFormDTO> list = dao1.findApplFormByuserId(info.getUserId());
			if(dto == null || ! dto.getUserId().equals(info.getUserId())) {
				return new ModelAndView("redirect:/certified/list?page=" + page);
			}
			
			ModelAndView mav = new ModelAndView("certifiedboard/write");
			
			mav.addObject("list", list);
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/certiboard/list?page=" + page);
	}
	
	@RequestMapping(value = "/certiboard/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		
		HttpSession session = req.getSession();
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		String page = req.getParameter("page");
		
		try {
			CertifiedBoardDTO dto = new CertifiedBoardDTO();
			
			dto.setCertifiedNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			String imageFilename = req.getParameter("imageFilename");
			dto.setImageFilename(imageFilename);
			
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			
			if(multipart != null) {
				String filename = multipart.getSaveFilename();
				dto.setImageFilename(filename);
				
				fileManager.doFiledelete(pathname, imageFilename);
			}
			
			dao.updatePhoto(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/certiboard/list?page="+page);
	}
	
	@RequestMapping(value = "/certiboard/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";

		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));

			CertifiedBoardDTO dto = dao.findById(num);
			if (dto == null) {
				return new ModelAndView("redirect:/certiboard/list?page=" + page);
			}

			if (!dto.getUserId().equals(info.getUserId()) && 
					!info.getUserId().equals("admin")) {
				return new ModelAndView("redirect:/certiboard/list?page=" + page);
			}

			fileManager.doFiledelete(pathname, dto.getImageFilename());

			dao.deletePhoto(num);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/certiboard/list?page=" + page);
	}
	
	@ResponseBody
	@RequestMapping(value = "/certiboard/insertacceptance", method = RequestMethod.POST)
	public Map<String, Object> insertLectureLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		CertifiedBoardDAO dao = new CertifiedBoardDAO();
		MyChallengeDAO dao1 = new MyChallengeDAO();
		
		String state = "false";
		int acceptance = 0;

		try {
			long num = Long.parseLong(req.getParameter("num"));
			long applnum= Long.parseLong(req.getParameter("applnum"));
			String isNoAcceptance = req.getParameter("isNoAcceptance");
			
			if(isNoAcceptance.equals("true")) {
				dao.updateAcceptance(num); 
			} else {
				dao.deleteAcceptance(num); 
			}
			
			acceptance= dao.isAcceptance(num);
			int count =dao1.countAcceptance(applnum);
			dao1.updateApplscore(count, applnum);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("state", state);
		model.put("acceptance", acceptance);

		return model;
	}
}
