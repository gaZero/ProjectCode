package com.bit.vo;

import org.springframework.web.multipart.MultipartFile;

public class EsRoomVo {
	private String loc1;
	private String loc2;
	private String ername;
	private String id;
	private String pwd;
	private String name;
	private String tel;
	private String email;
	private int room;
	private MultipartFile uploadFile;
	
	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	private String fname;
	private String addr;
	public String getLoc1() {
		return loc1;
	}
	public void setLoc1(String loc1) {
		this.loc1 = loc1;
	}
	public String getLoc2() {
		return loc2;
	}
	public void setLoc2(String loc2) {
		this.loc2 = loc2;
	}
	public String getErname() {
		return ername;
	}
	public void setErname(String ername) {
		this.ername = ername;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}

	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public EsRoomVo(String loc1, String loc2, String ername, String id, String pwd, String name, String tel,
			String email, int room, String fname, String addr) {
		super();
		this.loc1 = loc1;
		this.loc2 = loc2;
		this.ername = ername;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.tel = tel;
		this.email = email;
		this.room = room;
		this.fname = fname;
		this.addr = addr;
	}
	public EsRoomVo() {
		super();
		// TODO Auto-generated constructor stub
	}


	
}
