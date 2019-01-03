package com.bit.escapeMb;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.CustomerDao;
import com.bit.dao.ResDao;
import com.bit.dao.ThemeDao;
import com.bit.vo.CustomerVo;
import com.bit.vo.ResVo;
import com.bit.vo.ThemeVo;
import com.bit.vo.Theme_ResVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ResController {

	@Autowired
	private ResDao resDao;
	@Autowired
	private ThemeDao themeDao;
	@Autowired
	private CustomerDao customerDao;

	public void setResDao(ResDao resDao) {
		this.resDao = resDao;
	}
	public void setThemeDao(ThemeDao themeDao) {
		this.themeDao = themeDao;
	}
	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}
	
	@RequestMapping(value="/resMain.do")
	public ModelAndView resMain(HttpServletRequest request) {
		String tcode = request.getParameter("tcode");
		
		ModelAndView mav = new ModelAndView();
		Map map = new HashMap();
		map.put("tcode", tcode);
		mav.addObject("vo",themeDao.selectOne(map));
		return mav;
	}

	@RequestMapping(value="/resShow.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String resShow(HttpServletRequest request) {
		String str = "";
		String tcode = request.getParameter("tcode");
		String date = request.getParameter("date");
		Map map = new HashMap();
		map.put("tcode", tcode);
		map.put("bookdate", date);

		List<Theme_ResVo> list = resDao.selTheme_res(map);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/resOk.do", method=RequestMethod.POST)
	public ModelAndView resOk(ResVo rv) {
		rv.setResCode(rv.getTheme_resCode());
		ModelAndView mav = new ModelAndView("redirect:/mbMain.do");
		int re = resDao.insertRes(rv);
		return mav;
	}
	
	@RequestMapping(value="/myPage_myRes.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String myPage_myRes(HttpServletRequest request) {
		String str = "";
		String id = request.getParameter("id");
		Map map = new HashMap();
		map.put("cid", id);
		List<ResVo> list = resDao.selMyRes(map);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/resCancle.do")
	public ModelAndView resCancle(String resCode) {
		ModelAndView mav = new ModelAndView("redirect:/myPage.do");
		Map map = new HashMap();
		map.put("resCode", resCode);
		int re = resDao.deleteRes(map);
		String msg = "ok";
		if(re < 1) {
			msg = "fail";
		}
		mav.addObject("msg",msg);
		return mav;
	}
	
	@RequestMapping(value="/resTheme.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String resTheme(HttpServletRequest request) {
		String str = "";
		String tcode = request.getParameter("tcode");
		Map map = new HashMap();
		map.put("tcode", tcode);
		ThemeVo tv = themeDao.selTheme_tcode(map);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(tv);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/mbStar.do")
	public void mbStar() {
		
	}
	
	@RequestMapping(value="/myPage_giveStar.do")
	public ModelAndView insertStar(HttpServletRequest request) {
		String resCode = request.getParameter("resCode");
		String star = request.getParameter("star");
		ModelAndView mav = new ModelAndView("redirect:/mbStar.do");
		Map map = new HashMap();
		map.put("resCode", resCode);
		map.put("star", star);
		int re = resDao.updateStar(map);
		return mav;
	}
}
