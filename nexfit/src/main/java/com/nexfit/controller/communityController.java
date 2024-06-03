package com.nexfit.controller;

import java.io.IOException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class communityController {
	@RequestMapping(value = "/mypage/community", method = RequestMethod.GET)
	public ModelAndView community(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("mypage/community");
	}
}



