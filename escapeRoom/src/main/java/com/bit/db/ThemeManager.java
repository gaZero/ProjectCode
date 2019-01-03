package com.bit.db;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.vo.ResVo;
import com.bit.vo.ThemeVo;

public class ThemeManager {
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
	
	public static List<ThemeVo> selectTheme() {
		SqlSession session = factory.openSession();
		List<ThemeVo> list = session.selectList("theme.selectTheme");
		session.close();
		return list;
	}
	public static List<ThemeVo> selTheme_loc(Map map) {
		SqlSession session = factory.openSession();
		List<ThemeVo> list = session.selectList("theme.selTheme_loc", map);
		session.close();
		return list;
	}
	public static ThemeVo selTheme_tcode(Map map) {
		SqlSession session = factory.openSession();
		ThemeVo tv = session.selectOne("theme.selTheme_tcode", map);
		session.close();
		return tv;
	}
	public static List<ThemeVo> selTheme_id(Map map) {
		SqlSession session = factory.openSession();
		List<ThemeVo> list = session.selectList("theme.selTheme_id", map);
		session.close();
		return list;
	}
	public static int insert(ThemeVo vo)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.insert("theme.insert",vo);
		session.commit();
		session.close();
		return re;
	}
	
	public static List<ThemeVo> listAll(Map map)
	{
		List<ThemeVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("theme.selectAll", map);
		session.close();
		return list;
	}
	
	public static ThemeVo selectErname(Map map) 
	{
		SqlSession session = factory.openSession();
		ThemeVo vo = session.selectOne("theme.selectErname", map);
		session.close();
		return vo;
	}
	
	public static ThemeVo selectOne(Map map)
	{
		SqlSession session = factory.openSession();
		ThemeVo vo = session.selectOne("theme.selectOne", map);
		session.close();
		return vo;
	}
	
	public static int update(ThemeVo vo)
	{
		SqlSession session = factory.openSession();
		int re = session.update("theme.update", vo);
		System.out.println(vo.getTcode());
		session.commit();
		session.close();
		return re;
	}
	
	/////////////////////////////////////////////delete///////////
	public static int delete(Map map)
	{
		int re = -1;
		SqlSession session = factory.openSession();
		re = session.delete("theme.delete",map);
		session.commit();
		session.close();
		return re;
	}
}
