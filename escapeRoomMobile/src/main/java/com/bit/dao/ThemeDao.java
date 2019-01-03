package com.bit.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bit.db.ThemeManager;
import com.bit.vo.ThemeVo;

@Repository
public class ThemeDao {

	public List<ThemeVo> listAll(Map map)
	{
		return ThemeManager.listAll(map);
	}
	
	public ThemeVo selectOne(Map map) {
		return ThemeManager.selectOne(map);
	}
	
	public ThemeVo selTheme_tcode(Map map) {
		return ThemeManager.selTheme_tcode(map);
	}
}

