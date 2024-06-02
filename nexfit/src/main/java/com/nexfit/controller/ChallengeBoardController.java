package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.ChallengeDAO;
import com.nexfit.domain.ChallengeDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChallengeBoardController {
	@RequestMapping(value = "/chboard/write", method = RequestMethod.GET )
	public ModelAndView newChboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		ChallengeDAO dao = new ChallengeDAO();
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/challenge/list");
			
		}
		
		List<ChallengeDTO> list = dao.listChallenge();
		
		ModelAndView mav = new ModelAndView("chboard/write");
		
		mav.addObject("list", list);
		
		return mav;
	}
}
