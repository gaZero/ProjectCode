package com.bit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.bit.db.esRoomManager;
import com.bit.vo.EsRoomVo;

@Repository
public class EsRoomDao {
	
	public static List<EsRoomVo> listRoom(HashMap map){
		return esRoomManager.select(map);
	}


}
