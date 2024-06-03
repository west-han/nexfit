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
public class accountController {
	
		@RequestMapping(value = "/mypage/account", method = RequestMethod.GET)
		public ModelAndView account(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			return new ModelAndView("mypage/account");
		}
	}
	
	

