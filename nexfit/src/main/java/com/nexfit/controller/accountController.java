package com.nexfit.controller;

import java.io.IOException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.MemberDAO;
import com.nexfit.dao.mypageDAO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class accountController {
	
		@RequestMapping(value = "/mypage/account", method = RequestMethod.GET)
		public ModelAndView account(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			return new ModelAndView("mypage/account");
		}
		
		
		//db랑 dao에 있는거를 받아서 보내주는거고(모델앤드뷰를 생성한 주소로 보냄)
		@RequestMapping(value = "/mypage/update", method = RequestMethod.GET)
		public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			MemberDAO dao = new MemberDAO();
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			MemberDTO dto = dao.findById(info.getUserId());
			ModelAndView mav = new ModelAndView("mypage/account"); // mypage/account파일의 위치에"/mypage/update"이주소랑 데이터값들을 씌워줌
			
			
			mav.addObject("dto",dto); //서버에서 받아온 정보를 화면에 보내줌(jsp에서 사용할 수 있게)
			
			
			return mav;
					
		}
		
		// 정보수정을 누르면 파라미터값을 받아서 서버로 전송해주는 역할
		@RequestMapping(value = "/mypage/update", method = RequestMethod.POST)
		public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			mypageDAO dao = new mypageDAO();
			HttpSession session = req.getSession(); 
			try {
				SessionInfo info = (SessionInfo) session.getAttribute("member");
				if(info == null) {//로그아웃 된 경우
					return new ModelAndView("redirect:/member/login");
				}
				
				MemberDTO dto = new MemberDTO();
				
				dto.setUserId(req.getParameter("userId"));
				dto.setNickname(req.getParameter("nickname")); // 파라미터(get에서 받아온값이나 입력한 값) 값들을 req로 받아와서 새로운 dto리스트에 받아서 다시 서버로 전송해줌 
				dto.setUserPwd(req.getParameter("userPwd"));
				dto.setUserName(req.getParameter("userName"));
				
				dto.setBio(req.getParameter("bio"));
				dto.setBirth(req.getParameter("birth"));
				
				String email1 = req.getParameter("email1");
				String email2 = req.getParameter("email2");
				dto.setEmail(email1+"@"+email2);
				
				String tel1 = req.getParameter("tel1");
				String tel2 = req.getParameter("tel2");
				String tel3 = req.getParameter("tel3");
				dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
				
				dto.setZip(req.getParameter("zip"));
				dto.setAddr1(req.getParameter("addr1"));
				dto.setAddr2(req.getParameter("addr2"));
				
				dao.updateMember(dto); //db서버로 다시 보내줌
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ModelAndView("redirect:/mypage/update");
		}
	}
	
	

