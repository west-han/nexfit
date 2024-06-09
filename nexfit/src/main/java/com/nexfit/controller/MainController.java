package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.dao.BoardDAO;
import com.nexfit.dao.QnaBoardDAO;
import com.nexfit.domain.BoardDTO;
import com.nexfit.domain.QnaBoardDTO;
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
		
	    List<BoardDTO> topLikedPosts = dao.listTopLikedBoard(5);
	    mav.addObject("topLikedPosts", topLikedPosts);
	    
        QnaBoardDAO dao1 = new QnaBoardDAO();

        List<QnaBoardDTO> recentQnaPosts = dao1.listRecentQnaBoardPosts(5);

        mav.addObject("recentQnaPosts", recentQnaPosts);
        
        BoardDAO dao2 = new BoardDAO();
        List<BoardDTO> recentFreePosts = dao2.listRecentBoardPosts(5);
        mav.addObject("recentFreePosts", recentFreePosts);

        
	    return mav;
	}
}
