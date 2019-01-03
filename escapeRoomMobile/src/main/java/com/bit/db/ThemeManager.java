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

	public static List<ThemeVo> listAll(Map map)
	{
		List<ThemeVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("theme.selectAll", map);
		session.close();
		return list;
	}

	public static ThemeVo selectOne(Map map)
	{
		SqlSession session = factory.openSession();
		ThemeVo vo = session.selectOne("theme.selectOne", map);
		session.close();
		return vo;
	}
	
	public static ThemeVo selTheme_tcode(Map map) {
		SqlSession session = factory.openSession();
		ThemeVo tv = session.selectOne("theme.selTheme_tcode", map);
		session.close();
		return tv;
	}
}
