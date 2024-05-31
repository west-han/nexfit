package com.nexfit.controller;

import java.io.IOException;

import com.nexfit.annotation.Controller;
import com.nexfit.annotation.RequestMapping;
import com.nexfit.annotation.RequestMethod;
import com.nexfit.dao.SportsTypeDAO;
import com.nexfit.domain.SessionInfo;
import com.nexfit.domain.SportTypeDTO;
import com.nexfit.servlet.ModelAndView;
import com.nexfit.util.FileManager;
import com.nexfit.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class SportsController {
	
	@RequestMapping(value = "/sports/types/list", method = RequestMethod.GET)
	public ModelAndView types(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터: bodyPart -> 없으면 all
		
		ModelAndView mav = new ModelAndView("/sports/types/list");
		
		
		
		return mav;
	}
	
	@RequestMapping(value = "/sports/types/write", method = RequestMethod.GET)
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/sports/types/write");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if (!info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/sports/type/list");
		}
		
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
				dto.setSaveFilename(mmf.getSaveFilename());
			}
			
			dao.insert(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/sports/types/list");
	}
}
