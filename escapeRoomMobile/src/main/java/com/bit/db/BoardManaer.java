package com.bit.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit.vo.BoardVo;

public class BoardManaer {
	private static SqlSessionFactory factory;
	
	static {
		
		try {
			String resource = "com/bit/db/resConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			factory =
			  new SqlSessionFactoryBuilder().build(inputStream);
			
		} catch (Exception e) { System.out.println(e.getMessage());
			// TODO: handle exception
		}
		
	}
	public static int updateHit(Map map)
	{
		
		int re = -1;
		SqlSession sen = factory.openSession();
		re =sen.update("board.updateHit",map);
		sen.commit();
		sen.close();
		return re;
	}
	
	
	public static int getNextNo(Map map)
	{
		int no =0;
		SqlSession sen = factory.openSession();
		no = sen.selectOne("board.nextNo",map);
		sen.close();
		return no;
	}
	
	public static int insert(BoardVo  b)
	{
		int re = -1;
		SqlSession sen = factory.openSession();
		re= sen.insert("board.insert",b);
		sen.commit();
		sen.close();
		
		return re;
		
	}
	
	
	public static List<BoardVo> getList(Map map)
	{
		List<BoardVo> list = null;
		SqlSession sen = factory.openSession();
		list = sen.selectList("board.getList",map);
		return list;
		
	}
	
	public static List<BoardVo> getNoti(Map map)
	{
		List<BoardVo> list = null;
		SqlSession sen = factory.openSession();
		
		list = sen.selectList("board.getnoti",map);
		
		return list;
		
	}
	
	
	
	
	
	public static BoardVo getBoard(Map map)
	{
		BoardVo b= new BoardVo();
		SqlSession sen = factory.openSession();
		b = sen.selectOne("board.getBoard",map);
		return b;
	}
	public static BoardVo getDetail(Map map)
	{
		BoardVo b= new BoardVo();
		SqlSession sen = factory.openSession();
		b = sen.selectOne("board.getDetail",map);
		return b;
	}
	
	public static int update(BoardVo b)
	{
		int re = -1;
		SqlSession sen = factory.openSession();
		re= sen.update("board.update",b);
		sen.commit();
		sen.close();
		return re;
	}
	
	public static int delete(Map map)
	{
		int re = -1;
		SqlSession sen = factory.openSession();
		re=sen.delete("board.delete",map);
		sen.commit();
		sen.close();
		return re;	
	}
	
	public static int updateStep(Map map)
	{
		int re = -1;
		SqlSession sen = factory.openSession();
		re = sen.update("board.updateStep",map);
		sen.commit();
		sen.close();
		return re;
	}
}
