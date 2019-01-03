package com.bit.escape;

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
	
	@RequestMapping("/admin/theme/listTheme.do")
	public ModelAndView theme_list(HttpServletRequest request) 
	{
		String id = request.getParameter("id");
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		ModelAndView mav = new ModelAndView();
		Map map = new HashMap();
		map.put("id", id);
		mav.addObject("list",dao.listAll(map));
		return mav;
	}
	
	@RequestMapping(value="/admin/theme/insertTheme.do", method=RequestMethod.GET)
	public void theme_insert_form(String id, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
	}
	
	@RequestMapping(value="/admin/theme/insertTheme.do", method=RequestMethod.POST)
	public ModelAndView theme_insert(String id, ThemeVo vo, HttpServletRequest request) {
		String path = request.getRealPath("resources/theme");
		System.out.println("path:"+path);
		MultipartFile uploadFile = vo.getUploadFile();
		if(uploadFile != null) {
			try {
				String fname = uploadFile.getOriginalFilename();
				byte data[] = uploadFile.getBytes();
				vo.setFname(fname);
				
				FileOutputStream fos = new FileOutputStream(path + "/" +fname);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		ModelAndView mav = new ModelAndView("redirect:/admin/theme/listTheme.do?id="+id);
		int re = dao.insert(vo);
		if(re < 1) {
			System.out.println("에러가 발생하였습니다.");
		}
		return mav;
	}
	
	@RequestMapping(value="/selectErname.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String selectErname(HttpServletRequest request) {
		String str = "";
		String id = request.getParameter("id");
		Map map = new HashMap();
		map.put("id", id);
		ThemeVo vo= dao.selectErname(map);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(vo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}		
		return str;
	}

	@RequestMapping(value="/admin/theme/updateTheme.do", method=RequestMethod.GET, produces="text/plain;charset=utf-8")
	public ModelAndView theme_update_form(String id, HttpServletRequest request) {
		String tcode = request.getParameter("tcode");
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		ModelAndView mav = new ModelAndView();
		Map map = new HashMap();
		map.put("tcode", tcode);
		mav.addObject("vo",dao.selectOne(map));
		return mav;
	}
	
	@RequestMapping(value="/admin/theme/updateTheme.do", method=RequestMethod.POST)
	public ModelAndView theme_update(String id, ThemeVo vo, HttpServletRequest request) {
		String path = request.getRealPath("resources/theme");
		System.out.println("path:"+path);
		
		System.out.println("tcode="+vo.getTcode());
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		MultipartFile uploadFile = vo.getUploadFile();

		if(uploadFile != null) {
			try {
				String fname = uploadFile.getOriginalFilename();
				byte data[] = uploadFile.getBytes();
				vo.setFname(fname);
				
				FileOutputStream fos = new FileOutputStream(path + "/" +fname);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		ModelAndView mav = new ModelAndView("redirect:/admin/theme/listTheme.do?id="+id);
		int re = dao.update(vo);
		if(re < 1) {
			System.out.println("에러가 발생하였습니다.");
		}
		return mav;
	}
	
	///////////////////////////////////////delete/////////////////
	@RequestMapping(value="/admin/theme/deleteTheme.do")
	public ModelAndView theme_delete(String id, HttpServletRequest request)
	{
		String tcode = request.getParameter("tcode");
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		
		ModelAndView mav = new ModelAndView("redirect:/admin/theme/listTheme.do?id="+id);
		Map map = new HashMap();
		map.put("tcode", tcode);
		int re = dao.delete(map);
		if(re < 1) {
			System.out.println("에러가 발생하였습니다.");
		}
		return mav;
	}
}