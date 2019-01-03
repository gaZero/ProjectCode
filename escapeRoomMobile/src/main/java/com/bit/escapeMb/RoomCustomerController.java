package com.bit.escapeMb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.CustomerDao;
import com.bit.dao.EsRoomDao;
import com.bit.vo.CustomerVo;
import com.bit.vo.EsRoomVo;
import com.bit.vo.ResVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class RoomCustomerController {


	@Autowired
	private CustomerDao dao;

	public void setDao(CustomerDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/myPage.do")
	public void myPage() {
		
	}
	

	@RequestMapping("/maptest.do")
	public void maptest()
	{
		
	}
	

	@RequestMapping("/loginPage.do")
	public void loginPage()
	{
		
	}
	
	
	
	@RequestMapping(value="/insertMember.do", method=RequestMethod.GET)
	public void insertForm(){
	
	}

	@RequestMapping(value="/insertMember.do", method=RequestMethod.POST)
	public ModelAndView insertCustomer(CustomerVo cv, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
	
		int re = dao.insertCustomer(cv);
	
		if(re>0) {
			mav.setViewName("redirect:/loginPage.do");
		}else {
			System.out.println("회원가입 실패");
		}
		return mav;
	}

	
	@RequestMapping(value="/updateMemberInfo.do")
	public ModelAndView updateCustomerSubmit(CustomerVo rc)
	{
		ModelAndView mav = new ModelAndView();
		
		int re = dao.updateCustomer(rc);
		if(re>0) {
			mav.setViewName("redirect:/mbMain.do");
		}else {
			System.out.println("fail");
		}
		return mav;
	}
	
	@RequestMapping(value="/deleteMemberInfo.do")
	public ModelAndView deleteCustomerSubmit(HttpServletRequest request, HttpSession session)
	{
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		int re = dao.deleteCustomer(id);
		if(re>0) {
			dao.logout(session);
			mav.setViewName("redirect:/mbMain.do");
		}else {
			System.out.println("fail");
		}
		return mav;
	}
	
	@RequestMapping(value="/myPage_myInfor.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String myPage_myRes(HttpServletRequest request) {
		String str = "";
		String id = request.getParameter("id");
		CustomerVo vo = dao.selectCustomer(id);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(vo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}


	@RequestMapping(value="/login.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String submit(String id, String pwd,HttpSession session)
	{
		System.out.println("id :"+id+"pwd :"+pwd);
		
		Map map = new HashMap ();
		map.put("id", id);
		map.put("pwd", pwd);

		
		String msg = "fail";
		
		int isCustomer = dao.isMember(map);
		
		if(isCustomer>0) {
			session.setAttribute("id", id);
			session.setAttribute("msg", "로그인 성공");
			msg = "success";
		}
		
		System.out.println(msg);
		return msg;
	
	} 

	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		dao.logout(session);
		mav.setViewName("redirect:/mbMain.do");		
		return mav;
	}
	
	
	@RequestMapping(value="/checkID.do")
	@ResponseBody
	public String checkId(String id) {
		String uid = "no";
		uid = dao.checkID(id);
		
		return uid;
	}
	
}
