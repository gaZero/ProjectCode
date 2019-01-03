package com.bit.vo;

public class ResVo {
	private String resCode;
	private int resPeople;
	private int totalPrice;
	private int payType;
	private String theme_resCode;
	private String cid;
	private int star;

	//theme 조인시 사용	
	private String erid;
	private String loc1;
	private String loc2;
	private String ername;
	private String tname;
	private String bookDate;
	private int bookTime;
	
	//customer 조인시 사용
	private String name;	
	private String tel;
	private String email;
	
	public ResVo(String resCode, int resPeople, int totalPrice, int payType, String theme_resCode, String cid, int star,
			String erid, String loc1, String loc2, String ername, String tname, String bookDate, int bookTime,
			String name, String tel, String email) {
		super();
		this.resCode = resCode;
		this.resPeople = resPeople;
		this.totalPrice = totalPrice;
		this.payType = payType;
		this.theme_resCode = theme_resCode;
		this.cid = cid;
		this.star = star;
		this.erid = erid;
		this.loc1 = loc1;
		this.loc2 = loc2;
		this.ername = ername;
		this.tname = tname;
		this.bookDate = bookDate;
		this.bookTime = bookTime;
		this.name = name;
		this.tel = tel;
		this.email = email;
	}
	public ResVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getResCode() {
		return resCode;
	}
	public void setResCode(String resCode) {
		this.resCode = resCode;
	}
	public int getResPeople() {
		return resPeople;
	}
	public void setResPeople(int resPeople) {
		this.resPeople = resPeople;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getPayType() {
		return payType;
	}
	public void setPayType(int payType) {
		this.payType = payType;
	}
	public String getTheme_resCode() {
		return theme_resCode;
	}
	public void setTheme_resCode(String theme_resCode) {
		this.theme_resCode = theme_resCode;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getErid() {
		return erid;
	}
	public void setErid(String erid) {
		this.erid = erid;
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
}
