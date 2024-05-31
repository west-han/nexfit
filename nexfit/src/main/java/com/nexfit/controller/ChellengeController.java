package com.nexfit.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.ChellengeDAO;
import com.nexfit.domain.ChellengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChellengeController {

	@RequestMapping("/chellenge/list")
	public ModelAndView chellengelist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 리스트
				ModelAndView mav = new ModelAndView("chellenge/list");

				ChellengeDAO dao = new ChellengeDAO();
				MyUtil util = new MyUtilBootstrap();
				
				try {
					String page = req.getParameter("page");
					int current_page = 1;
					if (page != null) {
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
					
					// 전체 페이지 수
					int size = 10;
					int total_page = util.pageCount(dataCount, size);
					if (current_page > total_page) {
						current_page = total_page;
					}

					// 게시물 가져오기
					int offset = (current_page - 1) * size;
					if(offset < 0) offset = 0;
					
					List<ChellengeDTO> list = null;
					if (kwd.length() == 0) {
						list = dao.listChellenge(offset, size);
					} else {
						list = dao.listBoard(offset, size, schType, kwd);
					}

					String query = "";
					if (kwd.length() != 0) {
						query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
					}

					// 페이징 처리
					String cp = req.getContextPath();
					String listUrl = cp + "/chellenge/list" +query;
					String articleUrl = cp + "/chellenge/article?page=" + current_page + "&" + query;
					

					String paging = util.paging(current_page, total_page, listUrl);

					// 포워딩할 JSP에 전달할 속성
					mav.addObject("list", list);
					mav.addObject("page", current_page);
					mav.addObject("total_page", total_page);
					mav.addObject("dataCount", dataCount);
					mav.addObject("size", size);
					mav.addObject("articleUrl", articleUrl);
					mav.addObject("paging", paging);
					mav.addObject("schType", schType);
					mav.addObject("kwd", kwd);
					
				} catch (Exception e) {
					e.printStackTrace();
				}

				// JSP로 포워딩
				return mav;
	}
	
	
	@RequestMapping(value ="/chellenge/write", method = RequestMethod.GET)
	public ModelAndView newchellenge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//챌린지 추가 폼
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/chellenge/list");
			
		}
		
		ModelAndView mav = new ModelAndView("/chellenge/write");
		mav.addObject("mode", "write");
		return mav;
	}
	
	@RequestMapping(value = "/chellenge/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글등록
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/notice/list");
		}
		
		ChellengeDAO dao = new ChellengeDAO();
		
		try {
			ChellengeDTO dto = new ChellengeDTO();
			
			dto.setCh_subject(req.getParameter("subject"));
			dto.setCh_content(req.getParameter("content"));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			
			dao.insertChellenge(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/chellenge/list");
	}
	
	//챌린지 자세히보기
		@RequestMapping(value ="/chellenge/article", method = RequestMethod.GET)
		public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
			ChellengeDAO dao = new ChellengeDAO();
			MyUtil util = new MyUtilBootstrap();
			
			String page = req.getParameter("page");
			String size = req.getParameter("size");
			String query = "page=" + page + "&size=" + size;
			
			try {
				long id = Long.parseLong(req.getParameter("chellengeId"));
				
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
		
				
				ChellengeDTO dto = dao.findById(id);
				
				if(dto == null) {
					return new ModelAndView("redirect:/chellenge/list?"+query);
				}
				
				dto.setCh_content(util.htmlSymbols(dto.getCh_content()));

				
				ModelAndView mav = new ModelAndView("chellenge/article");
				
				mav.addObject("dto", dto);
				mav.addObject("page", page);
				mav.addObject("query", query);
				mav.addObject("size", size);
				
				return mav;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return new ModelAndView("redirect:/chellenge/list?" + query);
		}
	
	@RequestMapping(value = "/chellenge/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		// 넘어온 파라미터 : 글번호, 페이지번호, size
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/notice/list");
		}
		
		ChellengeDAO dao = new ChellengeDAO();
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		try {
			long id = Long.parseLong(req.getParameter("chellengeId"));
			
			ChellengeDTO dto = dao.findById(id);
			if(dto == null) {
				return new ModelAndView("redirect:/chellenge/list?page="+page+"&size="+size);
			}
			ModelAndView mav = new ModelAndView("chellenge/write");
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("size", size);
			
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/chellenge/list?page="+page+"&size="+size);
	}
	
	@RequestMapping(value = "/chellenge/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/chellenge/list");
		}
		
	
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		ChellengeDAO dao = new ChellengeDAO();
		
		try {
			ChellengeDTO dto = new ChellengeDTO();
			
			dto.setChellengeId(Long.parseLong(req.getParameter("chellengeId")));
			dto.setCh_subject(req.getParameter("subject"));
			dto.setCh_content(req.getParameter("content"));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			
			
			dao.updateChellenge(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chellenge/list?page="+page+"&size="+size);
	}
	
	@RequestMapping(value = "/chellenge/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		ChellengeDAO dao = new ChellengeDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long id = Long.parseLong(req.getParameter("chellengeId"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = URLDecoder.decode(kwd, "utf-8");

			if (kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}

			dao.deleteChellenge(id, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/chellenge/list?" + query);
	}
	
	@RequestMapping(value = "/chellenge/deletelist", method = RequestMethod.POST)
	public ModelAndView deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 선택 파일 삭제
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/chellenge/list");
		}
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
		
		ChellengeDAO dao = new ChellengeDAO();
		
		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd="
						+ URLEncoder.encode(kwd, "utf-8");
			}
			
			String []snums = req.getParameterValues("nums");
			long []nums = new long[snums.length];
			for(int i=0; i<snums.length; i++) {
				nums[i] = Long.parseLong(snums[i]);
			}
			
			
			// 게시글 지우기
			dao.deleteChellenge(nums);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/chellenge/list");
	}
	
}
	

