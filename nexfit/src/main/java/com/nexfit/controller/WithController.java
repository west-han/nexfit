package com.nexfit.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.MemberDAO;
import com.nexfit.dao.PointDAO;
import com.nexfit.dao.WithBoardDAO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.Point;
import com.nexfit.domain.ReplyDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.domain.WithBoardDTO;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class WithController {
	@RequestMapping(value = "/withme/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("withme/list");

	    WithBoardDAO dao = new WithBoardDAO();
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
	        if (offset < 0) offset = 0;

	        List<WithBoardDTO> list = null; 
	        if (kwd.length() == 0) {
	            list = dao.listBoard(offset, size);
	        } else {
	            list = dao.listBoard(offset, size, schType, kwd);
	        }

	        String query = "";
	        if (kwd.length() != 0) {
	            query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
	        }

	        // 페이징 처리
	        String cp = req.getContextPath();
	        String listUrl = cp + "/withme/list";
	        String articleUrl = cp + "/withme/article?page=" + current_page;
	        if (query.length() != 0) {
	            listUrl += "?" + query;
	            articleUrl += "&" + query;
	        }

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

	    return mav;
	}
	
	
	@RequestMapping(value = "/withme/write", method = RequestMethod.GET)
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 폼
		ModelAndView mav = new ModelAndView("withme/write");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		MemberDAO dao = new MemberDAO();
		
		try {
			Properties prop = new Properties();
			prop.load(req.getServletContext().getResourceAsStream("/WEB-INF/kakao-API-KEY.properties"));
			mav.addObject("apiKey", prop.get("kakao-javaScript-key"));
			
			MemberDTO memberDTO = dao.findById(info.getUserId());
			String address = memberDTO.getAddr1();
			mav.addObject("address", address);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("mode", "write");
		return mav;
	}
	
	@RequestMapping(value = "/withme/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 저장
		WithBoardDAO dao = new WithBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			WithBoardDTO dto = new WithBoardDTO();

			// userId는 세션에 저장된 정보
			dto.setUserId(info.getUserId());

			// 파라미터
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setX(Double.parseDouble(req.getParameter("coordinate-x")));
			dto.setY(Double.parseDouble(req.getParameter("coordinate-y")));

			dao.insertBoard(dto);
			
			PointDAO pointDao = new PointDAO();
			pointDao.updatePoint(info.getUserId(), Point.WRITE_POST);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/withme/list");
	}
	
	
	@RequestMapping(value = "/withme/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 보기
		// 파라미터: 글번호, [페이지 번호, 검색할 컬럼, 검색어]
		
		Properties prop = new Properties();
		prop.load(req.getServletContext().getResourceAsStream("/WEB-INF/kakao-API-KEY.properties"));
		
		WithBoardDAO dao = new WithBoardDAO();
		// MyUtil util = new MyUtilBootstrap();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long num = Long.parseLong(req.getParameter("num"));
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

			// 조회수 증가
			dao.updateHitCount(num);

			// 게시물 가져오기
			WithBoardDTO dto = dao.findById(num);
			if (dto == null) { // 게시물이 없으면 다시 리스트로
				return new ModelAndView("redirect:/withme/list?" + query);
			}

			// 이전글 다음글
			WithBoardDTO prevDto = dao.findByPrev(dto.getNum(), schType, kwd);
			WithBoardDTO nextDto = dao.findByNext(dto.getNum(), schType, kwd);

			ModelAndView mav = new ModelAndView("withme/article");
			
			// JSP로 전달할 속성
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			mav.addObject("apiKey", prop.get("kakao-javaScript-key"));
			
			// 포워딩
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/withme/list?" + query);
	}
	
	
	@RequestMapping(value = "/withme/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 수정 폼
		// 파라미터: 글 번호 [, 페이지 번호, 세션:사용자정보]
		WithBoardDAO dao = new WithBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");

		try {
			Properties prop = new Properties();
			prop.load(req.getServletContext().getResourceAsStream("/WEB-INF/kakao-API-KEY.properties"));
			
			long num = Long.parseLong(req.getParameter("num"));
			WithBoardDTO dto = dao.findById(num);

			if (dto == null) {
				return new ModelAndView("redirect:/withme/list?page=" + page);
			}

			// 게시물을 올린 사용자가 아니면
			if (! dto.getUserId().equals(info.getUserId())) {
				return new ModelAndView("redirect:/withme/list?page=" + page);
			}

			ModelAndView mav = new ModelAndView("withme/write");
			
			mav.addObject("apiKey", prop.get("kakao-javaScript-key"));
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/withme/list?page=" + page);
	}
	
	@RequestMapping(value = "/withme/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 수정 완료
		WithBoardDAO dao = new WithBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			WithBoardDTO dto = new WithBoardDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setX(Double.parseDouble(req.getParameter("coordinate-x")));
			dto.setY(Double.parseDouble(req.getParameter("coordinate-y")));

			dto.setUserId(info.getUserId());

			dao.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/withme/list?page=" + page);
	}
	
	@RequestMapping(value = "/withme/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 삭제
		// 파라미터: 글 번호, 페이지 번호 [, 검색할 컬럼, 검색어]
		WithBoardDAO dao = new WithBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long num = Long.parseLong(req.getParameter("num"));
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

			String userId = info.getUserId();
			if (userId.equals("admin")) {
				WithBoardDTO dto = dao.findById(num);
				userId = dto.getUserId();
			}

			dao.deleteAllReplies(num);
			dao.deleteBoard(num, userId);
			
			PointDAO pointDao = new PointDAO();
			pointDao.updatePoint(userId, Point.DELETE_POST);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/withme/list?" + query);
	}

	@ResponseBody
	@RequestMapping(value = "/withme/insertReply", method = RequestMethod.POST)
	public Map<String, Object> insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어올 파라미터: 게시글 번호, 댓글 내용 [, 상위 댓글 번호]
		
		Map<String, Object> model = new HashMap<String, Object>();
		WithBoardDAO dao = new WithBoardDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member"); 
		String userId = info.getUserId();
		
		String state = "false";
		
		try {
			ReplyDTO dto = new ReplyDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setUserId(userId);
			dto.setContent(req.getParameter("content"));
			
			String answer = req.getParameter("answer");
			if (answer != null) {
				dto.setAnswer(Long.parseLong(answer));
			}
			
			dao.insertReply(dto);
			state = "true";
			PointDAO pointDAO = new PointDAO();
			pointDAO.updatePoint(userId, Point.WRITE_COMMENT);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value = "/withme/listReply", method = RequestMethod.GET)
	public ModelAndView listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		WithBoardDAO dao = new WithBoardDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String page = req.getParameter("page");
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}
			int size = 10;
			int totalPage = 0;
			int dataCount = 0;
			
			dataCount = dao.dataCountReply(num);
			totalPage = util.pageCount(dataCount, size);
			if (totalPage < currentPage) {
				currentPage = totalPage;
			}
			
			int offset = (currentPage - 1) * size;
			offset = offset < 0 ? 0 : offset;
			
			List<ReplyDTO> list = dao.listReply(num, offset, size);
			
			for (ReplyDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll(" ", "&nbsp;"));
				dto.setContent(dto.getContent().replaceAll("\n", "<br>;"));
			}
			
			String paging = util.pagingMethod(currentPage, offset, "listPage");
			
			ModelAndView mav = new ModelAndView("withme/listReply");
			
			mav.addObject("list", list);
			mav.addObject("pageNo", currentPage);
			mav.addObject("replyCount", dataCount);
			mav.addObject("totalPage", totalPage);
			mav.addObject("paging", paging);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(400);
			
			throw e;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/withme/deleteReply", method = RequestMethod.GET)
	public Map<String, Object> deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		WithBoardDAO dao = new WithBoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "false";
		String userId;
		
		try {
			long replyNum = Long.parseLong(req.getParameter("replyNum"));
			
			userId = info.getUserId();
			
			if (userId.equals("admin")) {
				ReplyDTO dto = dao.readReply(replyNum);
				userId = dto.getUserId();
			}
			
			PointDAO pointDAO = new PointDAO();
			pointDAO.updatePoint(userId, Point.DELETE_COMMENT);
			dao.deleteReply(replyNum, state);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.put("state", state);
		
		return model;
	}
	
	// 리플의 답글 리스트 - AJAX:TEXT
	@RequestMapping(value = "/lecture/listReplyAnswer", method = RequestMethod.GET)
	public ModelAndView listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		WithBoardDAO dao = new WithBoardDAO();

		try {
			long answer = Long.parseLong(req.getParameter("answer"));

			List<ReplyDTO> listReplyAnswer = dao.listReplyAnswer(answer);

			// 엔터를 <br>(스타일 => style="white-space:pre;")
			for (ReplyDTO dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			ModelAndView mav = new ModelAndView("withme/listReplyAnswer");
			mav.addObject("listReplyAnswer", listReplyAnswer);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(400);
			throw e;
		}
	}

	// 리플의 답글 개수 - AJAX:JSON
	@ResponseBody
	@RequestMapping(value = "/withme/countReplyAnswer", method = RequestMethod.POST)
	public Map<String, Object> countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		WithBoardDAO dao = new WithBoardDAO();
		int count = 0;

		try {
			long answer = Long.parseLong(req.getParameter("answer"));
			count = dao.dataCountReplyAnswer(answer);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count", count);

		return model;
	}
}