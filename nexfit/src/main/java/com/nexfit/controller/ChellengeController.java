package com.nexfit.controller;



import java.io.IOException;


import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.ChellengeDAO;
import com.nexfit.domain.ChellengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChellengeController {
	@RequestMapping("/chellenge/list")
	public ModelAndView chellengelist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("chellenge/list");
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
	
	
	
}
	

