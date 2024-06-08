package com.nexfit.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.Ch_applFormDAO;
import com.nexfit.dao.ChallengeBoardDAO;
import com.nexfit.dao.MyChallengeDAO;

import com.nexfit.domain.MyChallengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyChallengeController {
	@RequestMapping("/mychallenge/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mychallenge/list");
		
		MyChallengeDAO dao= new MyChallengeDAO();
		MyUtil util = new MyUtilBootstrap();
		ChallengeBoardDAO dao1 = new ChallengeBoardDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userid = info.getUserId();
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 전체 데이터 개수
			int dataCount=dao.dataCount(userid);
			
			
			// 전체 페이지수
			int size = 6;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
						
			List<MyChallengeDTO> list = null;
			
			list = dao.listMyChallenge(offset, size,userid);
		
			// 페이징
			
			
			String cp = req.getContextPath();
			String listUrl = cp + "/mychallenge/list";
			String articleUrl = cp + "/chboard/article?page=" + current_page;
			
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
	
	@ResponseBody
	@RequestMapping(value = "/mychallenge/success", method = RequestMethod.POST)
	public Map<String, Object> insertLectureLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		Ch_applFormDAO dao = new Ch_applFormDAO();
		
		String state = "진행중";

		try {
			long applnum= Long.parseLong(req.getParameter("applnum"));
			state = req.getParameter("appls");
			if(state=="성공") {
				return model;
			}
			dao.updateState(applnum);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("state", state);

		return model;
	}
}
