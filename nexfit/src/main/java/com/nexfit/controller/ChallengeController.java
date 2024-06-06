package com.nexfit.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.ChallengeBoardDAO;
import com.nexfit.dao.ChallengeDAO;
import com.nexfit.domain.ChallengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChallengeController {

	@RequestMapping("/challenge/list")
	public ModelAndView challengelist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 리스트
				ModelAndView mav = new ModelAndView("challenge/list");
				ChallengeBoardDAO dao1= new ChallengeBoardDAO();
				ChallengeDAO dao = new ChallengeDAO();
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
					
					List<ChallengeDTO> list = null;
					if (kwd.length() == 0) {
						list = dao.listChallenge(offset, size);
					} else {
						list = dao.listBoard(offset, size, schType, kwd);
					}

					String query = "";
					if (kwd.length() != 0) {
						query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
					}

					// 페이징 처리
					String cp = req.getContextPath();
					String listUrl = cp + "/challenge/list";
					String articleUrl = cp + "/challenge/article?page=" + current_page;
					
					if (query.length() != 0) {
						listUrl += "?" + query;
						articleUrl += "&" + query;
					}
					String paging = util.paging(current_page, total_page, listUrl);
					int procount =dao1.inprogressCountlist();
					int endcount= dao1.endprogressCountlist();
					// 포워딩할 JSP에 전달할 속성
					mav.addObject("end", endcount);
					mav.addObject("procount", procount);
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
	
	
	@RequestMapping(value ="/challenge/write", method = RequestMethod.GET)
	public ModelAndView newchallenge(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//챌린지 추가 폼
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
			
		}
		
		ModelAndView mav = new ModelAndView("/challenge/write");
		mav.addObject("mode", "write");
		return mav;
	}
	
	@RequestMapping(value = "/challenge/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글등록
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/notice/list");
		}
		
		ChallengeDAO dao = new ChallengeDAO();
		
		try {
			ChallengeDTO dto = new ChallengeDTO();
			
			dto.setCh_subject(req.getParameter("subject"));
			dto.setCh_content(req.getParameter("content"));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			
			dao.insertChallenge(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/challenge/list");
	}
	
	//챌린지 자세히보기
		@RequestMapping(value ="/challenge/article", method = RequestMethod.GET)
		public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
			ChallengeBoardDAO dao1= new ChallengeBoardDAO();
			ChallengeDAO dao = new ChallengeDAO();
			MyUtil util = new MyUtilBootstrap();
			
			String page = req.getParameter("page");
			String size = req.getParameter("size");
			String query = "page=" + page + "&size=" + size;
			
			try {
				long id = Long.parseLong(req.getParameter("challengeId"));
				
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
		
				
				ChallengeDTO dto = dao.findById(id);
				
				if(dto == null) {
					return new ModelAndView("redirect:/challenge/list?"+query);
				}
				
				dto.setCh_content(util.htmlSymbols(dto.getCh_content()));
				
				int endcount= dao1.endprogressCountlist();
				
				int procount =dao1.inprogressCountlist();
				ModelAndView mav = new ModelAndView("challenge/article");
				mav.addObject("end", endcount);
				mav.addObject("procount", procount);
				mav.addObject("dto", dto);
				mav.addObject("page", page);
				mav.addObject("query", query);
				mav.addObject("size", size);
				
				return mav;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return new ModelAndView("redirect:/challenge/list?" + query);
		}
	
	@RequestMapping(value = "/challenge/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		// 넘어온 파라미터 : 글번호, 페이지번호, size
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
		}
		
		ChallengeDAO dao = new ChallengeDAO();
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		try {
			long id = Long.parseLong(req.getParameter("challengeId"));
			
			ChallengeDTO dto = dao.findById(id);
			if(dto == null) {
				return new ModelAndView("redirect:/challenge/list?page="+page+"&size="+size);
			}
			ModelAndView mav = new ModelAndView("challenge/write");
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("size", size);
			
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/challenge/list?page="+page+"&size="+size);
	}
	
	@RequestMapping(value = "/challenge/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
		}
		
	
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		ChallengeDAO dao = new ChallengeDAO();
		
		try {
			ChallengeDTO dto = new ChallengeDTO();
			
			dto.setChallengeId(Long.parseLong(req.getParameter("challengeId")));
			dto.setCh_subject(req.getParameter("subject"));
			dto.setCh_content(req.getParameter("content"));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			
			
			dao.updateChallenge(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/challenge/list?page="+page+"&size="+size);
	}
	
	@RequestMapping(value = "/challenge/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		ChallengeDAO dao = new ChallengeDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long id = Long.parseLong(req.getParameter("challengeId"));
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

			dao.deleteChallenge(id, info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/challenge/list?" + query);
	}
	
	@RequestMapping(value = "/challenge/deletelist", method = RequestMethod.POST)
	public ModelAndView deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 선택 파일 삭제
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
		}
		
		
		String page =req.getParameter("page");
		if(page ==null) page = "1";
		String query = "page=" + page;
		
		ChallengeDAO dao = new ChallengeDAO();
		
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
			dao.deleteChallenge(nums);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/challenge/list?"+query);
	}
	
}