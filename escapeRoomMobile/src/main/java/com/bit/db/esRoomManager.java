package com.bit.db;


import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.vo.EsRoomVo;

public class esRoomManager {
	
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
	
	
	public static List<EsRoomVo> select(HashMap map) {
		SqlSession session = factory.openSession();
		
		List<EsRoomVo> list = null;
		list = session.selectList("esroom.selectAll",map);
		session.close();
		return list;
	}
	

}
