package com.bit.escapeMb;

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
	public void setDao(EsRoomDao dao) {
		this.dao = dao;
	}

	@RequestMapping("listES2.do")
	public void form() {

	}
	
	@RequestMapping(value="/listRoom.do", produces="text/plain;charset=utf-8")
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
	
	
}
