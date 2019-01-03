package com.bit.escape;

import java.util.HashMap; 

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
import com.bit.vo.CustomerVo;

@Controller
public class RoomCustomerController {

	@Autowired
	private CustomerDao dao;

	public void setDao(CustomerDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value="/MemberJoin.do")
	public ModelAndView insertCustomer(CustomerVo rc)
	{				
		ModelAndView mav = new ModelAndView("redirect:/main.do");
		
		int re = dao.insertCustomer(rc);
				
		if(re != 1)
		{
			mav.addObject("msg", "등록 실패!");
			//회원가입 완료 메일 전송
		}
		else
		{
			mav.addObject("msg", "등록 성공!");			
		}
		
		return mav;
	}
	
	@RequestMapping(value="member/UpdateMemberInfo.do", method=RequestMethod.GET)
	public ModelAndView updateCustomerForm(String id)
	{
		ModelAndView mav = new ModelAndView();
		mav.addObject("rc", dao.selectCustomer(id));
		return mav;
	}
	
	@RequestMapping(value="member/UpdateMemberInfo.do", method=RequestMethod.POST)
	public ModelAndView updateCustomerSubmit(CustomerVo rc)
	{
		ModelAndView mav = new ModelAndView("redirect:/main.do");
		
		int re = dao.updateCustomer(rc);
		String msg = "수정 성공";
		if(re != 1)
		{
			msg = "수정 실패";
		}
		
		mav.addObject("msg");
		System.out.println("결과값:"+re);
		return mav;
	}

	@RequestMapping(value="member/deleteMemberInfo.do")
	public ModelAndView deleteCustomerSubmit(HttpServletRequest request, HttpSession session)
	{
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		int re = dao.deleteCustomer(id);
		if(re>0) {
			dao.logout(session);
			mav.setViewName("redirect:../main.do");
		}else {
			System.out.println("fail");
		}
		return mav;
	}
    // 로그아웃 하는 부분
/*    @RequestMapping(value="/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/CustomerLogin.do";
    }*/
 
    /*
    @RequestMapping(value="/CustomerLogin.do", produces="text/plain;charset=utf-8")
    @ResponseBody
	public String login(String id, String pwd, HttpSession session)
	{
    	String msg ="";
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("pwd", pwd);
		
		msg = "fail";
		int re = dao.isMember(map);
		
		if(re == 1)
		{
			session.setAttribute("id", id);
			session.setAttribute("userType", 1);
			session.setAttribute("msg", "로그인 성공");
			msg = "success";
		}
		
		return msg;
	}*/
 
}
