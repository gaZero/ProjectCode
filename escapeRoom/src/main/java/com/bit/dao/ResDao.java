package com.bit.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bit.db.CustomerManager;
import com.bit.db.ResManager;
import com.bit.vo.CustomerVo;
import com.bit.vo.ResVo;
import com.bit.vo.Theme_ResVo;

@Repository
public class ResDao {
	public List<ResVo> selectRes() {
		return ResManager.selectRes();
	}
	public List<Theme_ResVo> selTheme_res(Map map) {
		return ResManager.selTheme_res(map);
	}
	public int insertRes(ResVo rv) {
		return ResManager.insertRes(rv);
	}
	public List<ResVo> selMyRes(Map map) {
		return ResManager.selMyRes(map);
	}
	public int deleteRes(Map map) {
		return ResManager.deleteRes(map);
	}
	public ResVo selErRes(Map map) {
		return ResManager.selErRes(map);
	}
	public List<ResVo> mailToCustomer() {
		return ResManager.mailToCustomer();
	}
	public int updateStar(Map map) {
		return ResManager.updateStar(map);
	}
}
