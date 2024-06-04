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
		@RequestMapping(value = "/mypage/account", method = RequestMethod.POST)
		public ModelAndView pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// 패스워드 확인
			MemberDAO dao = new MemberDAO();
			HttpSession session = req.getSession();

			try {
				SessionInfo info = (SessionInfo) session.getAttribute("member");

				// DB에서 해당 회원 정보 가져오기
				MemberDTO dto = dao.findById(info.getUserId());
				if (dto == null) {
					session.invalidate();
					return new ModelAndView("redirect:/");
				}

				String userPwd = req.getParameter("userPwd");
				String mode = req.getParameter("mode");
				if (! dto.getUserPwd().equals(userPwd)) {
					ModelAndView mav = new ModelAndView("member/pwd");
					
					mav.addObject("mode", mode);
					mav.addObject("message", "패스워드가 일치하지 않습니다.");
					
					return mav;
				}


				// 회원정보수정 - 회원수정폼으로 이동
				ModelAndView mav = new ModelAndView("mypage/account");
				
				mav.addObject("title", "회원 정보 수정");
				mav.addObject("dto", dto);
				mav.addObject("mode", "update");
				
				return mav;
			} catch (Exception e) {
				e.printStackTrace();
			}

			return new ModelAndView("redirect:/");
		}
		
		
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
				
				dto.setNickname(req.getParameter("nickName"));
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
				
				dao.updateMember(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ModelAndView("redirect:/");
		}
	}
	
	

