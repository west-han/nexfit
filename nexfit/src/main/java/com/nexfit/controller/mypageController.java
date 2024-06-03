package com.nexfit.controller;

import java.io.IOException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.MemberDAO;
import com.nexfit.dao.mypageDAO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class mypageController {
	@RequestMapping(value = "/mypage/mypage", method = RequestMethod.GET)
	public ModelAndView myhome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("mypage/mypage");
		
		mypageDAO dao = new mypageDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int count = dao.dataCount(info.getUserId());
		
		mav.addObject("count", count);

		return mav;
	}
	
	@RequestMapping(value = "/mypage/mypage", method = RequestMethod.POST)
	public ModelAndView nickName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("mypage/mypage");
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			MemberDTO dto = dao.findById(info.getUserId());
			
			mav.addObject("dto", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return mav;
		
	}
	
	
}
