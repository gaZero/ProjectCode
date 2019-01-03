package com.bit.escapeMb;




import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit.dao.BoardDao;

import com.bit.vo.BoardVo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.rcaller.rStuff.RCaller;
import com.github.rcaller.rStuff.RCode;


@Controller
public class MobileController {

	@Autowired
	private BoardDao bdao;

	public void setBdao(BoardDao bdao) {
		this.bdao = bdao;
	}
	
	@RequestMapping(value="/listmbBoard.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String showlist(HttpSession session)
	{
		
		String str ="";
	
		Map map = new HashMap();
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(session.getAttribute("ername"));
		map.put("ername", session.getAttribute("ername"));
		try {
			str = mapper.writeValueAsString(bdao.getList(map));
			System.out.println("컨트롤러 str 받은 후:"+str);
			
		} catch (Exception e) { System.out.println(e.getMessage());
			// TODO: handle exception
		}
		return str;
	}
	
	@RequestMapping("/mbMain.do")
	public ModelAndView barPlot(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String path = request.getRealPath("resources/img");
		RCaller caller = new RCaller();
		caller.setRscriptExecutable("C:\\Program Files\\R\\R-3.5.1\\bin\\x64\\Rscript.exe");
		
		RCode code = new RCode();
		code.clear();
		
		File file;
		try {
			file = code.startPlot();
			code.addRCode("library(DBI)");
			code.addRCode("library(RODBC)");
			code.addRCode("library(RColorBrewer)");
			code.addRCode("library(scales)");
			code.addRCode("library(ggplot2	)");
			code.addRCode("sql = 'select tname 테마명, round(avg(star),2) 별점, count(*) 예약수 from theme t, theme_res tr, reservation r "
					+ "where t.tcode = tr.tcode and tr.theme_rescode = r.theme_rescode group by t.tname'");
			code.addRCode("db = odbcConnect('escape','madang','madang')");
			code.addRCode("star = sqlQuery(db,sql)");
			code.addRCode("ggplot(data=star, aes(reorder(테마명,-별점), 별점, fill=factor(예약수))) + geom_bar(stat='identity', position='dodge')" + 
					"+ labs(x = ' ', factor=' ') + scale_fill_brewer(palette = \"Greens\", name='예약수') + theme(legend.position = 'bottom')");
			code.endPlot();
			
			caller.setRCode(code);
			caller.runOnly();
			//code.showPlot(file);	//만든 plot 보여줘
			
			String fname = file.getName();
			mav.addObject("fname",fname);
			
			FileInputStream fis = new FileInputStream(file);
			FileOutputStream fos = new FileOutputStream(path+"/"+fname);

			FileCopyUtils.copy(fis, fos);
			fis.close();
			fos.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mav;
	}
	
	@RequestMapping("/mbBoard.do")
	public void mbBoard(HttpServletRequest request,HttpSession sen)
	{		
		String str = request.getParameter("ername");
		
		if(str!= null)
		{
			String ername = UnicordEncoder.unicodeConvert(str);
			sen.setAttribute("ername", ername);
			
		}else
		{
			String ername = (String)sen.getAttribute("ername");
		}
		
		
	}
	
	@RequestMapping(value ="insertMBoard.do", method=RequestMethod.GET)
	public ModelAndView mform(@RequestParam(value="no",defaultValue="0") int no, String id, HttpSession sen)
	{
		ModelAndView ma = new ModelAndView();
		
		Map map = new HashMap();
		map.put("no", no);
		String ername = UnicordEncoder.unicodeConvert((String)sen.getAttribute("ername"));
		map.put("ername", ername);
		ma.addObject("no", no);
		ma.addObject("id", sen.getAttribute("id"));
		return ma;
	}
	
	@RequestMapping(value="insertMBoard.do",method=RequestMethod.POST)
	public ModelAndView mSubmit(BoardVo b,HttpServletRequest request,HttpSession sen, HttpServletResponse response)
	{
		
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		

		MultipartFile uploadFile = b.getUploadFile();
		
		b.setFname("");
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
		
		String urlen = (String)sen.getAttribute("ername");
		String r4e = UnicordEncoder.unicodeConvert(urlen);
		
		
		b.setIp(request.getRemoteAddr());
		ModelAndView ma = new ModelAndView("mbBoard");
		
		int re = bdao.insert(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 등록실패");
			ma.setViewName("error");
		}
		
		return ma;
	}
	
	
	@RequestMapping("mdetailBoard.do")
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
	
	
	@RequestMapping(value ="mbUpdateBoard.do", method =RequestMethod.GET)
	public ModelAndView mUpdate(HttpSession sen, int no)
	{
		
		ModelAndView ma = new ModelAndView();
		Map map = new HashMap();
		map.put("no", no);
		String ername = UnicordEncoder.unicodeConvert((String)sen.getAttribute("ername"));
		map.put("ername", ername);
		ma.addObject("no", no);
		ma.addObject("id", sen.getAttribute("id"));
		ma.addObject("b", bdao.getBoard(map));
		return ma;
	}
	@RequestMapping(value ="mbUpdateBoard.do", method =RequestMethod.POST)
	public ModelAndView mUpdateSubmit(BoardVo b,HttpServletRequest request)
	{
		String path = request.getRealPath("resources/upload");
		System.out.println(path);
		MultipartFile uploadFile = b.getUploadFile();
		
		b.setFname("");
		Map map1 = new HashMap();
		map1.put("ername", b.getErname());
		
		
		ModelAndView ma = new ModelAndView();
		ma.setViewName("mbBoard");
		
		int re = bdao.update(b);
		if(re<1)
		{
			ma.addObject("msg","게시물 수정 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	@RequestMapping("mbDeleteBoard.do")
	public ModelAndView mDelete(int no,int cu)
	{
		ModelAndView ma = new ModelAndView();
		ma.addObject("no", no);
		ma.addObject("title", "글 삭제");
		ma.addObject("cu", cu);
		return ma;
	}
	
	@RequestMapping("mbrealdeleteBoard.do")
	public ModelAndView mRealDelete(int no,HttpSession sen)
	{
		Map map = new HashMap();
		map.put("ername", sen.getAttribute("ername"));
		map.put("no", no);
		ModelAndView ma = new ModelAndView();
		ma.setViewName("mbBoard");
		int re = bdao.deldte(map);
		
		if(re<1)
		{
			ma.addObject("msg","게시물 삭제 실패");
			ma.setViewName("error");
		}
		return ma;
	}
	
	

}
