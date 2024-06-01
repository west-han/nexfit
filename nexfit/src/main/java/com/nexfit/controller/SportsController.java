package com.nexfit.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.annotation.ResponseBody;
import com.nexfit.dao.SportsTypeDAO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.domain.SportTypeDTO;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.FileManager;
import com.nexfit.util.MyMultipartFile;
import com.nexfit.util.MyUtil;
import com.nexfit.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class SportsController {
	@RequestMapping(value = "/sports/types/list", method = RequestMethod.GET)
	public ModelAndView listTypes(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터: bodyPart -> 없으면 all, pageNo, keyword(검색어)
		ModelAndView mav = new ModelAndView("/sports/types/list");
		SportsTypeDAO dao = new SportsTypeDAO();
		
		String bodyPart = req.getParameter("bodyPart");		
		
		if (bodyPart == null) {
			bodyPart = "all";
		}
		
		mav.addObject("map", dao.listBodyPart());
		mav.addObject("bodyPart", bodyPart);
		mav.addObject("pageNo", 1);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sports/types/listAjax", method = RequestMethod.GET)
	public Map<String, Object> listTypesAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		SportsTypeDAO dao = new SportsTypeDAO();
		
		try {
			String keyword = req.getParameter("keyword");
		
			if (keyword == null) {
				keyword = "";
			} else {
				keyword = keyword.trim();
			}
			
			String bodyPart = req.getParameter("bodyPart");
			if (bodyPart == null) {
				bodyPart = "all";
			}
			
			MyUtil util = new MyUtilBootstrap();
				
			String page = req.getParameter("pageNo");
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}
			int size = 8;
			int dataCount = dao.dataCount(bodyPart, keyword);
			int totalPage = util.pageCount(dataCount, size);
			if (currentPage > totalPage) {
				currentPage = totalPage;
			}
			
			int offset = (currentPage - 1) * size;
			
			List<SportTypeDTO> list = dao.list(offset, size, bodyPart, keyword);
			
			for (SportTypeDTO dto : list) {
				dto.setDescription(dto.getDescription().replaceAll("\\[", "<h3>"));
				dto.setDescription(dto.getDescription().replaceAll("\\]", "</h3>"));
				dto.setDescription(dto.getDescription().replaceAll("\n", "<br>"));
				
				System.out.println(dto.toString());
			}
			
			boolean admin = false;
			if (((SessionInfo)req.getSession().getAttribute("member")).getUserId().equals("admin")) {
				admin = true;
			}
			
			model.put("list", list);
			model.put("pageNo", currentPage);
			model.put("totalPage", totalPage);
			model.put("dataCount", dataCount);
			model.put("permit", admin);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return model;
	}
	
	@RequestMapping(value = "/sports/types/write", method = RequestMethod.GET)
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/sports/types/write");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if (!info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/sports/type/list");
		}
		
		SportsTypeDAO dao = new SportsTypeDAO();
		mav.addObject("map", dao.listBodyPart());
		mav.addObject("mode", "write");
		
		return mav;
	}

	@RequestMapping(value = "/sports/types/write", method = RequestMethod.POST)
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		FileManager fileManager = new FileManager();
		SportsTypeDAO dao = new SportsTypeDAO();
		String pathname = req.getServletContext().getRealPath(req.getContextPath()) + "/uploads";
		
		try {
			SportTypeDTO dto = new SportTypeDTO();
			
			dto.setUserId(info.getUserId());
			dto.setName(req.getParameter("name"));
			dto.setDescription(req.getParameter("description"));
			dto.setBodyPart(req.getParameter("bodyPart"));

			Part part = req.getPart("selectFile");
			if (part != null) {
				MyMultipartFile mmf = fileManager.doFileUpload(part, pathname);
				dto.setFilename(mmf.getSaveFilename());
			}
			
			dao.insert(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/sports/types/list");
	}
}
