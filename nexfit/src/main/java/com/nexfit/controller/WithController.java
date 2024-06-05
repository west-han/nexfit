package com.nexfit.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.dao.WithBoardDAO;
import com.nexfit.domain.WithBoardDTO;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class WithController {
	@RequestMapping(value = "/withme/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("withme/list");

	    WithBoardDAO dao = new WithBoardDAO();
	    MyUtil util = new MyUtilBootstrap();

	    try {
	        String page = req.getParameter("page");
	        int current_page = 1;
	        if (page != null) {
	            current_page = Integer.parseInt(page);
	        }

	        // 검색
	        String schType = req.getParameter("schType");
	        String kwd = req.getParameter("kwd");
	        if (schType == null) {
	            schType = "all";
	            kwd = "";
	        }


	        // GET 방식인 경우 디코딩
	        if (req.getMethod().equalsIgnoreCase("GET")) {
	            kwd = URLDecoder.decode(kwd, "utf-8");
	        }

	        // 전체 데이터 개수
	        int dataCount;
	        if (kwd.length() == 0) {
	            dataCount = dao.dataCount();
	        } else {
				dataCount = dao.dataCount(schType, kwd);
			}

	        // 전체 페이지 수
	        int size = 10;
	        int total_page = util.pageCount(dataCount, size);
	        if (current_page > total_page) {
	            current_page = total_page;
	        }

	        // 게시물 가져오기
	        int offset = (current_page - 1) * size;
	        if (offset < 0) offset = 0;

	        List<WithBoardDTO> list = null; 
	        if (kwd.length() == 0) {
	            list = dao.listBoard(offset, size);
	        } else {
	            list = dao.listBoard(offset, size, schType, kwd);
	        }

	        String query = "";
	        if (kwd.length() != 0) {
	            query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
	        }

	        // 페이징 처리
	        String cp = req.getContextPath();
	        String listUrl = cp + "/withme/list";
	        String articleUrl = cp + "/withme/article?page=" + current_page;
	        if (query.length() != 0) {
	            listUrl += "?" + query;
	            articleUrl += "&" + query;
	        }

	        String paging = util.paging(current_page, total_page, listUrl);

	        // 포워딩할 JSP에 전달할 속성
	        mav.addObject("list", list);
	        mav.addObject("page", current_page);
	        mav.addObject("total_page", total_page);
	        mav.addObject("dataCount", dataCount);
	        mav.addObject("size", size);
	        mav.addObject("articleUrl", articleUrl);
	        mav.addObject("paging", paging);
	        mav.addObject("schType", schType);
	        mav.addObject("kwd", kwd);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return mav;
	}
}
