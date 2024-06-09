package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.dao.BoardDAO;
import com.nexfit.dao.RoutineDAO;
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
	    
	    
	    RoutineDAO routineDAO = new RoutineDAO(); // RoutineDAO 인스턴스를 생성합니다.

        // routineDAO에서 최근 게시물을 가져와 모델에 추가합니다.
        List<BoardDTO> recentPosts = routineDAO.getRecentPosts(5);
        mav.addObject("recentPosts", recentPosts);
        
        
	    return mav;
	}
}
