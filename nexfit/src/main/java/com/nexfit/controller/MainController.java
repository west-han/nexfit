package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.dao.BoardDAO;
import com.nexfit.domain.BoardDTO;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MainController {
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("main/main");
	    
		BoardDAO dao = new BoardDAO();
		
	    // topLikedPosts를 조회하여 모델에 추가
	    List<BoardDTO> topLikedPosts = dao.listTopLikedBoard(5);
	    mav.addObject("topLikedPosts", topLikedPosts);
	    
	    return mav;
	}
}
