package com.bit.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bit.db.ThemeManager;
import com.bit.vo.ThemeVo;

@Repository
public class ThemeDao {
	public List<ThemeVo> selectTheme() {
		return ThemeManager.selectTheme();
	}
	public List<ThemeVo> selTheme_loc(Map map) {
		return ThemeManager.selTheme_loc(map);
	}
	public ThemeVo selTheme_tcode(Map map) {
		return ThemeManager.selTheme_tcode(map);
	}
	public List<ThemeVo> selTheme_id(Map map) {
		return ThemeManager.selTheme_id(map);
	}
	public int insert(ThemeVo vo)
	{
		return ThemeManager.insert(vo);
	}
	public List<ThemeVo> listAll(Map map)
	{
		return ThemeManager.listAll(map);
	}
	
	public ThemeVo selectErname(Map map) {
		return ThemeManager.selectErname(map);
	}
	
	public ThemeVo selectOne(Map map) {
		return ThemeManager.selectOne(map);
	}
	
	public int update(ThemeVo vo)
	{
		return ThemeManager.update(vo);
	}
	
	public int delete(Map map)
	{
		return ThemeManager.delete(map);
	}
}
