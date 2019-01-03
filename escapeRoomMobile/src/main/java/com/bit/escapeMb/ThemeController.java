package com.bit.escapeMb;

import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.ThemeDao;
import com.bit.vo.ThemeVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ThemeController {

	@Autowired
	private ThemeDao dao;
	
	@RequestMapping("/themeMain.do")
	public void themeMain(HttpServletRequest request) 
	{
		String eid = request.getParameter("eid");
		HttpSession session = request.getSession();
		session.setAttribute("eid", eid);
	}
	@RequestMapping("/themeAll.do")
	public void themeAll(HttpServletRequest request) 
	{
		String genre = request.getParameter("genre");
		
		HttpSession session = request.getSession();
		session.setAttribute("genre", genre);
	}
	@RequestMapping(value="/theme_list.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String themeMain_list(HttpServletRequest request) {
		String str = "";
		String id = request.getParameter("id");
		String genre = request.getParameter("genre");
		Map map = new HashMap();
		map.put("id", id);
		map.put("genre", genre);
		List<ThemeVo> list = dao.listAll(map);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}		
		return str;
	}
}