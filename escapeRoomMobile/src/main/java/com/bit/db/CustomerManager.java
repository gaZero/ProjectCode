package com.bit.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.vo.CustomerVo;
import com.bit.vo.ResVo;
import com.bit.vo.ThemeVo;

public class CustomerManager {

	private static SqlSessionFactory factory;
	
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit/db/resConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}

	public static int insertCustomer(CustomerVo rc) {
		int re = -9999;
		
		SqlSession session = factory.openSession(true);
		re = session.insert("customer.insertCustomer", rc);
		
		session.close();
				
		return re;
	}
	
	public static CustomerVo selectCustomer(String id)
	{
		CustomerVo rc = null;
		
		Map map = new HashMap();
		map.put("id", id);
		
		SqlSession session = factory.openSession();
		rc = session.selectOne("customer.selectCustomer", map);
		
		session.close();
		
		return rc;
	}
		
	public static int updateCustomer(CustomerVo rc) {
		int re = -4321;
		
		SqlSession session = factory.openSession();
		re = session.update("customer.updateCustomer", rc);
	
		session.commit();
		session.close();
		
		
		return re;
	}
	
	public static int deleteCustomer(String id) {
		int re = -1234;
		
		Map map = new HashMap();
		map.put("id", id);
		
		SqlSession session = factory.openSession(true);
		re = session.delete("customer.deleteCustomer", map);
		
		session.close();
		
		return re;
	}
	
	public static int isMember(Map map) 
	{
		int re = -1;		
		SqlSession session = factory.openSession();
				
		String db_pwd = session.selectOne("customer.isPwd", map);
		String user_pwd = (String)map.get("pwd");
		
		if(db_pwd == null)
		{
			re = -1;		//아이디가 존재하지 않음.
		}
		else if(db_pwd.equals(user_pwd))
		{
			re = 1;			//올바른 회원
		}
		else
		{
			re = 0;			//패스워드가 틀림
		}
				
		session.close();
		return re;
	}
		
	public static String checkID(String id) {
		String str = "";
		
		SqlSession session = factory.openSession(true);
		str = session.selectOne(id);
		
		session.close();
		return str;
	}
	
}
