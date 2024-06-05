package com.nexfit.controller;

import java.io.IOException;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.MemberDAO;
import com.nexfit.dao.mypageDAO;
import com.nexfit.domain.BoardDTO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class communityController {
	
	@RequestMapping(value = "/mypage/community", method = RequestMethod.GET)
	public ModelAndView community(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		mypageDAO dao = new mypageDAO();
		MemberDAO dao1 = new MemberDAO();
		 MyUtil util = new MyUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int count = dao.dataCount(info.getUserId());
		int rpl_count =  dao.replyCount(info.getUserId());
		
		MemberDTO dto = dao1.findById(info.getUserId());
		//dao에서 찾은 dto객체를 dto(변수)에 담아서 모델앤드뷰로 다시 보내주면 화면에 보임
		
		String page = req.getParameter("page");
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		int size = 10;
		int dataCount = dao.dataCount(info.getUserId());
		int total_page = util.pageCount(dataCount, size);
        if (currentPage > total_page) {
            currentPage = total_page;
        }

		int offset = (currentPage - 1) * size;
		if (offset < 0) offset = 0;
		
		List<BoardDTO> list = dao.writeList(offset, size, dto);
		 String cp = req.getContextPath();
	        String listUrl = cp + "/mypage/community";
	        String articleUrl = cp + "/mypage/community?page=" + currentPage;
	        
	        String paging = util.paging(currentPage, total_page, listUrl);
		
		ModelAndView mav = new ModelAndView("mypage/community");
		mav.addObject("articleUrl", articleUrl);
		mav.addObject("paging", paging);
		
		mav.addObject("dto", dto); //dto에 findbyid로 찾은 객체를 dto에 담겠다는거고 그걸 또 mav에 추가 ""안에는 a를 줘도됨 걍 이름지어주는거임 그걸로 a.bio이런식으로 사용하면 됨
		mav.addObject("count", count);
		mav.addObject("rpl_count", rpl_count);
		
		mav.addObject("page", currentPage);
		mav.addObject("list", list);
		mav.addObject("dataCount", dataCount);
		mav.addObject("offset", offset);
		mav.addObject("total_page", total_page);
		
		return mav;
				
}

	
	
	
	
}



