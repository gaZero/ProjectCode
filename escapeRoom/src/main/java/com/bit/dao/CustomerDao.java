package com.bit.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.bit.db.CustomerManager;
import com.bit.vo.CustomerVo;

@Repository
public class CustomerDao {

	public CustomerVo detailCustomer(Map map) {
		return CustomerManager.detailCustomer(map);
	}
	public int insertCustomer(CustomerVo rc)
	{
		return CustomerManager.insertCustomer(rc);
	}
	
	public CustomerVo selectCustomer(String id)
	{
		return CustomerManager.selectCustomer(id);
	}
	
	public int isMember(Map map)
	{
		return CustomerManager.isMember(map);
	}
	
	public int updateCustomer(CustomerVo rc)
	{
		return CustomerManager.updateCustomer(rc);
	}
	
	public int deleteCustomer(String id)
	{
		return CustomerManager.deleteCustomer(id);
	}
	
	public void logout(HttpSession session) {
		session.invalidate();
	}
}
