package com.bit.vo;

public class CustomerVo {

	private String id;
	private String pwd;
	private String name;
	private String tel;
	private String email;
	
	public CustomerVo(String id, String pwd, String name, String tel, String email) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.tel = tel;
		this.email = email;
	}
	public CustomerVo() {
		super();
		// TODO Auto-generated constructor stub
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
}
	
