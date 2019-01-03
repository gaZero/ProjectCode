package com.bit.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardVo {
	private String ername;
	private int btype;
	private int no;
	private String title;
	private String content;
	private String id;
	private String ip;
	private int hit;
	private String wdate;
	private int b_ref;
	private int b_level;
	private int b_step;
	private String fname;
	
	
	private MultipartFile uploadFile;
	
	
	
	
	public String getErname() {
		return ername;
	}
	public void setErname(String ername) {
		this.ername = ername;
	}
	public int getBtype() {
		return btype;
	}
	public void setBtype(int btype) {
		this.btype = btype;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getB_ref() {
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public int getB_level() {
		return b_level;
	}
	public void setB_level(int b_level) {
		this.b_level = b_level;
	}
	public int getB_step() {
		return b_step;
	}
	public void setB_step(int b_step) {
		this.b_step = b_step;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public BoardVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardVo(String ername, int btype, int no, String title, String content, String id, String ip, int hit,
			String wdate, int b_ref, int b_level, int b_step, String fname) {
		super();
		this.ername = ername;
		this.btype = btype;
		this.no = no;
		this.title = title;
		this.content = content;
		this.id = id;
		this.ip = ip;
		this.hit = hit;
		this.wdate = wdate;
		this.b_ref = b_ref;
		this.b_level = b_level;
		this.b_step = b_step;
		this.fname = fname;
	}
	

	
	
	
}
