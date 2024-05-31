package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

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
public class ChellengeBoardController {
	@RequestMapping(value = "/chboard/write", method = RequestMethod.GET )
	public ModelAndView newChboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ChellengeDAO dao = new ChellengeDAO();
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/chellenge/list");
			
		}
		
		List<ChellengeDTO> list = dao.listChellenge();
		
		ModelAndView mav = new ModelAndView("chboard/write");
		
		mav.addObject("list", list);
		
		return mav;
	}
}
