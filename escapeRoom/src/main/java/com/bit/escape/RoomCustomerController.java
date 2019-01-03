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
			mav.addObject("msg", "��� ����!");
			//ȸ������ �Ϸ� ���� ����
		}
		else
		{
			mav.addObject("msg", "��� ����!");			
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
		String msg = "���� ����";
		if(re != 1)
		{
			msg = "���� ����";
		}
		
		mav.addObject("msg");
		System.out.println("�����:"+re);
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
    // �α׾ƿ� �ϴ� �κ�
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
			session.setAttribute("msg", "�α��� ����");
			msg = "success";
		}
		
		return msg;
	}*/
 
}
