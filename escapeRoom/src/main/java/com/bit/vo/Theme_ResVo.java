package com.bit.vo;

public class Theme_ResVo {
	private String theme_resCode;
	private String tcode;
	private String bookDate;
	private int bookTime;
	private String resCode;
	private String erid;
	
	public Theme_ResVo(String theme_resCode, String tcode, String bookDate, int bookTime, String resCode, String erId) {
		super();
		this.theme_resCode = theme_resCode;
		this.tcode = tcode;
		this.bookDate = bookDate;
		this.bookTime = bookTime;
		this.resCode = resCode;
		this.erid = erId;
	}
	public Theme_ResVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getTheme_resCode() {
		return theme_resCode;
	}
	public void setTheme_resCode(String theme_resCode) {
		this.theme_resCode = theme_resCode;
	}
	public String getTcode() {
		return tcode;
	}
	public void setTcode(String tcode) {
		this.tcode = tcode;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public int getBookTime() {
		return bookTime;
	}
	public void setBookTime(int bookTime) {
		this.bookTime = bookTime;
	}
	public String getResCode() {
		return resCode;
	}
	public void setResCode(String resCode) {
		this.resCode = resCode;
	}
	public String getErid() {
		return erid;
	}
	public void setErId(String erId) {
		this.erid = erid;
	}
}
