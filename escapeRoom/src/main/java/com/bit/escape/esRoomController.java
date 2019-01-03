package com.bit.escape;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.CustomerDao;
import com.bit.dao.EsRoomDao;
import com.bit.vo.CustomerVo;
import com.bit.vo.EsRoomVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class esRoomController {

	
	@Autowired
	private EsRoomDao dao;
	
	@Autowired
	private CustomerDao cdao;
	
	public void setDao(EsRoomDao dao) {
		this.dao = dao;
	}

	public void setCdao(CustomerDao cdao) {
		this.cdao = cdao;
	}

	@RequestMapping("listES2.do")
	public void form() {

	}
	
	@RequestMapping(value="listRoom.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String listEsRoom(HttpServletRequest request) {
		String str ="";
		String loc1=null;
		String loc2=null;
		String ername =null;
		
		if(request.getParameter("loc1")!=null) {
			loc1 = request.getParameter("loc1");
		}
		if(request.getParameter("loc2")!=null) {
			loc2 = request.getParameter("loc2");
		}
		if(request.getParameter("ername")!=null) {
			ername = request.getParameter("ername");
		}
		HashMap map = new HashMap();
		map.put("loc1", loc1);
		map.put("loc2", loc2);
		map.put("ername",ername);
		
		
		List<EsRoomVo> list = dao.listRoom(map);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
		
		
	}
	
	
	@RequestMapping(value="detailInfo.do")
	public ModelAndView detail(String ername) {
		ModelAndView mav = new ModelAndView();
		EsRoomVo ev = dao.detailRoom(ername);
		mav.addObject("ev",ev);
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/myPageAdmin.do")
	public ModelAndView detailID(String id,HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		EsRoomVo ev = dao.esroomDetail(id);
		mav.addObject("ev",ev);
		return mav;
	}
	
	@RequestMapping(value="/insertRoom.do")
	public ModelAndView insertRoom(EsRoomVo vo, HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		String path = request.getRealPath("resources/img");
		System.out.println("path:"+path);		
		try {
		String fname = "";
		MultipartFile uploadFile = vo.getUploadFile();
		fname = uploadFile.getOriginalFilename();
		System.out.println("uploadFile:"+uploadFile);
		if( fname != null &&  !fname.equals(""))
		{			
			FileOutputStream fos = new FileOutputStream(path + "/"+fname);
			byte []data = uploadFile.getBytes();
			fos.write(data);
			fos.close();						
		}
		else
		{
			fname = "";
		}
		vo.setFname(fname);
		}catch(Exception e) {
			System.out.println(e.getMessage());

		}
		int re = dao.insertRoom(vo);
		if(re>0) {
			mav.setViewName("redirect:/listES2.do");
		}else {
			System.out.println("fail");
		}
		return mav;
	}

	@RequestMapping(value="/loginPage.do")
	public void loginPage() {
		
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
		

		boolean isRsRoom = dao.isMember(map);
		System.out.println("isRsRoom : "+ isRsRoom);
		

		if(isRsRoom == true)
		{
			session.setAttribute("id", id);
			session.setAttribute("userType", 0);
			msg = "success";
		}

		
		int isCustomer = cdao.isMember(map);
		
		if(isCustomer == 1)
		{	System.out.println("시다오 찍고옴");
			session.setAttribute("id", id);
			session.setAttribute("userType", 1);
			session.setAttribute("msg", "로그인 성공");
			msg = "success";
		}else if(isCustomer == 0)
		{
			session.setAttribute("msg", "패스워드가 틀림");
		}
		else if(isCustomer == -1)
		{
			session.setAttribute("msg", "아이디가 존재하지 않음");
		}			
		System.out.println("isCustomer : "+ isCustomer);

		
		
		System.out.println(msg);
		return msg;
	
	} 
	

	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		dao.logout(session);
		mav.setViewName("redirect:/main.do");		
		return mav;
	}
	
	
	@RequestMapping(value="admin/updateRoom.do", method=RequestMethod.GET)
	public ModelAndView updateRoom(String id,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("ev",dao.esroomDetail(id));
		session.setAttribute("id", id);
		return mav;
		
	}
	
	@RequestMapping(value="admin/updateRoom.do", method=RequestMethod.POST)
	public ModelAndView updateRoom(EsRoomVo vo,MultipartHttpServletRequest request,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String oldFname = vo.getFname();
		String path = request.getRealPath("resources/img");
		System.out.println("path:"+path);
		String fname = "";	
		try {
			MultipartFile uploadFile = request.getFile("file"); 
			vo.setUploadFile(uploadFile);
			fname = uploadFile.getOriginalFilename();
			
			if(fname!=null && !fname.equals("")) {
				FileOutputStream fos = new FileOutputStream(path+"/"+fname);
				System.out.println(path+"/"+fname);
				byte []data = uploadFile.getBytes();
				fos.write(data);
				fos.close();
				vo.setFname(fname);
			}
				
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	
		System.out.println(vo.getAddr());
		int re = dao.updateRoom(vo);
		String msg = "success";
		mav.addObject("id",vo.getId());
		mav.setViewName("redirect:/admin/myPageAdmin.do");
		if(re<1) {
			msg = "fail";
		}
		request.getSession().setAttribute("msg", msg);
		System.out.println(msg);
		
		if(re>0 && !oldFname.equals("")&&fname!=null&&!fname.equals("")) {
			File file = new File(path+"/"+oldFname);
			file.delete();
		}
		
		return mav;
	}
	
	
	@RequestMapping("admin/deleteRoom.do")
	public ModelAndView delete(String id,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();

		String path = request.getRealPath("resources/img");
		String oldFname = dao.esroomDetail(id).getFname();
		
		int re = dao.deleteRoom(id);
		
		String msg = "success";
		
		if(re < 1)
		{			
			msg = "fail";
		}
		
		session.invalidate();
		mav.setViewName("redirect:../listES2.do");
		System.out.println(msg);
		
		if(re > 0 &&   oldFname!= null &&  !oldFname.equals(""))
		{
			
			File file= new File(path + "/"+  oldFname);
			file.delete();
		}		
		
		return mav;
	}
	
	
	
}
