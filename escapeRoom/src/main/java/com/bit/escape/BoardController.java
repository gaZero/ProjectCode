package com.bit.escape;



import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.BoardDao;
import com.bit.dao.CustomerDao;
import com.bit.dao.EsRoomDao;
import com.bit.vo.BoardVo;
import com.bit.vo.EsRoomVo;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class BoardController {

	@Autowired
	private BoardDao bdao;
	@Autowired
	private EsRoomDao edao;
	@Autowired
	private CustomerDao cdao;
	
	
	
	
	
	
	public void setBdao(BoardDao bdao) {
		this.bdao = bdao;
	}


	public void setEdao(EsRoomDao edao) {
		this.edao = edao;
	}


	public void setCdao(CustomerDao cdao) {
		this.cdao = cdao;
	}

	
	//=======================================================사용자용 시작==========================================================
	
	@RequestMapping("/bmain.do")
	public ModelAndView allmain(String ername,HttpSession sen)
	{	
	
		ModelAndView mav = new ModelAndView();
		String id = (String)sen.getAttribute("id");
		
		if(id!=null)
		{
		int userType = Integer.parseInt(sen.getAttribute("userType").toString());
		Map map = new HashMap();
		map.put("id", id);
		map.put("ername", ername);
		
		boolean re = false;
			re = edao.isMine(map);
			if(re==true)
			{
					
				sen.setAttribute("userType", 0);
			}else
			{
				sen.setAttribute("userType", 1);
			}
			mav.addObject("id", id);
			mav.addObject("ername",ername);
		
		}
		sen.setAttribute("ername", ername);
		
		System.out.println(sen.getAttribute("userType"));
		return mav;
	}
	@RequestMapping("/blist.do")
	public ModelAndView blist(String ername,HttpSession sen)
	{	
	
		ModelAndView mav = new ModelAndView();
		String id = (String)sen.getAttribute("id");
		ername = (String) sen.getAttribute("ername");
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/listBoard.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String alllistJson(HttpSession sen)
	{
		
		String str ="";
	
		Map map = new HashMap();
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(sen.getAttribute("ername"));
		map.put("ername", sen.getAttribute("ername"));
		try {
			str = mapper.writeValueAsString(bdao.getList(map));
			System.out.println("컨트롤러 str 받은 후:"+str);
			
		} catch (Exception e) { System.out.println(e.getMessage());
			// TODO: handle exception
		}
		return str;
	}
	
	
	
	
	@RequestMapping(value="/admin/insertBoard.do", method =RequestMethod.GET)
	public ModelAndView aform(@RequestParam(value="no",defaultValue="0") int no, String id, HttpSession sen,HttpServletResponse response)
	{
	
		ModelAndView ma = new ModelAndView();
		
	
		String title="공지 작성";
		Map map = new HashMap();
		map.put("no", no);
		map.put("ername", sen.getAttribute("ername"));
		map.put("id", sen.getAttribute("id"));
		if (no!=0) 
		{
			title = "답변 작성";
			ma.addObject("pTitle","답변)"+bdao.getBoard(map).getTitle());
				
		}
		ma.addObject("no", no);
		ma.addObject("title", title);
		ma.addObject("id", id);
		return ma;
	}
	
	@RequestMapping(value="/admin/insertBoard.do",method=RequestMethod.POST)
	public ModelAndView aSubmit(BoardVo b,HttpServletRequest request,HttpSession sen)
	{
		
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		

		MultipartFile uploadFile = b.getUploadFile();
		if(uploadFile!=null)
		{
			try {
					String fname = uploadFile.getOriginalFilename();
					byte data[] = uploadFile.getBytes();
					b.setFname(fname);
					
					FileOutputStream fos = new FileOutputStream(path+"/"+fname);
					fos.write(data);
					fos.close();
				
			} catch (Exception e) { System.out.println(e.getMessage());
				
				// TODO: handle exception
			}
		}
		Map map1 = new HashMap();
		map1.put("ername", sen.getAttribute("ername") );
		
		int pno = b.getNo();
		int no = bdao.getNextNo(map1);
		
		b.setNo(no);
		int b_ref = no;
		int b_step = 0;
		int b_level = 0;
		
		map1.put("no", pno);
		
		
		if(pno!=0)
		{
			BoardVo p = bdao.getBoard(map1);
			b_ref = p.getB_ref();
			b_level = p.getB_level();
			b_step =p.getB_step();
			
			Map map = new HashMap();
			map.put("b_ref", b_ref);
			map.put("b_step", b_step);
			map.put("ername", p.getErname());
			bdao.updateStep(map);
			
			b_level++;
			b_step++;
			
		}

		b.setB_ref(b_ref);
		b.setB_level(b_level);
		b.setB_step(b_step);
		
		
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		b.setIp(request.getRemoteAddr());
		
		
		int re = bdao.insert(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 등록실패");
			ma.setViewName("error");
		}
		
		return ma;
	}
	
	
	
	
	
	@RequestMapping(value="/admin/listBoard.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String listJson(HttpSession sen)
	{
		
		String str ="";
	
		Map map = new HashMap();
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(sen.getAttribute("ername"));
		map.put("ername", sen.getAttribute("ername"));
		try {
			str = mapper.writeValueAsString(bdao.getList(map));
			System.out.println("컨트롤러 str 받은 후:"+str);
			
		} catch (Exception e) { System.out.println(e.getMessage());
			// TODO: handle exception
		}
		return str;
	}

	@RequestMapping("admin/detailBoard.do")
	public ModelAndView aGetBoard(int no, int cu, HttpSession sen)
	{
		ModelAndView ma = new ModelAndView();
		Map map = new HashMap();
		map.put("no", no);
		map.put("ername",sen.getAttribute("ername"));
		bdao.updateHit(map);
		ma.addObject("cu",cu);
		
		ma.addObject("b", bdao.getBoard(map));
		return ma;
	}
	
	@RequestMapping(value ="admin/updateBoard.do", method =RequestMethod.GET)
	public ModelAndView aUpdate(int no, HttpSession sen)
	{
		Map map = new HashMap();
		map.put("ername", sen.getAttribute("ername"));
		map.put("no",no);
		ModelAndView ma = new ModelAndView();
		ma.addObject("title", "글 수정");
		ma.addObject("info",sen.getAttribute("ername"));
		ma.addObject("b", bdao.getBoard(map));
		return ma;
	}
	@RequestMapping(value ="admin/updateBoard.do", method =RequestMethod.POST)
	public ModelAndView aUpdateSubmit(BoardVo b,HttpServletRequest request)
	{
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		MultipartFile uploadFile = b.getUploadFile();
		if(uploadFile!=null)
		{
			try {
					String fname = uploadFile.getOriginalFilename();
					byte data[] = uploadFile.getBytes();
					b.setFname(fname);
					
					FileOutputStream fos = new FileOutputStream(path+"/"+fname);
					fos.write(data);
					fos.close();
				
			} catch (Exception e) { System.out.println(e.getMessage());
				
				// TODO: handle exception
			}
		}
		
		
		
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		ma.addObject("title", "글 수정");
		ma.addObject("info", "비밀의화원");
		int re = bdao.update(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 수정 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	
	@RequestMapping("admin/deleteBoard.do")
	public ModelAndView aDelete(int no)
	{
		ModelAndView ma = new ModelAndView();
		ma.addObject("no", no);
		ma.addObject("title", "글 삭제");
		return ma;
	}
	
	@RequestMapping("admin/realdeleteBoard.do")
	public ModelAndView aRealDelete(int no,HttpSession sen)
	{
		Map map = new HashMap();
		map.put("ername", sen.getAttribute("ername"));
		map.put("no", no);
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		int re = bdao.deldte(map);
		if(re<1)
		{
			ma.addObject("msg","게시물 삭제 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	
	
	//=======================================================사용자용 끝==========================================================
	

	
	
	
	
	
	//=======================================================고객용 시작==========================================================
	
	

	@RequestMapping(value="/member/insertBoard.do", method =RequestMethod.GET)
	public ModelAndView mform(@RequestParam(value="no",defaultValue="0") int no, String id, HttpSession sen)
	{
		ModelAndView ma = new ModelAndView();
		String title="공지 작성";
		Map map = new HashMap();
		map.put("no", no);
		map.put("ername",sen.getAttribute("ername"));
		if (no!=0) 
		{
			title = "답변 작성";
			ma.addObject("pTitle","답변)"+bdao.getBoard(map).getTitle());
				
		}
		ma.addObject("no", no);
		ma.addObject("title", title);
		ma.addObject("id", id);
		return ma;
	}
	
	@RequestMapping(value="/member/insertBoard.do",method=RequestMethod.POST)
	public ModelAndView mSubmit(BoardVo b,HttpServletRequest request)
	{
		
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		

		MultipartFile uploadFile = b.getUploadFile();
		if(uploadFile!=null)
		{
			try {
					String fname = uploadFile.getOriginalFilename();
					byte data[] = uploadFile.getBytes();
					b.setFname(fname);
					
					FileOutputStream fos = new FileOutputStream(path+"/"+fname);
					fos.write(data);
					fos.close();
				
			} catch (Exception e) { System.out.println(e.getMessage());
				
				// TODO: handle exception
			}
		}
		Map map1 = new HashMap();
		map1.put("ername", b.getErname());
		
		int pno = b.getNo();
		int no = bdao.getNextNo(map1);
		
		b.setNo(no);
		int b_ref = no;
		int b_step = 0;
		int b_level = 0;
		
		map1.put("no", pno);
		
		
		if(pno!=0)
		{
			BoardVo p = bdao.getBoard(map1);
			b_ref = p.getB_ref();
			b_level = p.getB_level();
			b_step =p.getB_step();
			
			Map map = new HashMap();
			map.put("b_ref", b_ref);
			map.put("b_step", b_step);
			map.put("ername", p.getErname());
			bdao.updateStep(map);
			
			b_level++;
			b_step++;
			
		}

		b.setB_ref(b_ref);
		b.setB_level(b_level);
		b.setB_step(b_step);
		
		
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		b.setIp(request.getRemoteAddr());
		
		
		int re = bdao.insert(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 등록실패");
			ma.setViewName("error");
		}
		
		return ma;
	}
	
	
	
	
	
	@RequestMapping(value="/member/listBoard.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String mlistJson(String ername)
	{
		
		String str ="";
	
		Map map = new HashMap();
		ObjectMapper mapper = new ObjectMapper();
		map.put("ername", ername);
		try {
			str = mapper.writeValueAsString(bdao.getList(map));
			System.out.println("컨트롤러 str 받은 후:"+str);
			
		} catch (Exception e) { System.out.println(e.getMessage());
			// TODO: handle exception
		}
		return str;
	}

	@RequestMapping("member/detailBoard.do")
	public ModelAndView mGetBoard(int no, int cu, HttpSession sen)
	{
		ModelAndView ma = new ModelAndView();
		Map map = new HashMap();
		map.put("no", no);
		map.put("ername",sen.getAttribute("ername"));
		
		bdao.updateHit(map);
		ma.addObject("cu",cu);
		ma.addObject("rid",sen.getAttribute("id"));
		
		ma.addObject("b", bdao.getBoard(map));
		return ma;
	}
	
	@RequestMapping(value ="member/updateBoard.do", method =RequestMethod.GET)
	public ModelAndView mUpdate(HttpSession sen, int no)
	{
		
		Map map = new HashMap();
		map.put("ername", sen.getAttribute("ername"));
		map.put("no",no);
		ModelAndView ma = new ModelAndView();
		ma.addObject("title", "글 수정");
		ma.addObject("b", bdao.getBoard(map));
		return ma;
	}
	@RequestMapping(value ="member/updateBoard.do", method =RequestMethod.POST)
	public ModelAndView mUpdateSubmit(BoardVo b,HttpServletRequest request)
	{
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		MultipartFile uploadFile = b.getUploadFile();
		if(uploadFile!=null)
		{
			try {
					String fname = uploadFile.getOriginalFilename();
					byte data[] = uploadFile.getBytes();
					b.setFname(fname);
					
					FileOutputStream fos = new FileOutputStream(path+"/"+fname);
					fos.write(data);
					fos.close();
				
			} catch (Exception e) { System.out.println(e.getMessage());
				
				// TODO: handle exception
			}
		}
		
		
		
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		int re = bdao.update(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 수정 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	
	@RequestMapping("member/deleteBoard.do")
	public ModelAndView mDelete(int no,int cu)
	{
		ModelAndView ma = new ModelAndView();
		ma.addObject("no", no);
		ma.addObject("title", "글 삭제");
		ma.addObject("cu", cu);
		return ma;
	}
	
	@RequestMapping("member/realdeleteBoard.do")
	public ModelAndView mRealDelete(int no,HttpSession sen)
	{
		Map map = new HashMap();
		map.put("ername", sen.getAttribute("ername"));
		map.put("no", no);
		ModelAndView ma = new ModelAndView("redirect:/blist.do");
		int re = bdao.deldte(map);
		
		if(re<1)
		{
			ma.addObject("msg","게시물 삭제 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	
}
