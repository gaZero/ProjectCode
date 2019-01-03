package com.bit.escape;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@RequestMapping("/main.do")
	public ModelAndView main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("loc1", request.getParameter("loc1"));
		mav.addObject("loc2", request.getParameter("loc2"));
		mav.addObject("ername", request.getParameter("ername"));
		
		return mav;
	}
	
	@RequestMapping(value="/insertAll.do", method=RequestMethod.GET)
	public void insertAll(){
	
	}
}
