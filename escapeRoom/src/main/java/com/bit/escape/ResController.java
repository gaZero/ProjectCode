package com.bit.escape;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	public void resMain() {
		
	}

	@RequestMapping(value="/resShow.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String resShow(HttpServletRequest request) {
		String str = "";
		String str1 = "";
		String str2 = "";
		String loc1 = request.getParameter("loc1");
		String loc2 = request.getParameter("loc2");
		String ername = request.getParameter("ername");
		String date = request.getParameter("date");

		Map map1 = new HashMap();
		Map map2 = new HashMap();
		map1.put("loc1", loc1);
		map1.put("loc2", loc2);
		map1.put("ername", ername);
		map2.put("bookdate", date);

		List<ThemeVo> list1 = themeDao.selTheme_loc(map1);
		List<Theme_ResVo> list2 = resDao.selTheme_res(map2);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str1 = mapper.writeValueAsString(list1);
			str2 = mapper.writeValueAsString(list2);
			str = "{\"str1\":"+str1+",\"str2\":"+str2+"}";
		} catch (Exception e) {
			System.out.println(str1);
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/resDetail.do")
	public ModelAndView resDetail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String date = request.getParameter("date");
		String tcode = request.getParameter("tcode");
		String time = request.getParameter("time");
		String theme_resCode = request.getParameter("theme_resCode");
		String viewtime = request.getParameter("viewtime");
		mav.addObject("date", date);
		mav.addObject("tcode", tcode);
		mav.addObject("time", time);
		mav.addObject("viewtime", viewtime);
		mav.addObject("theme_resCode", theme_resCode);
		return mav;
	}
	
	@RequestMapping(value="/resCustomer.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String resCustomer(HttpServletRequest request) {
		String str = "";
		String id = request.getParameter("id");
		Map map = new HashMap();
		map.put("id", id);
		CustomerVo cv = customerDao.detailCustomer(map);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(cv);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
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
	
	@RequestMapping(value="/resOk.do", method=RequestMethod.POST)
	public ModelAndView resOk(ResVo rv) {
		rv.setResCode(rv.getTheme_resCode());
		ModelAndView mav = new ModelAndView("redirect:/main.do");
		int re = resDao.insertRes(rv);
		return mav;
	}
	
	@RequestMapping(value="/member/myPage_Res.do")
	public void myPage_Res() {
	}
	@RequestMapping(value="/member/myPage_Star.do")
	public void myPage_Star() {
	}
	
	@RequestMapping(value="/member/myPage_myRes.do", produces="text/plain;charset=utf-8")
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
	@RequestMapping(value="/member/myPage_giveStar.do")
	public ModelAndView insertStar(HttpServletRequest request) {
		String resCode = request.getParameter("resCode");
		String star = request.getParameter("star");
		ModelAndView mav = new ModelAndView("redirect:/member/myPage_Star.do");
		Map map = new HashMap();
		map.put("resCode", resCode);
		map.put("star", star);
		int re = resDao.updateStar(map);
		return mav;
	}
	
	@RequestMapping(value="resCancle.do")
	public ModelAndView resCancle(String resCode) {
		ModelAndView mav = new ModelAndView("redirect:/myPage_Res.do");
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
	
	@RequestMapping(value="/admin/reservationInfo.do")
	public void erPage_Res() {
	}
	@RequestMapping(value="/admin/reservationInfo_er.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String erPage_myRes(HttpServletRequest request) {
		
		String str = "";
		String str1 = "";
		String str2 = "";
		String id = request.getParameter("id");
		String date = request.getParameter("date");
		Map map1 = new HashMap();
		Map map2 = new HashMap();
		map1.put("id", id);
		map2.put("id", id);
		map2.put("bookdate", date);
		
		List<ThemeVo> list1 = themeDao.selTheme_id(map1);
		List<Theme_ResVo> list2 = resDao.selTheme_res(map2);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str1 = mapper.writeValueAsString(list1);
			str2 = mapper.writeValueAsString(list2);
			str = "{\"str1\":"+str1+",\"str2\":"+str2+"}";
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
	@RequestMapping(value="/admin/selErRes.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String selErRes(HttpServletRequest request) {
		
		String str = "";
		String theme_resCode = request.getParameter("theme_resCode");
		Map map = new HashMap();
		map.put("theme_resCode", theme_resCode);
		
		ResVo rv = resDao.selErRes(map);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(rv);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
}
