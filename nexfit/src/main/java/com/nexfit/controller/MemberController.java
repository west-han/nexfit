package com.nexfit.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.MemberDAO;
import com.nexfit.domain.MemberDTO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 처리
		// 세션객체. 세션 정보는 서버에 저장(로그인 정보, 권한등을 저장)
		HttpSession session = req.getSession();

		MemberDAO dao = new MemberDAO();

		String userId = req.getParameter("userId");
		String userPwd = req.getParameter("userPwd");

		MemberDTO dto = dao.loginMember(userId, userPwd);
		if (dto != null) {
			// 로그인 성공 : 로그인정보를 서버에 저장
			// 세션의 유지시간을 20분설정(기본 30분)
			session.setMaxInactiveInterval(20 * 60);

			// 세션에 저장할 내용
			SessionInfo info = new SessionInfo();
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());

			// 세션에 member이라는 이름으로 저장
			session.setAttribute("member", info);

			// 메인화면으로 리다이렉트
			return new ModelAndView("redirect:/");
		}

		// 로그인 실패인 경우(다시 로그인 폼으로)
		ModelAndView mav = new ModelAndView("member/login");
		
		String msg = "아이디 또는 패스워드가 일치하지 않습니다.";
		mav.addObject("message", msg);

		return mav;
	}
	
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();
		
		return new ModelAndView("redirect:/");
	}
	@RequestMapping(value = "/member/member", method = RequestMethod.GET)
	public ModelAndView memberJoin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/member");
		

		mav.addObject("mode", "member");
		return mav;
	}
	
	@RequestMapping(value = "/member/member", method = RequestMethod.POST)
	public ModelAndView memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원가입 처리
		MemberDAO dao = new MemberDAO();
		
		String message = "";
		try {
			MemberDTO dto = new MemberDTO();
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			
			dto.setBirth(req.getParameter("birth"));
			
			String email1 = req.getParameter("email1");
			String email2 = req.getParameter("email2");
			dto.setEmail(email1 + "@" + email2);

			String tel1 = req.getParameter("tel1");
			String tel2 = req.getParameter("tel2");
			String tel3 = req.getParameter("tel3");
			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);

			dto.setZip(req.getParameter("zip"));
			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));

			dao.insertMember(dto);
			
			return new ModelAndView("redirect:/");
		} catch (SQLException e) {
			if (e.getErrorCode() == 1)
				message = "아이디 중복으로 회원 가입이 실패 했습니다.";
			else if (e.getErrorCode() == 1400)
				message = "필수 사항을 입력하지 않았습니다.";
			else if (e.getErrorCode() == 1840 || e.getErrorCode() == 1861)
				message = "날짜 형식이 일치하지 않습니다.";
			else
				message = "회원 가입이 실패 했습니다.";
			// 기타 - 2291:참조키 위반, 12899:폭보다 문자열 입력 값이 큰경우
		} catch (Exception e) {
			message = "회원 가입이 실패 했습니다.";
			e.printStackTrace();
		}

		ModelAndView mav = new ModelAndView("member/member");
		
		mav.addObject("title", "회원 가입");
		mav.addObject("mode", "member");
		mav.addObject("message", message);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/userIdCheck", method = RequestMethod.POST)
	public Map<String, Object> userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		//아이디 중복검사
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDAO dao = new MemberDAO();
		
		String userId = req.getParameter("userId");
		MemberDTO dto = dao.findById(userId);
		
		String passed ="false";
		if(dto == null) {
			passed="true";
		}
		map.put("passed", passed);
		
		return map;
	}
	
}
