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
	
	
	public static EsRoomVo selectDetail(String ername) {
		SqlSession session = factory.openSession();
		EsRoomVo ev = null;
		ev = session.selectOne("esroom.selectDetail", ername);
		session.close();
		return ev;
	}

	
	
	public static EsRoomVo esroomDetail(String id) {
		SqlSession session = factory.openSession();
		EsRoomVo ev = null;
		ev = session.selectOne("esroom.esroomDetail", id);
		session.close();
		return ev;
	}
	

	public static int totalCount() {
		SqlSession session = factory.openSession();
		int cnt = session.selectOne("esroom.totalCount");
		session.close();
		return cnt;
	}
	
	public static int insertRoom(EsRoomVo vo) {
		SqlSession session = factory.openSession();
		int re = session.insert("esroom.insertRoom", vo);
		session.commit();
		session.close();
		return re;
	}
	
	public static int updateRoom(EsRoomVo vo) {
		SqlSession session = factory.openSession();
		int re = session.update("esroom.updateRoom", vo);
		session.commit();
		session.close();
		return re;
	}
	
	public static int deleteRoom(String id) {
		Map map = new HashMap();
		map.put("id", id);
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.delete("esroom.deleteRoom", map);
		session.commit();
		session.close();
		return re;
	}
	
	public static boolean isMember(Map map)
	{
		boolean r = false;
		SqlSession session = factory.openSession();
		EsRoomVo vo = session.selectOne("esroom.isMember", map);
		if(vo != null)
		{
			r = true;
		}
		session.close();
		return r;
	}

	
	public static void logout(HttpSession session) {
	
	}
	
	public static boolean isMine(Map map)
	{
		boolean r = false;
		SqlSession session = factory.openSession();
		EsRoomVo vo = session.selectOne("esroom.isMine", map);
		if(vo != null)
		{
			r = true;
		}
		session.close();
		return r;
	}

}
