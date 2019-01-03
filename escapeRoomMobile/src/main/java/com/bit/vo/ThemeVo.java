package com.bit.vo;

import org.springframework.web.multipart.MultipartFile;

public class ThemeVo {
	private int tcode;
	private String id;
	private String ername;
	private String tname;
	private String genre;
	private String content;
	private int tstar;
	private String fname;
	private int playtime;
	private int people;
	private int price;
	private String retime;
	
	private MultipartFile uploadFile;
	
	//escapeRoom¿« loc1, loc2
	private String loc1;
	private String loc2;
	
	public ThemeVo(int tcode, String id, String ername, String tname, String genre, String content, int tstar,
			String fname, int playtime, int people, int price, String retime, MultipartFile uploadFile, String loc1,
			String loc2) {
		super();
		this.tcode = tcode;
		this.id = id;
		this.ername = ername;
		this.tname = tname;
		this.genre = genre;
		this.content = content;
		this.tstar = tstar;
		this.fname = fname;
		this.playtime = playtime;
		this.people = people;
		this.price = price;
		this.retime = retime;
		this.uploadFile = uploadFile;
		this.loc1 = loc1;
		this.loc2 = loc2;
	}

	public ThemeVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getTcode() {
		return tcode;
	}

	public void setTcode(int tcode) {
		this.tcode = tcode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getErname() {
		return ername;
	}

	public void setErname(String ername) {
		this.ername = ername;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getTstar() {
		return tstar;
	}

	public void setTstar(int tstar) {
		this.tstar = tstar;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public int getPlaytime() {
		return playtime;
	}

	public void setPlaytime(int playtime) {
		this.playtime = playtime;
	}

	public int getPeople() {
		return people;
	}

	public void setPeople(int people) {
		this.people = people;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getRetime() {
		return retime;
	}

	public void setRetime(String retime) {
		this.retime = retime;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

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

}
