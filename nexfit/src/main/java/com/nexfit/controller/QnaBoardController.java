package com.nexfit.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.PointDAO;
import com.nexfit.dao.QnaBoardDAO;
import com.nexfit.domain.Point;
import com.nexfit.domain.QnaBoardDTO;
import com.nexfit.domain.ReplyDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaBoardController {
	
	@RequestMapping(value = "/qnaboard/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("qnaboard/list");

	    QnaBoardDAO dao = new QnaBoardDAO();
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

	        List<QnaBoardDTO> list = null; 
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
	        String listUrl = cp + "/qnaboard/list";
	        String articleUrl = cp + "/qnaboard/article?page=" + current_page;
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
	
	
	@RequestMapping(value = "/qnaboard/write", method = RequestMethod.GET)
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 폼
		ModelAndView mav = new ModelAndView("qnaboard/write");
		mav.addObject("mode", "write");
		return mav;
	}
	
	
	@RequestMapping(value = "/qnaboard/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 저장
		QnaBoardDAO dao = new QnaBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			QnaBoardDTO dto = new QnaBoardDTO();

			// userId는 세션에 저장된 정보
			dto.setUserId(info.getUserId());

			// 파라미터
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dao.insertBoard(dto);
			PointDAO pointDao = new PointDAO();
			pointDao.updatePoint(info.getUserId(), Point.WRITE_POST);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/qnaboard/list");
	}
	
	
	@RequestMapping(value = "/qnaboard/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 보기
		// 파라미터: 글번호, [페이지 번호, 검색할 컬럼, 검색어]
		QnaBoardDAO dao = new QnaBoardDAO();
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
			QnaBoardDTO dto = dao.findById(num);
			if (dto == null) { // 게시물이 없으면 다시 리스트로
				return new ModelAndView("redirect:/qnaboard/list?" + query);
			}
			// dto.setContent(util.htmlSymbols(dto.getContent()));

			// 이전글 다음글
			QnaBoardDTO prevDto = dao.findByPrev(dto.getNum(), schType, kwd);
			QnaBoardDTO nextDto = dao.findByNext(dto.getNum(), schType, kwd);


			ModelAndView mav = new ModelAndView("qnaboard/article");
			
			// JSP로 전달할 속성
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			
			// 포워딩
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/qnaboard/list?" + query);
	}
	
	
	@RequestMapping(value = "/qnaboard/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 수정 폼
		// 파라미터: 글 번호 [, 페이지 번호, 세션:사용자정보]
		QnaBoardDAO dao = new QnaBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");

		try {
			long num = Long.parseLong(req.getParameter("num"));
			QnaBoardDTO dto = dao.findById(num);

			if (dto == null) {
				return new ModelAndView("redirect:/qnaboard/list?page=" + page);
			}

			// 게시물을 올린 사용자가 아니면
			if (! dto.getUserId().equals(info.getUserId())) {
				return new ModelAndView("redirect:/qnaboard/list?page=" + page);
			}

			ModelAndView mav = new ModelAndView("qnaboard/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/qnaboard/list?page=" + page);
	}

	@RequestMapping(value = "/qnaboard/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 수정 완료
		QnaBoardDAO dao = new QnaBoardDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			QnaBoardDTO dto = new QnaBoardDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dto.setUserId(info.getUserId());

			dao.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/qnaboard/list?page=" + page);
	}
	
	
	@RequestMapping(value = "/qnaboard/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 삭제
		// 파라미터: 글 번호, 페이지 번호 [, 검색할 컬럼, 검색어]
		QnaBoardDAO dao = new QnaBoardDAO();

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

			dao.deleteBoard(num, info.getUserId());
			PointDAO pointDao = new PointDAO();
			pointDao.updatePoint(info.getUserId(), Point.DELETE_POST);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/qnaboard/list?" + query);
	}
	
	
			// 댓글/답글 저장
			@ResponseBody
			@RequestMapping(value = "/qnaboard/insertReply", method = RequestMethod.POST)
			public Map<String, Object> insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				Map<String, Object> model = new HashMap<String, Object>();
				// 넘어온 파라미터 : 게시글 번호, 댓글 내용, 부모번호(답글인 경우)
				HttpSession session = req.getSession();
				SessionInfo info = (SessionInfo)session.getAttribute("member");
				
				QnaBoardDAO dao = new QnaBoardDAO();
				
				String state = "false"; // 성공, 실패 여부
				try {
					ReplyDTO dto = new ReplyDTO();
					
					long num = Long.parseLong(req.getParameter("num"));
					dto.setNum(num);
					dto.setUserId(info.getUserId());
					dto.setContent(req.getParameter("content"));
					String answer = req.getParameter("answer"); 
					if (answer != null) {
						dto.setAnswer(Long.parseLong(answer));
					}
					
					dao.insertReply(dto);
					PointDAO pointDAO = new PointDAO();
					pointDAO.updatePoint(info.getUserId(), Point.WRITE_COMMENT);
					
					state = "true";
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				model.put("state", state);
				
				return model;
			}
			
			
			// 댓글 리스트
			@RequestMapping(value = "/qnaboard/listReply", method = RequestMethod.GET)
			public ModelAndView listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				// 넘어온 파라미터 : 게시글 번호 [, 페이지 번호]
				QnaBoardDAO dao = new QnaBoardDAO();
				MyUtil util = new MyUtilBootstrap();
				
				
				try {
					long num = Long.parseLong(req.getParameter("num"));
					String pageNo = req.getParameter("pageNo");
					int current_page = 1;
					if (pageNo != null) {
						current_page = Integer.parseInt(pageNo);
					}
					
					int size = 5;
					int total_page = 0;
					int replyCount = 0;

					replyCount = dao.dataCountReply(num);
					total_page = util.pageCount(replyCount, size);
					if (current_page > total_page) {
						current_page = total_page;
					}
					
					int offset = (current_page - 1) * size;
					if (offset < 0) offset = 0;
					
					List<ReplyDTO> listReply = dao.listReply(num, offset, size);
					
					for (ReplyDTO dto : listReply) {
						dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
					}
					
					String paging = util.pagingMethod(current_page, total_page, "listPage");

					ModelAndView mav = new ModelAndView("qnaboard/listReply");
					
					mav.addObject("listReply", listReply);
					mav.addObject("pageNo", current_page);
					mav.addObject("replyCount", replyCount);
					mav.addObject("total_page", total_page);
					mav.addObject("paging", paging);
					
					return mav;
				} catch (Exception e) {
					e.printStackTrace();
					
					resp.sendError(400);
					
					throw e;
				}
				
			}
			
			
			// 댓글 삭제
			@ResponseBody
			@RequestMapping(value = "/qnaboard/deleteReply", method = RequestMethod.POST)
			public Map<String, Object> deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				Map<String, Object> model = new HashMap<String, Object>();
				
				HttpSession session = req.getSession();
				SessionInfo info = (SessionInfo)session.getAttribute("member");
				
				String state = "false";
				QnaBoardDAO dao = new QnaBoardDAO();
				try {
					long replyNum = Long.parseLong(req.getParameter("replyNum"));
					
					dao.deleteReply(replyNum, info.getUserId());
					PointDAO pointDAO = new PointDAO();
					pointDAO.updatePoint(info.getUserId(), Point.DELETE_COMMENT);
					
					state = "true";
					
				} catch (Exception e) {
					
				}
				
				model.put("state", state);
				
				return model;
			}
			
			
			// 댓글의 답글 리스트
			@RequestMapping(value = "/qnaboard/listReplyAnswer", method = RequestMethod.GET)
			public ModelAndView listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				QnaBoardDAO dao = new QnaBoardDAO();
				
				try {
					long answer = Long.parseLong(req.getParameter("answer"));
					
					List<ReplyDTO> listReplyAnswer = dao.listReplyAnswer(answer);
					
					for (ReplyDTO dto : listReplyAnswer) {
						dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
					}
					
					ModelAndView mav = new ModelAndView("qnaboard/listReplyAnswer");
					mav.addObject("listReplyAnswer", listReplyAnswer);
					return mav;
					
				} catch (Exception e) {
					e.printStackTrace();
					resp.sendError(400);
					throw e;
				}
			}
			
			
			// 댓글별 답글 개수
			@ResponseBody
			@RequestMapping(value = "/qnaboard/countReplyAnswer", method = RequestMethod.POST)
			public Map<String, Object> countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				Map<String, Object> model = new HashMap<String, Object>();
				
				QnaBoardDAO dao = new QnaBoardDAO();
				int count = 0;
				
				try {
					long answer = Long.parseLong(req.getParameter("answer"));
					count = dao.dataCountReplyAnswer(answer);
					
					model.put("state", "true");
				} catch (Exception e) {
					model.put("state", "false");
				}
				model.put("count", count);
				
				return model;
			}

}
