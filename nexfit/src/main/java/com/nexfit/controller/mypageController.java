package com.nexfit.controller;

import java.io.IOException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.MemberDAO;
import com.nexfit.dao.PointDAO;
import com.nexfit.dao.mypageDAO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.PointDTO;
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
		PointDAO dao2 = new PointDAO();
		mypageDAO dao = new mypageDAO();
		MemberDAO dao1 = new MemberDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		 PointDTO latestPoint = dao2.findById(info.getUserId());
	     long currentPoint = latestPoint.getCurrentPoint();
	        
		int count = dao.dataCount(info.getUserId());
		int rpl_count =  dao.replyCount(info.getUserId());
		
		MemberDTO dto = dao1.findById(info.getUserId());
		//dao에서 찾은 dto객체를 dto(변수)에 담아서 모델앤드뷰로 다시 보내주면 화면에 보임
		ModelAndView mav = new ModelAndView("mypage/mypage");
		 mav.addObject("currentPoint", currentPoint);
		mav.addObject("a", dto); //dto에 findbyid로 찾은 객체를 dto에 담겠다는거고 그걸 또 mav에 추가 ""안에는 a를 줘도됨 걍 이름지어주는거임 그걸로 a.bio이런식으로 사용하면 됨
		mav.addObject("count", count);
		mav.addObject("rpl_count", rpl_count);
		return mav;
	}
	
	
	@RequestMapping(value = "/mypage/mypage", method = RequestMethod.POST)
	public ModelAndView nickName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("mypage/mypage");
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info == null) {//로그아웃 된 경우
			return new ModelAndView("redirect:/member/login");
		}
		try {
			MemberDTO dto = dao.findById(info.getUserId());
			dto.setBio(req.getParameter("bio"));
			mav.addObject("dto", dto);
		} catch (Exception e) {
		}
		
		return mav;
		
	}
	
	
	
}
