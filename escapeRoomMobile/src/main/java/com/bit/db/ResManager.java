package com.bit.db;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.vo.CustomerVo;
import com.bit.vo.ResVo;
import com.bit.vo.Theme_ResVo;

public class ResManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit/db/resConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	public static List<ResVo> selMyRes(Map map) {
		SqlSession session = factory.openSession();
		List<ResVo> list = session.selectList("reservation.selMyRes", map);
		session.close();
		return list;
	}
	
	public static int insertRes(ResVo rv) {
		SqlSession session = factory.openSession();
		int re1 = session.insert("reservation.insertRes", rv);
		int re2 = session.update("reservation.upTheme_res", rv);
		int re = re1 + re2;
		if(re < 2) {
			session.rollback();
		} else {
			session.commit();
		}
		session.close();
		return re;
	}
	public static int deleteRes(Map map) {
		SqlSession session = factory.openSession();
		int re1 = session.delete("reservation.deleteRes", map);
		int re2 = session.update("reservation.upTheme_reset", map);
		int re = re1 + re2;
		if(re < 2) {
			session.rollback();
		} else {
			session.commit();
		}
		session.close();
		return re;
	}
	
	public static List<Theme_ResVo> selTheme_res(Map map) {
		SqlSession session = factory.openSession();
		List<Theme_ResVo> list = session.selectList("reservation.selTheme_res", map);
		session.close();
		return list;
	}
	
	public static int updateStar(Map map) {
		SqlSession session = factory.openSession(true);
		int re = session.insert("reservation.updateStar", map);		
		session.close();
		return re;
	}
}
