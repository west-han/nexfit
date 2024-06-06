package com.nexfit.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.SptiDAO;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class SptiController {
	
	@RequestMapping(value = "/sports/spti/main", method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("sports/spti/main");
		
		return mav;
	}
	
	@RequestMapping(value = "/sports/spti/result", method = RequestMethod.GET)
	public ModelAndView result(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("sports/spti/main");
		String sptiResult = req.getParameter("sptiResult");
		
		SptiDAO dao = new SptiDAO();
		
		try {
			dao.insertSpti(sptiResult);
			System.out.println(sptiResult);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		mav.addObject("sptiResult", sptiResult);
		
		return mav;
	}
}
