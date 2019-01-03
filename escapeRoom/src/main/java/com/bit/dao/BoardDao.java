package com.bit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bit.db.BoardManaer;
import com.bit.vo.BoardVo;

@Repository
public class BoardDao {

	public int updateHit(Map map)
	{
		return BoardManaer.updateHit(map);
	}
	
	public int insert (BoardVo b)
	{
		return BoardManaer.insert(b);
	}
	public int update(BoardVo b)
	{
		return BoardManaer.update(b);
	}
	
	public int deldte(Map map)
	{
		return BoardManaer.delete(map);
	
	}
	
	public int updateStep(Map map)
	{
		return BoardManaer.updateStep(map);
	}
	
	
	public List<BoardVo> getList(Map map)
	{
		return BoardManaer.getList(map);
	}
	
	public List<BoardVo> getNoti(Map map)
	{
		return BoardManaer.getNoti(map);
	}
	
	
	
	public BoardVo getBoard(Map map)
	{
		
		return BoardManaer.getBoard(map);
	}
	public BoardVo getDetail(Map map)
	{
		
		return BoardManaer.getDetail(map);
	}
	
	public int getNextNo(Map map)
	{
		return BoardManaer.getNextNo(map);
	}
}
